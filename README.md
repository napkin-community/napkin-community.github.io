Napkin Solutions
========
This repository serves solutions for the problems from the book, [An Infinitely
Large Napkin] by Evan Chen and contributors, along with Lean 4 formal proofs of
the book.

The goal of this project is to port all existing solutions from the
<https://e.hyeon.me/napkin.svg> to Typst and formalize them in Lean.

```bash
cd www
pnpm i
pnpm dev
```

&nbsp;

Typst solutions
--------
The `typst/` directory contains Typst solutions of the book.

```bash
# Download fonts
typst/x prepare-fonts

# Check typst codes
typst/x check
typstyle --check typst

# New contributor registration
typst/x register <github-handle>

# Help
typst/x --help
```

Following tools are recommended for a better contribution experience:

- [typstyle] - Typst code formatter
- [Espanso] - Write mathematics symbols outside Typst.
- [RanolP/Typsi] - If you like typst-y symbol names, use this espanso package.

When editing the template styles, keep a live preview of the template API docs
open to see your changes as you go:

```bash
# Typst in watch mode, see typst/lib/napkin-docs.pdf
typst watch --font-path typst/fonts typst/lib/napkin-docs.{typ,pdf}
```

This project uses the following fonts.

- [Latin Modern Sans] for `#blue_box`.
- [Hakgyoansim Bareonbatang] for Korean.

&nbsp;

Lean proofs
--------
The `lean/` directory contains Lean 4 formal proofs of the book.

```bash
cd lean

# Build the project
lake build

# Type-check specific files in CLI
lake env lean NapkinProofs/Obviouslib.lean
lake env lean NapkinProofs/Chapter1.lean
```

### Learn Lean
<table>
<tr><th>Learning materials</th><th>References</th></tr>
<tr><td>

- Brief
  - [A Tour of Lean](https://lean-lang.org/documentation/1900-1-1-a-tour-of-lean/)
  - [Examples](https://lean-lang.org/examples/)
  - [Lean 4 tactic cheatsheet (pdf)](https://leanprover-community.github.io/papers/lean-tactics.pdf)
- Game
  - [The Natural Number Game](https://adam.math.hhu.de/#/g/leanprover-community/NNG4)
  - [Lean Game Server](https://adam.math.hhu.de/)
- Books
  - [Functional Programming in Lean (FPIL)](https://lean-lang.org/functional_programming_in_lean/)
  - [Theorem Proving in Lean (TPIL)](https://lean-lang.org/theorem_proving_in_lean4/)
  - [Mathematics in Lean (MIL)](https://leanprover-community.github.io/mathematics_in_lean/), [PDF version](https://leanprover-community.github.io/mathematics_in_lean/mathematics_in_lean.pdf)
- Further readings
  - [The Hitchhiker's Guide to Logical Verification (pdf)](https://rawcdn.githack.com/lean-forward/logical_verification_2025/76421700cb010aeddeb2b2a4a93e538b92b0e585/hitchhikers_guide_2025_tablet.pdf)
  - [Logic and Proof](https://leanprover-community.github.io/logic_and_proof/)
  - [The Mechanics of Proof](https://hrmacbeth.github.io/math2001/)
  - [Lean 4 VS Code extension manual](https://github.com/leanprover/vscode-lean4/blob/master/vscode-lean4/manual/manual.md)
  - [Metaprogramming in Lean 4](https://leanprover-community.github.io/lean4-metaprogramming-book/), [PDF version](https://github.com/leanprover-community/lean4-metaprogramming-book/releases/download/latest/Metaprogramming.in.Lean.4.pdf)
  - [Lean perfectoid spaces](https://leanprover-community.github.io/lean-perfectoid-spaces/type_theory.html)
  - [Type Checking in Lean 4](https://ammkrn.github.io/type_checking_in_lean4/)
  - [A glimpse of Lean](https://github.com/PatrickMassot/GlimpseOfLean)

</td><td>

- Docs
  - [Lean community](https://leanprover-community.github.io/)
  - [The Lean Language Reference](https://lean-lang.org/doc/reference/latest/)
  - [A mathlib overview](https://leanprover-community.github.io/mathlib-overview.html)
  - [Mathlib documentation](https://leanprover-community.github.io/mathlib4_docs/)
- Search
  - [Loogle](https://loogle.lean-lang.org/), [LeanExplore](https://www.leanexplore.com/), [Moogle](https://www.moogle.ai/), [LeanSearch](https://leansearch.net/), [Lean-Finder](https://huggingface.co/spaces/delta-lab-ai/Lean-Finder)
- LLM-based assist
  - [LeanDojo](https://leandojo.org/), [BFS-Prover-V2](https://bfs-prover.github.io/V2/), [Aristotle](https://aristotle.harmonic.fun)
- other resources
  - [REPL](https://github.com/leanprover-community/repl), [Pantograph](https://git.leni.sh/aniva/Pantograph), [Lean4Web](https://github.com/leanprover-community/lean4web)

</td></tr>
</table>

&nbsp;

--------

This project is primarily distributed under the terms of the
[GNU Affero General Public License v3.0] or any later version. See [COPYRIGHT]
for details.

[An Infinitely Large Napkin]: https://web.evanchen.cc/napkin.html
[Napkin archive]: https://e.hyeon.me/napkin-archive.svg
[typstyle]: https://typstyle-rs.github.io/typstyle/
[Espanso]: https://espanso.org
[RanolP/Typsi]: https://github.com/RanolP/typsi
[Latin Modern Sans]: https://www.gust.org.pl/projects/e-foundry/latin-modern
[Hakgyoansim Bareonbatang]: https://copyright.keris.or.kr/wft/fntDwnldView?fntGrpId=GFT202301120000000000002
[GNU Affero General Public License v3.0]: LICENSE
[COPYRIGHT]: COPYRIGHT
