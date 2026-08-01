import { getCollection } from 'astro:content';
import path from 'node:path';
import { readMetadata } from './typst';
import { naturalCompare } from './numberCompare';
import { parseLeanModule, leanChapterPattern } from './lean';

export const books = ['Napkin', 'Le14', 'Hatcher', 'HoTT'] as const;
export type Book = (typeof books)[number];

export interface ChapterItem {
  id: string;
  display: string;
  typstBody?: string;
  leanCode?: string;
}

const collectionOf = {
  Le14: 'le14',
  Hatcher: 'hatcher',
  HoTT: 'hott',
} as const;

const exercisePattern = (book: Book) =>
  new RegExp(`^${book}-([0-9]+)(?:\\.[0-9]+)+\\.typ$`);
const problemPattern = /^Napkin-([0-9]+)[A-Z]+\.typ$/;

function chapterOf(pattern: RegExp, filePath: string) {
  return Number(pattern.exec(path.basename(filePath))![1]);
}

export async function getChapters(book: Book) {
  const chapters =
    book === 'Napkin'
      ? [
          ...(await getCollection('exercises')).map(({ filePath }) =>
            chapterOf(exercisePattern('Napkin'), filePath!),
          ),
          ...(await getCollection('aFewHarderProblems')).map(({ filePath }) =>
            chapterOf(problemPattern, filePath!),
          ),
          ...(await getCollection('leanProofs')).map(({ filePath }) =>
            chapterOf(leanChapterPattern, filePath!),
          ),
        ]
      : (await getCollection(collectionOf[book])).map(({ filePath }) =>
          chapterOf(exercisePattern(book), filePath!),
        );

  return [...new Set(chapters)].toSorted((a, b) => a - b);
}

export async function getChapterContents(
  book: Book,
  chapter: number,
): Promise<ChapterItem[]> {
  if (book !== 'Napkin') {
    const contents = await getCollection(collectionOf[book]);
    return contents
      .filter(
        ({ filePath }) =>
          chapterOf(exercisePattern(book), filePath!) === chapter,
      )
      .map((content) => ({
        id: path
          .parse(content.filePath!)
          .name.replace(new RegExp(`^${book}-`), '')
          .replaceAll(/\./g, '-'),
        display: path
          .parse(content.filePath!)
          .name.replace(new RegExp(`^${book}-`), ''),
        typstBody: content.body!,
      }))
      .toSorted(({ id: a }, { id: b }) => naturalCompare(a, b));
  }

  const exercises = await getCollection('exercises');
  const aFewHarderProblems = await getCollection('aFewHarderProblems');
  const leanProofs = await getCollection('leanProofs');

  // Numbered exercises ('8.1.2') and lettered problems ('Problem 8A') are
  // kept in separate groups; problems always come after the exercises.
  const exerciseItems = new Map<string, ChapterItem>();
  const problemItems = new Map<string, ChapterItem>();

  for (const content of await Promise.all(
    exercises.map(async (content) => ({
      ...content,
      metadata: await readMetadata(content.body!),
    })),
  )) {
    if (
      chapterOf(exercisePattern('Napkin'), content.filePath!) !== chapter ||
      content.metadata.skipFromBuild
    )
      continue;
    const name = path.parse(content.filePath!).name.replace(/^Napkin-/, '');
    exerciseItems.set(name.replaceAll(/\./g, '-'), {
      id: name.replaceAll(/\./g, '-'),
      display: name,
      typstBody: content.body!,
    });
  }

  for (const content of aFewHarderProblems) {
    if (chapterOf(problemPattern, content.filePath!) !== chapter) continue;
    const name = path.parse(content.filePath!).name.replace(/^Napkin-/, '');
    problemItems.set(`problem-${name.toLowerCase()}`, {
      id: `problem-${name.toLowerCase()}`,
      display: `Problem ${name}`,
      typstBody: content.body!,
    });
  }

  // Merge the Lean formalizations in: an item that also has a typst solution
  // gets its Lean code (and the richer 'Example 1.1.1' label) attached, and
  // Lean-only items become standalone entries.
  const leanModule = leanProofs.find(
    ({ filePath }) => chapterOf(leanChapterPattern, filePath!) === chapter,
  );
  for (const { id, display, code } of leanModule
    ? parseLeanModule(leanModule.body!)
    : []) {
    const group = id.startsWith('problem-') ? problemItems : exerciseItems;
    const existing = group.get(id);
    if (existing) {
      existing.display = display;
      existing.leanCode = code;
    } else {
      group.set(id, { id, display, leanCode: code });
    }
  }

  const byId = ({ id: a }: ChapterItem, { id: b }: ChapterItem) =>
    naturalCompare(a, b);
  return [
    ...[...exerciseItems.values()].toSorted(byId),
    ...[...problemItems.values()].toSorted(byId),
  ];
}
