#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

#black_note[Exercise 16.1.3][
  Show that a group action can equivalently be described as a group homomorphism from $G$ to $S_X$, where $S_X$ is the symmetric group of permutations on $X$.
]

#solution(users.ghost)[
  Let $bullet$ be
  $
    bullet : G times X → X, quad 1_G bullet x = x, quad (g h) bullet x = g bullet (h bullet x).
  $

  Let $phi$ be
  $ phi : G → S_X, quad phi(g) = lambda x. med g bullet x. $

  Then
  $
    phi(g h)
    = lambda x. med (g h) bullet x
    = lambda x. med g bullet (h bullet x)
    = (lambda x. med g bullet x) compose (lambda x. med h bullet x)
    = phi(g) compose phi(h).
  $
]
