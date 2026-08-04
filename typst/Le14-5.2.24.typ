#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node
#let edge = fletcher.edge.with(marks: "-|>")

#plain_box(title: [#respect[Le14] 5.2.24])[
  (Compare Exercise 5.1.40.) Let $cal(A)$ be a category and $A in cal(A)$.
  Define a #glossary[quotient object] of $A$ to be an isomorphism class of epics out of $A$.
  That is, let $sans("Epic")(A)$ be the full subcategory of $A slash cal(A)$ whose objects are the epics;
  then a quotient object of $A$ is an isomorphism class of objects of $sans("Epic")(A)$.

  #set enum(numbering: "(a)")
  + Let $A ->^e X$ and $A ->^(e') X'$ be epics in $sans("Set")$.
    Show that $e$ and $e'$ are isomorphic in $sans("Epic")(A)$ if and only if they induce the same equivalence relation on $A$.
    Deduce that the quotient objects of $A$ are in canonical one-to-one correspondence with the equivalence relations on $A$.
  + Assuming the (nontrivial) fact that the epics in $sans("Grp")$ are the surjections,
    show that the quotient objects of a group correspond one-to-one with its normal subgroups.

  (The name 'quotient object' is not standard, and indeed there is no standard name for it.
  Arguably, 'quotient object' would be more suitable for an isomorphism class of _regular_ epics, as defined in the following exercises.)
]

#solution(users.ghost)[
  For a category $cal(C)$ and its object $X$, *undercategory* or *coslice category* $X slash cal(C)$ is category whose objects are pairs $(B, ψ)$ where $B$ is object of $cal(C)$ and $ψ : X -> B$ is morphism of $cal(C)$, and morphisms between $(B, ψ)$ and $(B', ψ')$ is $g : B -> B'$ which makes below diagram commutes.

  #align(center, diagram(
    node((1, 0), $X$, name: <X>),
    node((0, 1), $B$, name: <B>),
    node((2, 1), $B'$, name: <B2>),
    edge(<X>, <B>, label: $ψ$, label-side: right),
    edge(<X>, <B2>, label: $ψ'$, label-side: left),
    edge(<B>, <B2>, label: $g$, label-side: right),
  ))

  (a) _Proof._ First, all epics in $sans("Set")$ is surjection.
  Proof is as follows: Let $f : X -> Y$, morphism of $sans("Set")$, be epic and $g_1, g_2 : Y -> {0, 1}$ as $g_1 = χ_(f(X))$, $g_2 = χ_Y$.
  Then $g_1 ∘ f = g_2 ∘ f$ as constant function, image of all $x in X$ is $1$.
  Therefore $g_1 = g_2$ and it makes $f(X) = Y$ so $f$ is surjection.

  ($==>$) Let $(X, e), (X', e') in sans("Epic")(A)$ be isomorphic, that is, there exists map (that is, morphism of $sans("Set")$) $f : X -> X'$, $g : X' -> X$ with $g ∘ f = id_X$ and $f ∘ g = id_(X')$ and makes below diagram commutes.

  #align(center, diagram(
    node((1, 0), $A$, name: <A>),
    node((0, 1), $X$, name: <X1>),
    node((1, 1), $X'$, name: <X2>),
    node((2, 1), $X$, name: <X3>),
    edge(<A>, <X1>, label: $e$, label-side: right),
    edge(<A>, <X2>, label: $e'$, label-side: right),
    edge(<A>, <X3>, label: $e$, label-side: left),
    edge(<X1>, <X2>, label: $f$, label-side: right),
    edge(<X2>, <X3>, label: $g$, label-side: right),
  ))

  Then $f, g$ are all bijective and $g = f^(-1)$.
  Let equivalence relation of $A$ induced by $e, e'$ as $R := { (a, b) in A × A mid(|) e(a) = e(b) }$ and $R' := { (a, b) in A × A mid(|) e'(a) = e'(b) }$.
  Then $e(a) = e(b)$ if and only if $e'(a) = e'(b)$ because $e' = f ∘ e$ and $f$ is bijective.
  So $R = R'$.

  ($<==$) Assume $R = R'$, that is, $e(a) = e(b)$ if and only if $e'(a) = e'(b)$ for $a, b in A$.
  Then we can define $f : X -> X'$ as $f(x) = e'(a)$ for $a in e^(-1)(x)$.
  It is well-defined because if $a, b in e^(-1)(x)$ then $e(a) = x = e(b)$ so $e'(a) = e'(b)$, and $f ∘ e = e'$ holds trivially.
  Similarly, we can define well-defined map $g : X' -> X$ as $g(x) = e(a)$ for $a in e'^(-1)(x)$ with $g ∘ e' = e$.
  So $f, g$ is morphism of coslice category $sans("Epic")(A)$.

  Moreover, if $f(x) = x'$ then there exists $a in A$ with $x = e(a)$, $x' = e'(a)$.
  Therefore $g(x') = e(a) = x$ so $(g ∘ f)(x) = x$.
  It makes $g ∘ f = id_X$ and similarly $f ∘ g = id_(X')$.
  Thus, $(X, e)$ and $(X', e')$ is isomorphic.

  Therefore, a quotient object $[(X, e)] = { (Y, f) in sans("Epic")(A) mid(|) R_((X, e)) = R_((Y, f)) }$ when $R_((X, e))$ be equivalence relation over $A$ induced by $(X, e) in sans("Epic")(A)$, corresponds with $R_((X, e))$. #h(1fr) $square$

  (b) _Proof._ For arbitrary chosen $(X, e) in sans("Epic")(G)$ for $G in sans("Grp")$, let $N := ker e$ and $π : G -> G slash N$ as $π : g |-> g N$.
  For all group homomorphism $φ_1, φ_2 : G slash N -> H$ with $φ_1 ∘ π = φ_2 ∘ π$, $φ_1 (x N) = (φ_1 ∘ π)(x) = (φ_2 ∘ π)(x) = φ_2 (x N)$ holds for all $x N in G slash N$ so $π$ is epic.
  Therefore, $(G slash N, π) in sans("Epic")(G)$.

  Let two group homomorphisms $f : X -> G slash N$ and $g : G slash N -> X$ as $f(x) = y N$ for $y in e^(-1)(x)$ and $g(x N) = e(x)$.
  If $y, z in e^(-1)(x)$ then $y z^(-1) in ker e = N$ so $y N = z N$, therefore $f$ is well-defined.
  If $x N = y N$ then $x y^(-1) in N = ker e$ so $e(x y^(-1)) = 1$.
  It makes $e(x) = e(y)$, so $g$ is also well-defined.

  It is clear that $f ∘ e = π$ and $g ∘ π = e$, so $f, g$ is morphism of coslice category $sans("Epic")(G)$.
  $(g ∘ f)(x) = g(y N) = e(y) = x$ for $y in e^(-1)(x)$ and $(f ∘ g)(x N) = f(e(x)) = x N$ so $g ∘ f = id_X$, $f ∘ g = id_(G slash N)$.
  Thus, a quotient object $[(X, e)] = { (Y, f) in sans("Epic")(G) mid(|) ker e = ker f }$ corresponds with $ker e ⊲ G$. #h(1fr) $square$
]
