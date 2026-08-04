#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

#plain_box(title: [Problem 3B])[
  Consider the dihedral group $G = D_10$.

  #set enum(numbering: "(a)")
  + Is $H = chevron.l r chevron.r$ a normal subgroup of $G$? If so, compute $G slash H$ up to isomorphism.
  + Is $H = chevron.l s chevron.r$ a normal subgroup of $G$? If so, compute $G slash H$ up to isomorphism.
]

#solution(users.kiwiyou)[
  $ G = {e, r, r^2, r^3, r^4, s, s r, s r^2, s r^3, s r^4} $

  (a) $H_1 = chevron.l r chevron.r = {r^n | 0 <= n < 5}$

  $
    r H_1 r^(-1) & = {r r^n r^(-1) | 0 <= n < 5} = H_1 \
    s H_1 s^(-1) & = {s r^n s^(-1) | 0 <= n < 5} limits(=)^"dihedral" {r^(-n) | 0 <= n < 5} \
    & = {r^0, r^(-1), r^(-2), dots.c, r^(-4)} = {r^n | 0 <= n < 5} = H_1 \
    s r^n H_1 (s r^n)^(-1) & = H_1
  $

  $arrow.r.double space forall g in G, space g H_1 g^(-1) = H_1$, i.e. $H_1$ is normal.

  $G slash H_1 = {e H_1, s H_1}$

  #align(center, table(
    columns: 3,
    align: center,
    [], [$e H_1$], [$s H_1$],
    [$e H_1$], [$e H_1$], [$s H_1$],
    [$s H_1$], [$s H_1$], [$e H_1$],
  ))

  $arrow.r.double space G slash H_1 ≅ ZZ slash 2 ZZ$

  (b) $H_2 = chevron.l s chevron.r = {e, s}$

  $ r H_2 r^(-1) = {r e r^(-1), r s r^(-1)} = {e, s r^(-2)} != H_2 $

  $therefore$ $H_2$ is not normal. #h(1fr) #sym.qed

  Note ($S subset.eq G$):
  $ g S = {g s | s in S}, quad S g = {s g | s in S}, quad (a S) b = a (S b) $
]
