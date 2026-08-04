#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

#plain_box(title: [Problem 3A], subtitle: [18.701 at MIT])[
  Determine all groups $G$ for which the map $phi : G arrow G$ defined by
  $ phi(g) = g^2 $
  is a homomorphism.
]

#solution(users.kiwiyou)[
  i) $G$ is abelian $arrow$ homomorphism:
  $
              a b & = b a \
          a a b b & = a b a b \
          a^2 b^2 & = (a b)^2 \
    phi(a) phi(b) & = phi(a b)
  $

  ii) homo $arrow$ abelian:
  $
    phi(a) phi(b) & = phi(a b) \
          a^2 b^2 & = (a b)^2 \
          a a b b & = a b a b \
              a b & = b a
  $

  $therefore$ $phi$ is homomorphism $arrow.l.r.double$ $G$ is abelian. #h(1fr) #sym.qed
]
