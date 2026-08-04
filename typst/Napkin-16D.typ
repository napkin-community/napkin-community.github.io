#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

#plain_box(title: [Problem 16D#starred], subtitle: [The "class equation"])[
  Let $G$ be a finite group. We define the #glossary[centralizer] $C_G (g) = { x in G | x g = g x }$ for each $g in G$. Show that
  $ |G| = |Z(G)| + sum_(s in S) (|G|)/(|C_G (s)|) $
  where $S subset.eq G$ is defined as follows: for each conjugacy class $C subset.eq G$ with $|C| > 1$, we pick a representative of $C$ and add it to $S$.
]

#solution(users.ranolp)[
  $
    Z(G) & := { x in G | g x = x g quad forall g in G } \
         & = { x in G | underline(g x g^(-1) = x) quad forall g in G }
  $
  ($x$의 켤레류 $= { x }$)

  따라서 $attach(|Z(G)|, t: "①") = sum_(O : |O| = 1) |O|$

  $
    C_G (s) & = { x in G | x s = s x } \
            & = { x in G | underline(x s x^(-1) = s) }
  $
  (켤레화 안정자)

  궤도-안정자 정리에 따라 $|C_G (s)| |O| = |G|$, $attach(|O|, t: "②") = (|G|)/(|C_G (s)|)$

  궤도 $O$는 여기서 켤레류이고, $|O| > 1$ ($S$의 정의에 따라)

  $
    |G| = attach(sum_(O : |O| = 1) |O|, t: "①") + attach(sum_(O : |O| > 1) |O|, t: "②") = sum |O|
  $

  켤레류들은 동치 관계로 $G$를 분할한 것이므로 모두 더하면 전체. #h(1fr) #sym.qed
]
