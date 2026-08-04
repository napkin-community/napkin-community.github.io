#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

#plain_box(title: [Problem 16A], subtitle: [PUMaC 2009 C8])[
  Taotao wants to buy a bracelet consisting of seven beads, each of which is orange, white or black. (The bracelet can be rotated and reflected in space.) Find the number of possible bracelets.
]

#solution(users.finalchild)[
  $D_14$ ($r$ = rotated, $s$ = reflected):
  $ 1 → 3^7, quad r^(1 tilde.op 6) → 3, quad s r^(0 tilde.op 6) → 3^4 $

  $ (3^7 + 7 times 3^4 + 6 times 3) / 14 = 198 $
]
