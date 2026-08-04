#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

#black_note[Exercise 2.3.4][
  Show that $epsilon$-$delta$ continuity implies sequential continuity at each point.
]

#solution(users.ghost)[
  $epsilon$-$delta$ 연속 $quad <=> quad$ 수열 연속

  1. ($=>$) 정의에 따라,
  $
    forall epsilon > 0, exists delta > 0 "s.t." d_M (x, p) < delta => d_N (f(x), f(p)) < epsilon quad dots.c "(i)"
  $
  이때 $x_n -> p$ 이므로, 그 $delta$에 대해
  $
    exists N "s.t." d_M (x_n, p) < delta "for" forall n > N quad dots.c "(ii)"
  $
  (i), (ii) 합치면
  $
    "For" forall epsilon > 0, exists N "s.t." d_N (f(x_n), f(p)) < epsilon "for" forall n > N
  $

  2. ($arrow.l.double$) 보일 것:
  $
    "For" forall epsilon > 0, exists delta > 0 "s.t." d_M (x, p) < delta => d_N (f(x), f(p)) < epsilon
  $
  귀류법: 부정을 가정하자:
  $
    "There is" epsilon_0. "For" forall delta > 0, exists x "s.t." d_M (x, p) < delta, d_N (f(x), f(p)) >= epsilon_0 quad dots.c "(iii)"
  $
  Let $delta_n := 1 / n$.
  (iii)에 의해, "그러한" $x_n$ 존재.
  $x_n$은 충분히 큰 $n$에 대해 아래를 만족:
  $
    d_M (x_n, p) < 1 / n, quad d_N (f(x_n), f(p)) >= epsilon_0 \
    x_n -> p quad "but" f(x_n) arrow.r.not f(p)
  $
  $dots.c$ 수열 연속과 모순!
]
