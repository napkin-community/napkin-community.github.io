#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

#chili(1)
#plain_box(title: [Problem 1F#daggered])[
  Let $G$ be a finite group.#footnote[In other words, permutation groups can
    be arbitrarily weird. I remember being highly unsettled by this theorem
    when I first heard of it, but in hindsight it is not so surprising.]
  Show that there exists a positive integer $n$ such that
  #set enum(numbering: "(a)")
  + (Cayley's theorem) $G$ is isomorphic to some subgroup of the symmetric
    group $S_n$.
  + (Representation Theory) $G$ is isomorphic to some subgroup of the general
    linear group $op("GL")_n (RR)$. (This is the group of invertible
    $n times n$ matrices.)
]

#solution(users.simnalamburt)[
  $
    op("Sym")(G) = {G -> G "bijective"}, quad S_n quad n = |G|
  $

  (a) Define $G attach(arrow.r.long, t: f) op("Sym")(G)$ as
  $
    f(g) = (x arrow.r.bar g x). quad quad f(g, x) = g x
  $

  Claim: $f$ is injective.

  Suppose $f(g_1) = f(g_2)$. Then
  $
    g_1 = g_1 dot 1_G = f(g_1)(1_G) = f(g_2)(1_G) = g_2 dot 1_G = g_2
  $
  Hence $g_1 = g_2$.

  $
    phi : G_1 -> G_2, quad phi(a dot b) = phi(a) dot phi(b) \
    f : G -> H "hom." quad f(G) = { f(g) | g in G }, quad f(G) <= H \
    f "injective" arrow.r.double G ≅ f(G)
  $

  Since $op("Sym")(G) ≅ S_(|G|)$ and $f(G)$ is a subgroup of
  $op("Sym")(G)$, $G$ is isomorphic to a subgroup of $S_(|G|)$.

  (b) Define $phi : S_n -> op("GL")_n (RR)$ as
  $
    (phi(sigma))_(i j) = cases(sigma(i) = j quad &"then" quad 1, "otherwise" &quad 0)
  $
  $
    (phi(sigma) dot phi(tau))_(i k)
    &= sum_(j = 1)^n phi(sigma)_(i j) dot phi(tau)_(j k) \
    &= cases(sigma(i) = j and tau(j) = k quad &"then" quad 1, "otherwise" &quad 0) \
    &= cases(tau(sigma(i)) = k quad &"then" quad 1, "otherwise" &quad 0) \
    &= phi(sigma * tau)_(i k)
  $
  (where $(sigma * tau)(i) = tau(sigma(i))$)

  $
    op("Sym")(G) := { f : G -> G | f "bijective" }
  $

  Since $G$ is isomorphic to a subgroup of $S_(|G|)$ and $S_(|G|)$ is
  isomorphic to a subgroup of $op("GL")_(|G|) (RR)$, $G$ is isomorphic to a
  subgroup of $op("GL")_(|G|) (RR)$.

  $
    & phi(sigma) = phi(tau) \
    arrow.r.double quad & forall i j . quad phi(sigma)_(i j) = phi(tau)_(i j) \
    arrow.r.double quad & forall i j . quad
    cases(sigma(i) = j quad &"then" quad 1, "otherwise" &quad 0)
    = cases(tau(i) = j quad &"then" quad 1, "otherwise" &quad 0) \
    arrow.r.double quad & forall i j . quad
    (sigma(i) = j arrow.l.r tau(i) = j) \
    arrow.r.double quad & forall i . quad sigma(i) = tau(i) \
    arrow.r.double quad & sigma = tau
  $
]
