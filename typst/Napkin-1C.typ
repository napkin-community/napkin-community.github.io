#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

#plain_box(title: [Problem 1C])[
  Show that $D_6 ≅ S_3$ but $D_(24) ≇ S_4$.
]

#solution(users.finalchild)[
  $D_6 ≅ S_3$:

  Label the vertices of an equilateral triangle by $1, 2, 3$, and let
  $phi(g)$ be the permutation of the vertices induced by $g in D_6$. In the
  table below, $(a b c)$ is one-line notation for the permutation
  $1 mapsto a$, $2 mapsto b$, $3 mapsto c$.
  $
    mat(
      delim: #none,
      1, r, r^2, s, r s, r^2 s;
      (123), (231), (312), (321), (132), (213);
    )
  $
  Here $r$ is the rotation $1 mapsto 2 mapsto 3 mapsto 1$, and $s$ is the
  reflection interchanging vertices $1$ and $3$. Since this map comes from a
  group action,
  $
    phi(g h)(i) = g(h(i)) = (phi(g) compose phi(h))(i),
  $
  so $phi$ is a homomorphism. The table shows that the six elements of $D_6$
  are sent to six distinct elements of $S_3$. Hence $phi$ is bijective, and
  $
    D_6 ≅ S_3.
  $

  $D_(24) ≇ S_4$:

  Write
  $
    D_(24) = {1, r, dots.h, r^11, s, s r, dots.h, s r^11},
    quad r^12 = s^2 = 1,
    quad s r s = r^(-1).
  $
  Every reflection has order $2$, since
  $
    (s r^a)^2 = s r^a s r^a = r^(-a) r^a = 1
    quad (0 <= a <= 11).
  $
  The orders of the nonidentity rotations are
  $
    op("ord") r = 12, & quad op("ord") r^2 = 6,
    & quad op("ord") r^3 = 4, & quad op("ord") r^4 = 3, \
    op("ord") r^5 = 12, & quad op("ord") r^6 = 2,
    & quad op("ord") r^7 = 12, & quad op("ord") r^8 = 3, \
    op("ord") r^9 = 4, & quad op("ord") r^10 = 6,
    & quad op("ord") r^11 = 12.&
  $
  In particular, $D_(24)$ contains an element of order $12$.

  For $S_4$, the disjoint cycle lengths of a permutation must form a
  partition of $4$. Listing these possibilities completes the unfinished
  enumeration in the sketch:
  $
    mat(
      delim: #none,
      "cycle type", & "one-line example", & "order";
      1+1+1+1, & (1234), & 1;
      2+1+1, & (2134), & 2;
      2+2, & (2143), & 2;
      3+1, & (2314), & 3;
      4, & (2341), & 4;
    )
  $
  The order of a permutation is the least common multiple of its disjoint
  cycle lengths. Therefore
  $
    op("ord") sigma in {1, 2, 3, 4}
    quad "for every" sigma in S_4.
  $
  Isomorphisms preserve element orders, whereas $D_(24)$ has the element $r$
  of order $12$. Consequently, $D_(24) ≇ S_4$.

  #colbreak()
  *한국어 풀이*

  $D_6 ≅ S_3$:

  정삼각형의 꼭짓점에 $1, 2, 3$을 표시하고, $g in D_6$가 꼭짓점에
  유도하는 permutation을 $phi(g)$라 하자. 아래 표에서 $(a b c)$는
  $1 mapsto a$, $2 mapsto b$, $3 mapsto c$를 뜻하는 one-line notation이다.
  $
    mat(
      delim: #none,
      1, r, r^2, s, r s, r^2 s;
      (123), (231), (312), (321), (132), (213);
    )
  $
  여기서 $r$은 $1 mapsto 2 mapsto 3 mapsto 1$이 되는 rotation이고, $s$는 꼭짓점
  $1$과 $3$을 바꾸는 reflection이다. 이 대응은 group action에서 유도되었으므로
  $
    phi(g h)(i) = g(h(i)) = (phi(g) compose phi(h))(i)
  $
  이고, 따라서 $phi$는 group homomorphism이다. 또한 위 표에서
  $D_6$의 여섯 원소가 $S_3$의 서로 다른 여섯 원소에 대응하므로
  $phi$는 bijection이다. 그러므로
  $
    D_6 ≅ S_3.
  $

  $D_(24) ≇ S_4$:

  $D_(24)$에서 모든 reflection의 order는 $2$이다.
  $
    D_(24) = {1, r, dots.h, r^11, s, s r, dots.h, s r^11},
    quad r^12 = s^2 = 1,
    quad s r s = r^(-1).
  $
  $
    (s r^a)^2 = s r^a s r^a = r^(-a) r^a = 1
    quad (0 <= a <= 11)
  $
  identity가 아닌 rotation들의 order는
  $
    op("ord") r = 12, & quad op("ord") r^2 = 6,
    & quad op("ord") r^3 = 4, & quad op("ord") r^4 = 3, \
    op("ord") r^5 = 12, & quad op("ord") r^6 = 2,
    & quad op("ord") r^7 = 12, & quad op("ord") r^8 = 3, \
    op("ord") r^9 = 4, & quad op("ord") r^10 = 6,
    & quad op("ord") r^11 = 12.&
  $
  이다. $D_(24)$에는 order가 $12$인 원소 $r$이 존재하는것을 확인할 수 있다.

  한편 $S_4$의 permutation을 disjoint cycle들의 곱으로 나타내면,
  각 cycle의 길이는 반드시 $4$의 partition을 이룬다. 가능한 모든
  cycle type은 다음과 같다.
  $
    mat(
      delim: #none,
      "cycle type", & "one-line example", & "order";
      1+1+1+1, & (1234), & 1;
      2+1+1, & (2134), & 2;
      2+2, & (2143), & 2;
      3+1, & (2314), & 3;
      4, & (2341), & 4;
    )
  $
  permutation의 order는 disjoint cycle들의 길이의 최소공배수이므로
  모든 $sigma in S_4$에 대하여
  $
    op("ord") sigma in {1, 2, 3, 4}
  $
  이다. group isomorphism은 각 원소의 order를 보존하지만,
  $D_(24)$에는 order가 $12$인 원소가 있고 $S_4$에는 없다.
  따라서 $D_(24) ≇ S_4$이다.
]
