#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

#plain_box(title: "AT-2.1.19")[
  Compute the homology groups of the subspace of $I times I$ consisting of the four boundary
  edges plus all points in the interior whose first coordinate is rational.
]

#solution(users.kiwiyou)[
  $X subset.eq I times I$,
  $X = {0, 1} times I union I times {0, 1} union ((0, 1) inter QQ) times (0, 1)$.
  Let $A = I times {0, 1}$.

  #figure(
    caption: [$X$ (a comb of vertical segments), with $A$ its top and bottom edges],
    {
      import "@preview/cetz:0.4.1"
      import cetz.draw: *
      cetz.canvas(length: 1.3cm, {
        set-style(stroke: (cap: "round"))
        line((0, 1), (2, 1))
        line((0, 0), (2, 0))
        for i in range(0, 11) {
          line((i * 0.2, 0), (i * 0.2, 1))
        }
        content((-0.15, 0.5), $X$, anchor: "east")
        content((2.15, 0.08), $A$, anchor: "west")
      })
    },
  )

  Then $(X, A)$ is a good pair i.e. $A$ is a nonempty closed subspace of $X$ that is a
  deformation retract of some neighborhood in $X$.

  #blue_box[Theorem 2.13][
    If $X$ is a space and $A$ is a nonempty closed subspace that is a deformation retract of
    some neighborhood in $X$, then there is an exact sequence
    $
      dots.c -> tilde(H)_n (A) attach(->, t: i_*) tilde(H)_n (X) attach(->, t: j_*)
      tilde(H)_n (X slash A) attach(->, t: partial) tilde(H)_(n-1) (A) attach(->, t: i_*)
      tilde(H)_(n-1) (X) -> dots.c -> tilde(H)_0 (X slash A) -> 0
    $
    where $i$ is the inclusion $A arrow.hook X$ and $j$ is the quotient map $X -> X slash A$.
  ]

  By using theorem 2.13, the following diagram is a exact sequence.
  $
     dots.c -> & tilde(H)_2 (A) -> tilde(H)_2 (X) -> tilde(H)_2 (X slash A) \
    arrow.hook & tilde(H)_1 (A) -> tilde(H)_1 (X) -> tilde(H)_1 (X slash A) \
    arrow.hook & tilde(H)_0 (A) -> tilde(H)_0 (X) -> tilde(H)_0 (X slash A) -> 0
  $

  1\. Computing $tilde(H)_n (A)$. Use a #sym.Delta\-complex structure
  $v_0 attach(->, t: e_0) v_1$, $v_2 attach(->, t: e_1) v_3$, so that $partial (e_0) = v_1 - v_0$
  and $partial (e_1) = v_3 - v_2$:
  $
    C_2 (A) attach(->, t: partial_2) C_1 (A) attach(->, t: partial_1) C_0 (A) attach(->, t: partial_0)
    ZZ -> 0
  $
  with $C_2 (A) = chevron.l diameter chevron.r$, $C_1 (A) = chevron.l e_0, e_1 chevron.r$,
  $C_0 (A) = chevron.l v_0, v_1, v_2, v_3 chevron.r$, and
  $ker partial_0 = {sum_(i=0)^3 a_i v_i mid(|) sum_(i=0)^3 a_i = 0}$.
  $
    tilde(H)_0 (A) = (ker partial_0)/(im partial_1)
    = (chevron.l v_1 - v_0, v_3 - v_2, v_0 - v_3 chevron.r)
    / (chevron.l v_1 - v_0, v_3 - v_2 chevron.r)
    tilde.equiv ZZ. \
    tilde(H)_1 (A) = (ker partial_1)/(im partial_2) = {0}/{0} tilde.equiv 0. \
    tilde(H)_n (A) tilde.equiv 0 quad "for" n >= 2.
  $

  2\. Computing $tilde(H)_n (X slash A)$. Use a #sym.Delta\-complex structure with a single
  vertex $v_0$ and loops $e_i$ for $i in I = [0, 1] inter QQ$, so $partial (e_i) = 0$:

  #figure(
    caption: [$X slash A$, a wedge of circles],
    {
      import "@preview/cetz:0.4.1"
      import cetz.draw: *
      cetz.canvas(length: 1.1cm, {
        set-style(stroke: (cap: "round"))
        circle((0.3, 0), radius: 0.3)
        circle((0.55, 0), radius: 0.55)
        circle((0.8, 0), radius: 0.8)
        circle((0, 0), radius: 0.035, fill: black, stroke: none)
        content((1.7, 0.4), $dots$, anchor: "west")
      })
    },
  )

  $
    C_2 (X slash A) attach(->, t: partial_2) C_1 (X slash A) attach(->, t: partial_1)
    C_0 (X slash A) attach(->, t: partial_0) ZZ -> 0
  $
  with $C_2 (X slash A) = chevron.l diameter chevron.r$,
  $C_1 (X slash A) = chevron.l e_i mid(|) i in I chevron.r$,
  $C_0 (X slash A) = chevron.l v_0 chevron.r$.
  $
    tilde(H)_0 (X slash A) = (ker partial_0)/(im partial_1) = {0}/{0} = {0}. \
    tilde(H)_1 (X slash A) = (ker partial_1)/(im partial_2)
    = chevron.l e_i mid(|) i in I chevron.r / {0}
    = xor.big_(i in I) ZZ dot [e_i] tilde.equiv xor.big_NN ZZ. \
    tilde(H)_n (X slash A) tilde.equiv 0 quad "for" n >= 2.
  $

  Then,
  $
    attach(tilde(H)_n (A), b: tilde.equiv 0) -> tilde(H)_n (X) ->
    attach(tilde(H)_n (X slash A), b: tilde.equiv 0)
    quad => quad tilde(H)_n (X) tilde.equiv 0 quad "for" n >= 2.
  $
  $
    attach(tilde(H)_1 (A), b: tilde.equiv 0) arrow.hook & tilde(H)_1 (X) ->
    attach(tilde(H)_1 (X slash A), b: tilde.equiv xor.big_(i in I) ZZ) \
    arrow.hook & attach(tilde(H)_0 (A), b: tilde.equiv ZZ) ->
    attach(tilde(H)_0 (X), b: tilde.equiv 0 quad (because thin X "is path-connected")) ->
    attach(tilde(H)_0 (X slash A), b: tilde.equiv 0) -> 0
  $
  so we get the exact sequence
  $
    0 -> tilde(H)_1 (X) attach(->, t: alpha)
    limits(xor.big_(i in I) ZZ)^(tilde(H)_1 (X slash A))
    attach(->, t: beta) limits(ZZ)^(tilde(H)_0 (A)) -> 0
  $
  where $beta = lambda sum n_k [e_k]. thin sum n_k$, so
  $ker beta = {sum n_k [e_k] in xor.big ZZ dot [e] mid(|) sum n_k = 0}$.

  $alpha$ injective, $beta$ surjective, $ker beta = im alpha$.
  $therefore tilde(H)_1 (X) tilde.equiv ker beta$.

  Problem: "The map $partial$ will be constructed in the course of the proof."
]
