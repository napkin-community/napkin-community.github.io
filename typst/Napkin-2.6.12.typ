#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

#black_note[Exercise 2.6.12][
  Show that $delta$-$epsilon$ continuity follows from the open set condition.
]

#solution(users.ghost)[
  ($arrow.l.double$) $x in M$

  $f(x)$ 의 $epsilon$-neighborhood 를 봄.
  Open set condition 에 의해
  $
    f^(-1) (N_epsilon (f(x))) subset M "은 open"
  $
  따라서 이 안에 어떤 $delta$에 대해 $x$의 $delta$-nhood가 존재한다.
  $
    M_delta (x) subset f^(-1) (N_epsilon (f(x)))
  $
]
