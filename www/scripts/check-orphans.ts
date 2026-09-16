/**
 * Fail when a Typst solution compiles but doesn't reach a page.
 *
 * `typst/x check` compiles every `*.typ` it finds, so a file whose name does
 * not fit the collection globs in `src/content.patterns.ts` passes CI and
 * still doesn't get an id, anchor, or page.
 * By orphan, we mean that the file doesn't match a glob and doesn't call
 * `#skip-from-build()`. The skip marker is how a statement fragment says it's
 * meant to be included by another solution rather than published on its own.
 *
 * Run with `pnpm check:orphans`.
 */

import { readdirSync, readFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import path from 'node:path';
import picomatch from 'picomatch';
import { collectionPatterns } from '../src/content.patterns.ts';

/** Resolved against `www/`, matching how Astro resolves a collection base. */
const wwwDir = path.dirname(path.dirname(fileURLToPath(import.meta.url)));
const typstBase = '../typst';
const typstDir = path.resolve(wwwDir, typstBase);

/** Every glob that can turn a file in `typst/` into a page. */
const typstPatterns = Object.values(collectionPatterns)
  .filter(({ base }) => base === typstBase)
  .map(({ pattern }) => pattern);

if (typstPatterns.length === 0) {
  console.error(
    `No collection in src/content.patterns.ts has base '${typstBase}'. ` +
      'A check that inspects nothing cannot fail, so this is an error.',
  );
  process.exit(1);
}

/** `typst/lib/` holds the template and the user registry, not solutions. */
const candidates = readdirSync(typstDir, { withFileTypes: true })
  .filter((entry) => entry.isFile() && entry.name.endsWith('.typ'))
  .map((entry) => entry.name)
  .sort();

if (candidates.length === 0) {
  console.error(`No .typ files found in ${typstDir}.`);
  process.exit(1);
}

const isPublished = picomatch(typstPatterns);
const orphans = candidates.filter((name) => {
  if (isPublished(name)) return false;
  const source = readFileSync(path.join(typstDir, name), 'utf8');
  return !source.includes('#skip-from-build()');
});

console.log(
  `Checked ${candidates.length} files in typst/ against ` +
    `${typstPatterns.length} collection globs.`,
);

if (orphans.length > 0) {
  console.error('\nThese files compile but reach no page:\n');
  for (const name of orphans) console.error(`  typst/${name}`);
  console.error(
    '\nRename the file to fit one of these globs, or add ' +
      '`#skip-from-build()` if it is a fragment another solution includes:\n',
  );
  for (const pattern of typstPatterns) console.error(`  ${pattern}`);
  process.exit(1);
}

console.log('No orphans.');
