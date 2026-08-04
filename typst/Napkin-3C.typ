#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node
#let edge = fletcher.edge.with(marks: "-|>")

#plain_box(title: [Problem 3C])[
  Does $S_4$ have a normal subgroup of order 3?
]

#solution(users.simnalamburt)[
  Let's say $G ⊴ S_4 and |G| = 3$.

  *Claim.* $G = chevron.l sigma | sigma^3 = 1 chevron.r$

  *Proof.*
  - if $G = chevron.l 1 chevron.r arrow |G| < 3$
  - if $G = chevron.l a, b, c chevron.r arrow |G| > 3$
  - if $G = chevron.l a, b chevron.r$, the condition must be $a^2 = a b = b^2 = 1$ to make sure $|G| = 3$. Then $a^2 = 1 arrow a = a^(-1)$ and $b^2 = 1 arrow b = b^(-1)$, so
    $ a b = 1 arrow a b b^(-1) = b^(-1) arrow a = b^(-1) = b, $
    contradiction.

  #align(center, grid(
    columns: 4,
    column-gutter: 1.5em,
    align: horizon,
    $sigma =$,
    diagram(
      spacing: (2.4em, 0.6em),
      node((0, 0), $a$),
      node((1, 0), $a$),
      node((0, 1), $b$),
      node((1, 1), $b$),
      node((0, 2), $c$),
      node((1, 2), $c$),
      node((0, 3), $d$),
      node((1, 3), $d$),
      edge((0, 0), (1, 1)),
      edge((0, 1), (1, 2)),
      edge((0, 2), (1, 0)),
      edge((0, 3), (1, 3)),
    ),
    $sigma^2 =$,
    diagram(
      spacing: (2.4em, 0.6em),
      node((0, 0), $a$),
      node((1, 0), $a$),
      node((0, 1), $b$),
      node((1, 1), $b$),
      node((0, 2), $c$),
      node((1, 2), $c$),
      node((0, 3), $d$),
      node((1, 3), $d$),
      edge((0, 0), (1, 2)),
      edge((0, 1), (1, 0)),
      edge((0, 2), (1, 1)),
      edge((0, 3), (1, 3)),
    ),
  ))

  Let's think such
  #align(center, grid(
    columns: 2,
    column-gutter: 0.75em,
    align: horizon,
    $g =$,
    diagram(
      spacing: (2.4em, 0.6em),
      node((0, 0), $a$),
      node((1, 0), $a$),
      node((0, 1), $b$),
      node((1, 1), $b$),
      node((0, 2), $c$),
      node((1, 2), $c$),
      node((0, 3), $d$),
      node((1, 3), $d$),
      edge((0, 0), (1, 0)),
      edge((0, 1), (1, 1)),
      edge((0, 2), (1, 3)),
      edge((0, 3), (1, 2)),
    ),
  ))

  $ G ⊴ S_4 arrow.l.r forall g in S_4, h in G, quad g h g^(-1) in G $

  ($a ▷ b = b(a)$)
  #align(center, grid(
    columns: 2,
    column-gutter: 0.75em,
    align: horizon,
    $x ▷ g^(-1) ▷ h ▷ g =$,
    diagram(
      spacing: (2.4em, 0.6em),
      node((0, 0), $a$),
      node((1, 0), $a$),
      node((2, 0), $a$),
      node((3, 0), $a$),
      node((0, 1), $b$),
      node((1, 1), $b$),
      node((2, 1), $b$),
      node((3, 1), $b$),
      node((0, 2), $c$),
      node((1, 2), $c$),
      node((2, 2), $c$),
      node((3, 2), $c$),
      node((0, 3), $d$),
      node((1, 3), $d$),
      node((2, 3), $d$),
      node((3, 3), $d$),
      edge((0, 0), (1, 0)),
      edge((0, 1), (1, 1)),
      edge((0, 2), (1, 3)),
      edge((0, 3), (1, 2)),
      edge((1, 0), (2, 1)),
      edge((1, 1), (2, 2)),
      edge((1, 2), (2, 0)),
      edge((1, 3), (2, 3)),
      edge((2, 0), (3, 0)),
      edge((2, 1), (3, 1)),
      edge((2, 2), (3, 3)),
      edge((2, 3), (3, 2)),
    ),
  ))
  #align(center, grid(
    columns: 3,
    column-gutter: 0.75em,
    align: horizon,
    $=$,
    diagram(
      spacing: (2.4em, 0.6em),
      node((0, 0), $a$),
      node((1, 0), $a$),
      node((0, 1), $b$),
      node((1, 1), $b$),
      node((0, 2), $c$),
      node((1, 2), $c$),
      node((0, 3), $d$),
      node((1, 3), $d$),
      edge((0, 0), (1, 1)),
      edge((0, 1), (1, 3)),
      edge((0, 2), (1, 2)),
      edge((0, 3), (1, 0)),
    ),
    $in.not G$,
  ))
  #h(1fr) #sym.qed
]
