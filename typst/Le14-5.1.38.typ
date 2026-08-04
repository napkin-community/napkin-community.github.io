#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node
#let edge = fletcher.edge.with(marks: "-|>")

#plain_box(title: [#respect[Le14] 5.1.38])[
  In this exercise, you will prove Proposition 5.1.26, following the plan described after the statement of that proposition.

  #set enum(numbering: "(a)")
  + Let $cal(A)$ be a category with all products and equalizers. Let $D : bold(I) -> cal(A)$ be a diagram in $cal(A)$. Define maps
    $
      product_(I in bold(I)) D(I) limits(arrows.rr)^s_t product_(J ->^u K "in" bold(I)) D(K)
    $
    as follows: given $J ->^u K$ in $bold(I)$, the $u$-component of $s$ is the composite
    $
      product_(I in bold(I)) D(I) ->^("pr"_J) D(J) ->^(D u) D(K)
    $
    (where pr denotes a product projection), and the $u$-component of $t$ is $"pr"_K$.
    Let $L ->^p product_(I in bold(I)) D(I)$ be the equalizer of $s$ and $t$, and write $p_I$ for the $I$-component of $p$.
    Show that $(L ->^(p_I) D(I))_(I in bold(I))$ is a limit cone on $D$, thus proving Proposition 5.1.26(a).
  + Adapt the argument to prove Proposition 5.1.26(b).
]

#solution(users.ghost)[
  (a) Let $C$ be a category with all products and equalizers, $J$ be a small category, and $F : J -> C$ be a diagram.

  For every $j ->^f k$ in $J$, define $s_f, t_f : product_(i in I) F(i) -> F(k)$ as
  $
    s_f & = F(f) ∘ π_j \
    t_f & = π_k.
  $
  These induce maps $s, t : product_(i in I) F(i) -> product_(f in J(j, k)) F(k)$.

  Let $L ->^φ product_(i in I) F(i)$ be an equalizer of $s$ and $t$.
  We claim that $(L ->^(φ_i) F(i))_(i in I)$ is a limit cone of $F$.

  (i) $(L ->^(φ_i) F(i))_(i in I)$ is a cone.

  Let $j ->^f k$ in $J$. Since $L$ is an equalizer,
  $ s ∘ φ = t ∘ φ. $
  Then,
  $
               π_f ∘ s ∘ φ & = π_f ∘ t ∘ φ \
           => wide s_f ∘ φ & = t_f ∘ φ \
    => wide F(f) ∘ π_j ∘ φ & = π_k ∘ φ \
        => wide F(f) ∘ φ_j & = φ_k.
  $

  (ii) $(L ->^(φ_i) F(i))_(i in I)$ is a limit cone.

  Let $(A ->^(ψ_i) F(i))_(i in I)$ be a cone. Then the diagram
  $
    A ->^ψ product_(i in I) F(i) limits(arrows.rr)^s_t product_(f in J(j, k)) F(k)
  $
  is a fork ($because$ $(s ∘ ψ)_f = s_f ∘ ψ = F(f) ∘ π_j ∘ ψ = F(f) ∘ ψ_j$, $(t ∘ ψ)_f = t_f ∘ ψ = π_k ∘ ψ = ψ_k$, and $F(f) ∘ ψ_j = ψ_k$ for all $j ->^f k$).

  Thus there is a unique morphism $u : A -> L$ s.t.

  #align(center, diagram(
    node((0, 0), $A$, name: <A>),
    node((0, 1), $L$, name: <L>),
    node((1.6, 1), $product_(i in I) F(i)$, name: <P>),
    edge(<A>, <P>, label: $ψ$, label-side: left),
    edge(<A>, <L>, label: $u$, label-side: right, marks: "-->"),
    edge(<L>, <P>, label: $φ$, label-side: left),
  ))

  Then $u$ is the unique morphism s.t.

  #align(center, grid(
    columns: 2,
    gutter: 3em,
    align: horizon,
    diagram(
      node((0, 0), $A$, name: <A>),
      node((0, 1), $L$, name: <L>),
      node((1.6, 1), $F(i)$, name: <Fi>),
      edge(<A>, <Fi>, label: $ψ_i$, label-side: left),
      edge(<A>, <L>, label: $u$, label-side: right, marks: "-->"),
      edge(<L>, <Fi>, label: $φ_i$, label-side: left),
    ),
    [for all $i in I$.],
  ))

  $therefore$ $L$ is a limit cone. #h(1fr) #sym.qed

  (b) If binary product and terminal object exist, then every finite product exists.
  Rest of the proof is identical to (a).

  Sketch (motivation), for $F : J -> sans("Set")$:
  $
    lim F & ≅ [1, lim F] \
    & ≅ { "cones on" F "with apex" 1 } \
    & ≅ { (1 ->^(φ_i) F(i))_(i in I) mid(|) F(f) ∘ φ_i = φ_j "for all" i ->^f j } \
    & ≅ { (x_i in F(i))_(i in I) mid(|) f(x_i) = x_j "for all" i ->^f j }
  $
  $ L -> product_(i in I) F(i) limits(arrows.rr)^s_t product_f F(k) $
]
