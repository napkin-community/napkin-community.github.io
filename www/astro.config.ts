import type { AstroIntegration, ContentEntryType, HookParameters } from 'astro';
import { defineConfig } from 'astro/config';

// Reference: https://github.com/withastro/astro/blob/c46210d8db9/packages/integrations/mdx/src/index.ts#L29-L53
type SetupHookParams = HookParameters<'astro:config:setup'> & {
  addContentEntryType: (contentEntryType: ContentEntryType) => void;
};

function rawText(): AstroIntegration {
  return {
    name: 'astro-raw-text',
    hooks: {
      'astro:config:setup'(params) {
        const { addContentEntryType } = params as SetupHookParams;
        addContentEntryType({
          extensions: ['.typ', '.lean'],
          getEntryInfo({ contents }) {
            return {
              data: {},
              rawData: '',
              body: contents,
              // astro will fill this
              slug: '',
            };
          },
        });
      },
    },
  };
}

export default defineConfig({
  // The site used to be deployed at https://napkin-community.github.io/solutions/
  // with Napkin chapters at /solutions/<chapter>/ and the other books as single
  // pages at /solutions/<book>/. After the repo rename it is deployed at
  // https://napkin-community.github.io/ with every book at /<book>/<chapter>/.
  // Keep the old URLs alive by redirecting them to their new locations.
  redirects: {
    // Old main page
    '/solutions': '/',
    // Old Napkin chapter pages, now under /Napkin/. Frozen list: chapters
    // added after the move never had an old URL, so this never grows.
    ...Object.fromEntries(
      [1, 7, 8, 9, 10, 64, 65, 66, 67, 68, 70, 71].map((chapter) => [
        `/solutions/${chapter}`,
        `/Napkin/${chapter}`,
      ]),
    ),
    // Old single-page books, now split into per-chapter pages. Their old
    // page maps to the book's section anchor in the index.
    '/solutions/Le14': '/#Le14',
    '/solutions/Hatcher': '/#Hatcher',
    '/solutions/HoTT': '/#HoTT',
  },
  integrations: [rawText()],
  vite: {
    ssr: {
      external: ['@myriaddreamin/typst-ts-node-compiler'],
    },
  },
});
