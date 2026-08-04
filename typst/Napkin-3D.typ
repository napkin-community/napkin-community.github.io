#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

#plain_box(title: [Problem 3D])[
  Let $G$ and $H$ be finite groups, where $|G| = 1000$ and $|H| = 999$. Show
  that a homomorphism $G arrow H$ must be trivial.
]

#solution(users.finalchild)[
  $ phi(g^1000) = phi(g)^999 = 1_H $

  $ therefore phi(g) = 1_H $
  #h(1fr) #sym.qed
]
