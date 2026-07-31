Napkin Solutions
========
This repository serves solutions for the problems from the book, [An Infinitely
Large Napkin] by Evan Chen and contributors.

```bash
# Requires typst

cd www
pnpm i
pnpm dev
```

Following tools are recommended for a better contribution experience:

- [Espanso] - Write mathematics symbols outside Typst.
- [Typsi] - If you like typst-y symbol names, use this espanso package.

This project uses the following fonts.

- [Latin Modern Sans] for `#blue_box`.
- [Hakgyoansim Bareonbatang] for Korean.

See the `typst/x` helper for registering a new contributor or capturing a
rendered solution as an image:

```console
$ typst/x
typst/x - Napkin Utilities

Usage:
  typst/x [<command>] [<args>]
  typst/x [-h | --help]

  register <github-handle>      Fetch GitHub profile from handle and download
                                the profile to register it to users
  check                         Check whether the typst source file valid
  prepare-fonts                 Prepare fonts for Typst
  capture <filename.typ>        Capture the typst rendered using imagemagick
  -h, --help                    Display this help message
```

When editing the template styles, keep a live preview of the template API docs
open to see your changes as you go:

```bash
typst/x prepare-fonts
typst compile --font-path typst/fonts typst/lib/napkin-docs.{typ,pdf}
# See typst/lib/napkin-docs.pdf

# Watch mode
typst watch --font-path typst/fonts typst/lib/napkin-docs.{typ,pdf}
```

&nbsp;

--------

This project is primarily distributed under the terms of the
[GNU Affero General Public License v3.0] or any later version. See [COPYRIGHT]
for details.

[An Infinitely Large Napkin]: https://web.evanchen.cc/napkin.html
[Espanso]: https://espanso.org
[Typsi]: https://github.com/RanolP/typsi
[Latin Modern Sans]: https://www.gust.org.pl/projects/e-foundry/latin-modern
[Hakgyoansim Bareonbatang]: https://copyright.keris.or.kr/wft/fntDwnldView?fntGrpId=GFT202301120000000000002
[GNU Affero General Public License v3.0]: LICENSE
[COPYRIGHT]: COPYRIGHT
