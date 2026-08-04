#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

#black_note[Exercise 1.1.18][
  Which of these are groups?
  #set enum(numbering: "(a)")
  + Rational numbers with odd denominators (in simplest form), where the
    operation is addition. (This includes integers, written as $n\/1$, and
    $0 = 0\/1$).
  + The set of rational numbers with denominator at most $2$, where the
    operation is addition.
  + The set of rational numbers with denominator at most $2$, where the
    operation is multiplication.
  + The set of nonnegative integers, where the operation is addition.
]

#solution(users.ghost)[
  #set enum(numbering: "(a)")
  #enum.item[
    $({ "기약분수" b/a mid(|) a in "홀수" }, +)$
    - $b/a + d/c = (b c + a d)/(a c)$ — 닫힘.
    - $b/a + 0/1 = 0/1 + b/a = b/a$
    - $b/a + (-b)/a = (-b)/a + b/a = 0/1$
  ]
  #enum.item[
    ${ a/1, a/2 }$ — 자명.
  ]
  #enum.item[
    $1/2 dot 1/2 = 1/4$ — 안 닫힘.
  ]
  #enum.item[
    역원 #sym.crossmark
  ]
]
