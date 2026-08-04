#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

#plain_box(title: [Problem 16B])[
  Show that two elements in the same conjugacy class have the same order.
]

#solution(users.ghost)[
  Let $G$ be a group, $C$ be a conjugacy class of $G$, and $a, b in C$.
  Then $g a g^(-1) = b$ for some $g in G$.

  Let $x in ⟨a⟩$, i.e. $x = a^n$ for some $n in ZZ$. Then

  $ g x g^(-1) = g a^n g^(-1) = (g a g^(-1))^n = b^n in ⟨b⟩. $

  Similarly, $x in ⟨b⟩ arrow.r.double g^(-1) x g in ⟨a⟩$.

  Define $phi : ⟨a⟩ → ⟨b⟩$ as $phi(x) = g x g^(-1)$, and $psi : ⟨b⟩ → ⟨a⟩$ as $psi(x) = g^(-1) x g$.
  Then $phi, psi$ form a bijection between $⟨a⟩$ and $⟨b⟩$.

  Hence $"ord"(a) = "ord"(b)$. #h(1fr) #sym.qed
]
