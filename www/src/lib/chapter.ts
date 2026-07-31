import { getCollection } from 'astro:content';
import { uniq } from 'es-toolkit';
import path from 'node:path';
import { readMetadata } from './typst';
import { naturalCompare } from './numberCompare';

export const books = ['Napkin', 'Le14', 'Hatcher', 'HoTT'] as const;
export type Book = (typeof books)[number];

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
        ]
      : (await getCollection(collectionOf[book])).map(({ filePath }) =>
          chapterOf(exercisePattern(book), filePath!),
        );

  return uniq(chapters).toSorted((a, b) => a - b);
}

export async function getChapterContents(book: Book, chapter: number) {
  if (book !== 'Napkin') {
    const contents = await getCollection(collectionOf[book]);
    return contents
      .filter(
        ({ filePath }) =>
          chapterOf(exercisePattern(book), filePath!) === chapter,
      )
      .map((content) => ({
        ...content,
        id: path
          .parse(content.filePath!)
          .name.replace(new RegExp(`^${book}-`), '')
          .replaceAll(/\./g, '-'),
        display: path
          .parse(content.filePath!)
          .name.replace(new RegExp(`^${book}-`), ''),
      }))
      .toSorted(({ id: a }, { id: b }) => naturalCompare(a, b));
  }

  const exercises = await getCollection('exercises');
  const aFewHarderProblems = await getCollection('aFewHarderProblems');

  const exercisesOrdered = (
    await Promise.all(
      exercises.map(async (content) => ({
        ...content,
        metadata: await readMetadata(content.body!),
      })),
    )
  )
    .filter(
      ({ filePath, metadata }) =>
        chapterOf(exercisePattern('Napkin'), filePath!) === chapter &&
        !metadata.skipFromBuild,
    )
    .toSorted(({ filePath: a }, { filePath: b }) => naturalCompare(a!, b!));
  const problemsOrdered = aFewHarderProblems
    .filter(({ filePath }) => chapterOf(problemPattern, filePath!) === chapter)
    .toSorted(({ filePath: a }, { filePath: b }) => naturalCompare(a!, b!));

  return [
    ...exercisesOrdered.map((content) => ({
      ...content,
      id: path
        .parse(content.filePath!)
        .name.replace(/^Napkin-/, '')
        .replaceAll(/\./g, '-'),
      display: path.parse(content.filePath!).name.replace(/^Napkin-/, ''),
    })),
    ...problemsOrdered.map((content) => ({
      ...content,
      id: `problem-${path
        .parse(content.filePath!)
        .name.replace(/^Napkin-/, '')
        .toLowerCase()}`,
      display: `Problem ${path
        .parse(content.filePath!)
        .name.replace(/^Napkin-/, '')}`,
    })),
  ];
}
