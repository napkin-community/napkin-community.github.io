import { glob } from 'astro/loaders';
import { defineCollection } from 'astro:content';

const aFewHarderProblems = defineCollection({
  loader: glob({
    base: '../typst',
    pattern: 'Napkin-+([0-9])+([A-Z]).typ',
  }),
});

const exercises = defineCollection({
  loader: glob({
    base: '../typst',
    pattern: 'Napkin-+([0-9]).+([.0-9]).typ',
  }),
});

const le14 = defineCollection({
  loader: glob({
    base: '../typst',
    pattern: 'Le14-+([.0-9]).typ',
  }),
});

const hatcher = defineCollection({
  loader: glob({
    base: '../typst',
    pattern: 'Hatcher-+([.0-9]).typ',
  }),
});

const hott = defineCollection({
  loader: glob({
    base: '../typst',
    pattern: 'HoTT-+([.0-9]).typ',
  }),
});

const leanProofs = defineCollection({
  loader: glob({
    base: '../lean/NapkinProofs',
    pattern: 'Chapter+([0-9]).lean',
  }),
});

export const collections = {
  aFewHarderProblems,
  exercises,
  le14,
  hatcher,
  hott,
  leanProofs,
};
