#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

#plain_box(title: [Problem 1D#starred])[
  Let $p$ be a prime. Show that if $G$ is a group of order $p$ then
  $G ≅ ZZ slash p ZZ$.
]

#solution(users.kiwiyou)[
  $p >= 2$이므로 $x in G$, $x eq.not 1_G$인 $x$를 하나 택하자.
  $chevron.l x chevron.r$는 $G$의 부분군이므로 Lagrange 정리에 의해
  $
    op("ord") x = |chevron.l x chevron.r| divides |G| = p.
  $
  한편 $x eq.not 1_G$이므로 $op("ord") x eq.not 1$이다. $p$가 소수이므로
  $
    op("ord") x = p.
  $
  따라서 $|chevron.l x chevron.r| = p = |G|$이므로
  $G = chevron.l x chevron.r$이다. 특히 임의의 정수 $a, b$에 대해
  $x^a = x^b$일 필요충분조건은 $a = b space (mod p)$이다. 이제
  $
    phi : G & -> ZZ slash p ZZ, quad phi(x^n) = n space (mod p)
  $
  로 정의하자. 위에서 보인 거듭제곱들의 유일성에 의해 $phi$는
  well-defined이고 bijective이다. 또한
  $
    phi(x^a dot x^b) = a + b space (mod p)
    = phi(x^a) + phi(x^b)
  $
  이므로 $phi$는 group homomorphism이다. 따라서
  $G ≅ ZZ slash p ZZ$이다.
]
