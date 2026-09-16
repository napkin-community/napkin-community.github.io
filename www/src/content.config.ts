import { glob } from 'astro/loaders';
import { defineCollection } from 'astro:content';
import { collectionPatterns } from './content.patterns';

const aFewHarderProblems = defineCollection({
  loader: glob(collectionPatterns.aFewHarderProblems),
});

const exercises = defineCollection({
  loader: glob(collectionPatterns.exercises),
});

const le14 = defineCollection({
  loader: glob(collectionPatterns.le14),
});

const hatcher = defineCollection({
  loader: glob(collectionPatterns.hatcher),
});

const hott = defineCollection({
  loader: glob(collectionPatterns.hott),
});

const leanProofs = defineCollection({
  loader: glob(collectionPatterns.leanProofs),
});

export const collections = {
  aFewHarderProblems,
  exercises,
  le14,
  hatcher,
  hott,
  leanProofs,
};
