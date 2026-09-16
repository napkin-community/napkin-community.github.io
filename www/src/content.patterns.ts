/**
 * The file-name patterns that decide which source files become site pages.
 *
 * These live here, and not in `content.config.ts`, because that file
 * imports the `astro:content` virtual module, so nothing outside an Astro
 * build can read it.
 */

export interface CollectionPattern {
  /** Directory the pattern is resolved against, relative to `www/`. */
  base: string;
  /** Glob, in the extglob dialect `picomatch` and Astro's loader share. */
  pattern: string;
}

export const collectionPatterns = {
  aFewHarderProblems: {
    base: '../typst',
    pattern: 'Napkin-+([0-9])+([A-Z]).typ',
  },
  exercises: {
    base: '../typst',
    pattern: 'Napkin-+([0-9]).+([.0-9]).typ',
  },
  le14: {
    base: '../typst',
    pattern: 'Le14-+([.0-9]).typ',
  },
  hatcher: {
    base: '../typst',
    pattern: 'Hatcher-+([.0-9]).typ',
  },
  hott: {
    base: '../typst',
    pattern: 'HoTT-+([.0-9]).typ',
  },
  leanProofs: {
    base: '../lean/NapkinProofs',
    pattern: 'Chapter+([0-9]).lean',
  },
} as const satisfies Record<string, CollectionPattern>;

export type CollectionName = keyof typeof collectionPatterns;
