#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

#black_note[Question 16.2.1][
  Why is this an equivalence relation?
]

#solution(users.ghost)[
  $x tilde y$ if $x = g dot y$ for some $g in G$.

  / Reflexivity: $x = 1_G dot x ==> x tilde x$.
  / Symmetry: $x tilde y ==> x = g dot y ==> y = g^(-1) dot x ==> y tilde x$.
  / Transitivity: $
      x tilde y, med y tilde z & ==> x = g_1 dot y, med y = g_2 dot z \
                               & ==> x = g_1 dot (g_2 dot z) = (g_1 g_2) dot z \
                               & ==> x tilde z
    $

  #h(1fr) #sym.qed
]
