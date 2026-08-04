#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

#black_note[Question 1.4.5][
  Find the order of each of the six elements of $ZZ slash 6ZZ$, the cyclic
  group on six elements. (See #text(rgb("#800000"))[Example 1.1.8] if you've
  forgotten what $ZZ slash 6ZZ$ means.)
]

#solution(users.simnalamburt)[
  $ZZ slash 6ZZ = { 0, 1, 2, 3, 4, 5 }$

  $
                        0 & = 0 & wide op("ord") 0 & = 1 \
    1 + 1 + 1 + 1 + 1 + 1 & = 0 &      op("ord") 1 & = 6 \
                2 + 2 + 2 & = 0 &      op("ord") 2 & = 3 \
                    3 + 3 & = 0 &      op("ord") 3 & = 2 \
                4 + 4 + 4 & = 0 &      op("ord") 4 & = 3 \
    5 + 5 + 5 + 5 + 5 + 5 & = 0 &      op("ord") 5 & = 6
  $
]
