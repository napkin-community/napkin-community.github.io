#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

#chili(1)
#plain_box(title: [Problem 16C])[
  Prove Burnside's lemma.
]

#solution(users.simnalamburt)[
  #blue_box([Theorem 16.3.1], subtitle: [Burnside's lemma])[
    Let $G$ act on a set $X$. The number of orbits of the action is equal to
    $ 1/(|G|) sum_(g in G) |"FixPt" g| $
    where $"FixPt" g$ is the set of points $x in X$ such that $g dot x = x$.
  ]

  idea: Double counting.

  Let $S$ be
  $ S := { (g, x) | g dot x = x, g in G, x in X }. quad dots.c "(i)" $

  정의에 의해,
  $
    "FixPt" g & = { x | g dot x = x, x in X } & "where" g & in G, quad dots.c "(ii)" \
    "Stab"_G (x) & = { g | g dot x = x, g in G } & "where" x & in X. quad dots.c "(iii)"
  $

  (i), (ii)에 의해, $|S| = sum_(g in G) |"FixPt" g|$ \
  (i), (iii)에 의해, $|S| = sum_(x in X) |"Stab"_G (x)|$

  $
    ==> quad sum_(x in X) |"Stab"_G (x)| = sum_(g in G) |"FixPt" g| quad dots.c "(iv)"
  $

  #blue_box([Theorem 16.2.5], subtitle: [Orbit-stabilizer theorem])[
    Let $cal(O)$ be an orbit, and pick any $x in cal(O)$. Let $S = "Stab"_G (x)$ be a subgroup of $G$. There is a natural bijection between $cal(O)$ and left cosets. In particular,
    $ |cal(O)| |S| = |G|. $
    In particular, the stabilizers of each $x in cal(O)$ have the same size.
  ]

  Orbit-Stabilizer 정리에 의해, 특정 orbit $cal(O)$와 임의의 $x in cal(O)$에 대해
  $ |cal(O)| |"Stab"_G (x)| = |G| $

  $==>$ 특정 $cal(O)$에 대해,
  $
    sum_(x in cal(O)) |"Stab"_G (x)| = sum_(x in cal(O)) (|G|)/(|cal(O)|) = |cal(O)| dot (|G|)/(|cal(O)|) = |G|
  $

  $==>$ 집합 전체에 대해,
  $ sum_(x in X) |"Stab"_G (x)| = |G| dot ("궤도의 수") quad dots.c "(v)" $

  (iv), (v)에 의해,
  $ ("궤도의 수") = 1/(|G|) sum_(g in G) |"FixPt" g| $

  #h(1fr) #sym.qed
]
