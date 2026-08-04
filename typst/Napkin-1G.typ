#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

#chili(1)
#plain_box(title: [Problem 1G])[
  Find the smallest integer $n$ such that the symmetric group $S_n$ has a
  subgroup isomorphic to the dihedral group $D_(2018)$ of order $2018$.
]

#solution(users.ghost)[
  $D_(2018)$의 서브그룹이면서 동형인 그룹을 찾는다:
  $
    G = { 1, 2, 3, ..., 2018 }
  $
  // stray dashed strokes under and right of the line above in the source;
  // purpose unclear (possibly striking it out), omitted

  #align(center, box(stroke: 1pt + black, inset: (x: 0.6em, y: 0.5em))[
    $n = 1009$
  ])

  $
              phi(r) & = mat(delim: "(", 2, 3, 4, dots.h.c, 1009, 1) \
              phi(s) & = mat(delim: "(", 1009, 1008, 1007, dots.h.c, 1) \
    op("ord") phi(r) & = op("ord") r = 1009 "(소수)"
  $

  $
    arrow.r.double "사이클" 1009 arrow.r.double n >= 1009
  $
]
