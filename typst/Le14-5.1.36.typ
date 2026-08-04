#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node
#let edge = fletcher.edge.with(marks: "-|>")

#plain_box(title: [#respect[Le14] 5.1.36])[
  Let $D : bold(I) -> cal(A)$ be a diagram and $(L ->^(p_I) D(I))_(I in bold(I))$ a limit cone on $D$.

  #set enum(numbering: "(a)")
  + Prove that whenever $A limits(arrows.rr)^h_(h') L$ are maps such that $p_I ∘ h = p_I ∘ h'$ for all $I in bold(I)$, then $h = h'$.
  + What does the result of (a) mean when $bold(I)$ is the two-object discrete category, $cal(A) = sans("Set")$, and $A = 1$? Answer without using any category-theoretic terminology.
]

#solution(users.simnalamburt)[
  $L$ 대신 $A$를 apex로 갖는 새 cone을 만들자.

  #align(center, diagram(
    spacing: (24mm, 12mm),
    node((2, 0), $A$, name: <A>),
    node((2, 1), $L$, name: <L>),
    node((0, 2), $D(I_0)$, name: <I0>),
    node((2, 2), $D(I_1)$, name: <I1>),
    node((4, 2), $D(I_2)$, name: <I2>),
    node((4.5, 2), $dots.h$),
    node((5.1, 2), $I_i in bold(I)$),
    edge(
      <A>,
      <L>,
      label: text(blue, $h$),
      stroke: (paint: blue),
      label-side: left,
    ),
    edge(
      <A>,
      <I0>,
      label: text(purple, $q_(I_0) = p_(I_0) ∘ h$),
      stroke: (paint: purple),
      label-side: right,
      label-pos: 62%,
    ),
    edge(
      <A>,
      <I1>,
      label: text(purple)[$q_(I_1) =$\ $p_(I_1) ∘ h$],
      stroke: (paint: purple),
      shift: 6pt,
      label-side: left,
      label-pos: 68%,
      label-sep: 2pt,
    ),
    edge(
      <A>,
      <I2>,
      label: text(purple, $q_(I_2) = p_(I_2) ∘ h$),
      stroke: (paint: purple),
      label-side: left,
      label-pos: 62%,
    ),
    edge(<L>, <I0>, label: $p_(I_0)$, label-side: left, label-pos: 55%),
    edge(<L>, <I1>, label: $p_(I_1)$, label-side: right),
    edge(<L>, <I2>, label: $p_(I_2)$, label-side: right, label-pos: 55%),
  ))

  이 $(A ->^(q_I) D(I))_(I in bold(I))$ 는 유효한 cone이다.
  이때 조건에 의해, $q_I = p_I ∘ h = p_I ∘ h'$ 이다.

  왜? $because$ $(L ->^(p_I) D(I))_(I in bold(I))$ 가 콘이므로, 콘의 정의에 따라
  $f : I -> J$ ($I, J in bold(I)$) 에 대해 $D(f) ∘ p_I = p_J$ 이다.
  이때, 아래가 commute 하므로,

  #align(center, diagram(
    node((1, 0), $A$, name: <A>),
    node((1, 1), $L$, name: <L>),
    node((0, 2), $D(I)$, name: <DI>),
    node((2, 2), $D(J)$, name: <DJ>),
    edge(<A>, <L>, label: text(blue, $h$), stroke: (paint: blue)),
    edge(
      <A>,
      <DI>,
      label: text(purple, $q_I$),
      stroke: (paint: purple),
      label-side: right,
      label-pos: 55%,
    ),
    edge(
      <A>,
      <DJ>,
      label: text(purple, $q_J$),
      stroke: (paint: purple),
      label-side: left,
      label-pos: 55%,
    ),
    edge(<L>, <DI>, label: $p_I$, label-side: left),
    edge(<L>, <DJ>, label: $p_J$, label-side: right),
    edge(<DI>, <DJ>, label: $D(f)$, label-side: right),
  ))

  $D(f) ∘ q_I = q_J$ 여서 $(A ->^(q_I) D(I))_(I in bold(I))$ 도 cone이다.

  이때 $(L ->^(p_I) D(I))_(I in bold(I))$ 는 그냥 cone이 아니라 limit cone이므로,
  limit cone의 universal property에 의해 이러한 $h$ 는 유일하다.

  따라서, $h = h'$ 이다. #h(1fr) #sym.qed

  (b) $cal(A) := sans("Set")$, $bold(I) :=$ "1, 2 two-object discrete category".

  다이어그램 $D : bold(I) -> cal(A)$ 는 집합 고르기가 된다:
  $
    X & := D(0) \
    Y & := D(1)
  $

  $L$ 은 $X × Y$ 가 된다:
  $
    L = X × Y = { (x, y) mid(|) x in X, y in Y } \
    p_1 : X × Y -> X, quad p_1((x, y)) = x \
    p_2 : X × Y -> Y, quad p_2((x, y)) = y
  $

  $A = 1 = { * }$

  $h : A -> L = A -> X × Y$

  - $h$ = "$X × Y$ 에서 $(x, y)$ 하나 고르기"
  - $p_1 ∘ h$ = "$X × Y$ 에서 $x$ 하나 고르기"
  - $p_2 ∘ h$ = "$X × Y$ 에서 $y$ 하나 고르기"

  - $p_1 ∘ h = p_1 ∘ h'$ : $X × Y$에서 고른 두 $x$가 같은 것
  - $p_2 ∘ h = p_2 ∘ h'$ : $X × Y$에서 고른 두 $y$가 같은 것

  $=> h = h'$ : $X × Y$에서 고른 $(x, y)$가 같은 것
]
