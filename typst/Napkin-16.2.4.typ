#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

#black_note[Question 16.2.4][
  Why is $"Stab"_G (x)$ a subgroup of $G$?
]

#solution(users.ghost)[
  / 닫힘: $a dot x = x, med b dot x = x ==> (a b) dot x = a dot (b dot x) = x$.
  / 항등원: $1_G dot x = x$.
  / 역원: $(a^(-1) a) dot x = a^(-1) dot (a dot x) = a^(-1) dot x = x$.

  #h(1fr) #sym.qed
]
