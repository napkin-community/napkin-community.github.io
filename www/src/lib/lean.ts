export interface LeanItem {
  /** Anchor id matching the typst filename scheme: '1-1-1' or 'problem-11b' */
  id: string;
  /** TOC label: 'Example 1.1.1', 'Question 1.1.10', 'Problem 11B†' */
  display: string;
  /** Verbatim source segment, doc strings included */
  code: string;
}

export const leanChapterPattern = /^Chapter([0-9]+)\.lean$/;

// '# Problem 11B† (Product of traces)'
const problemHeading = /^#\s+Problem\s+([0-9]+[A-Z]+)(†?)/;
// '# Example 1.1.1 (Additive integers)', '# Question 1.1.10. Why do we ...'
const dottedHeading = /^#\s+([A-Za-z]+)\s+([0-9]+(?:\.[0-9]+)+)/;

function parseHeading(heading: string): Pick<LeanItem, 'id' | 'display'> {
  const problem = problemHeading.exec(heading);
  if (problem) {
    // The dagger stays in the display but not in the id, so a future
    // typst solution (e.g. Napkin-11B.typ) merges onto the same anchor.
    return {
      id: `problem-${problem[1].toLowerCase()}`,
      display: `Problem ${problem[1]}${problem[2]}`,
    };
  }
  const dotted = dottedHeading.exec(heading);
  if (dotted) {
    return {
      id: dotted[2].replaceAll('.', '-'),
      display: `${dotted[1]} ${dotted[2]}`,
    };
  }
  throw new Error(`Unrecognized Lean doc string heading: ${heading}`);
}

const occurrences = (line: string, token: string) =>
  line.split(token).length - 1;

/**
 * Split a Lean module into per-problem segments. An item starts at a doc
 * string whose content has a markdown heading ('# Example 1.1.1 ...') and
 * spans until the next such doc string. Doc strings without a heading
 * ('(b) ...', '• ...') continue the current item. Everything before the
 * first item (imports etc.) is dropped.
 */
export function parseLeanModule(source: string): LeanItem[] {
  const lines = source.split('\n');
  const starts: { line: number; heading: string }[] = [];

  let i = 0;
  while (i < lines.length) {
    const trimmed = lines[i].trimStart();
    if (!trimmed.startsWith('/-')) {
      i++;
      continue;
    }
    // Walk past the whole (possibly nested) comment, collecting its lines
    // so nothing inside it can be mistaken for another comment opener.
    const start = i;
    const comment = [];
    let depth = 0;
    do {
      depth += occurrences(lines[i], '/-') - occurrences(lines[i], '-/');
      comment.push(lines[i]);
      i++;
    } while (depth > 0 && i < lines.length);

    if (!trimmed.startsWith('/--')) continue; // plain comment, not a doc string

    const heading = comment
      .map((line) => line.trim().replace(/^\/--/, '').trim())
      .find((line) => line.startsWith('# '));
    if (heading !== undefined) starts.push({ line: start, heading });
  }

  const seen = new Set<string>();
  return starts.map(({ line, heading }, index) => {
    const { id, display } = parseHeading(heading);
    if (seen.has(id)) throw new Error(`Duplicate Lean item id: ${id}`);
    seen.add(id);

    const end = index + 1 < starts.length ? starts[index + 1].line : undefined;
    return { id, display, code: lines.slice(line, end).join('\n').trim() };
  });
}
