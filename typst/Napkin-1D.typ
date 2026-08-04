#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

#plain_box(title: [Problem 1D#starred])[
  Let $p$ be a prime. Show that if $G$ is a group of order $p$ then
  $G ≅ ZZ slash p ZZ$.
]

#solution(users.kiwiyou)[
  $
    x in G, quad x eq.not 1
    quad arrow.l.r.double quad
    op("ord") x eq.not 1, quad x^p = 1_G
  $

  만약 $exists space 0 < q < p$, $x^q = 1_G$:
  $
                        x^(p - q) & = 1_G \
    p mod q < q, quad x^(p mod q) & = 1_G
  $

  $arrow.r.double$

  $
                        & x^a = x^b, quad 0 <= a < b < p \
    arrow.r.double quad & x^(-a) x^a = x^(-a) x^b \
    arrow.r.double quad & 1_G = x^(b - a) quad "모순." quad op("ord") x = p.
  $

  $G = chevron.l x chevron.r$
  $
                 phi(x^n) & = n \
         phi(x^a dot x^b) & = a + b space (mod p) \
                          & = phi(x^a) + phi(x^b) space (mod p) \
    arrow.r.double quad G & ≅ ZZ slash p ZZ
  $
]
