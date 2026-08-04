#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

// Workaround: lib/users/ghost.json declares avatar format "jpeg",
// which Typst's image() rejects (expects "jpg").
#let ghost = (
  ..users.ghost,
  avatar: (source: users.ghost.avatar.source, format: "jpg"),
)

#plain_box(title: "AT-2.1.17")[
  #enum(numbering: "(a)")[
    Compute the homology groups $H_n (X, A)$ when $X$ is $S^2$ or $S^1 times S^1$ and $A$ is a
    finite set of points in $X$.
  ][
    Compute the groups $H_n (X, A)$ and $H_n (X, B)$ for $X$ a closed orientable surface of
    genus two with $A$ and $B$ the circles shown. [What are $X slash A$ and $X slash B$?]
  ]

  #figure({
    import "@preview/cetz:0.4.1"
    import cetz.draw: *
    cetz.canvas(length: 1cm, {
      set-style(stroke: (cap: "round"))
      hobby(
        (-2.4, 0),
        (-1.2, 0.8),
        (0, 0.42),
        (1.2, 0.8),
        (2.4, 0),
        (1.2, -0.8),
        (0, -0.42),
        (-1.2, -0.8),
        close: true,
      )
      circle((-1.2, 0), radius: (0.42, 0.16))
      circle((1.2, 0), radius: (0.42, 0.16))
      circle((0, 0), radius: (0.1, 0.38), stroke: (dash: "dashed"))
      content((0.18, 0.05), $A$, anchor: "west")
      circle((1.95, 0), radius: (0.42, 0.26))
      content((2.05, 0.35), $B$, anchor: "south")
    })
  })
]

#solution(ghost)[
  *(a)*
  We know that following long exact sequence of homology group exists for all $X$ and
  $A subset X$.
  $
    dots.c -> H_n (A) -> H_n (X) -> H_n (X, A) -> H_(n-1) (A) -> dots.c
    -> H_0 (A) -> H_0 (X) -> H_0 (X, A) -> 0
  $
  Let $m := |A|$. Then homology of $A$, $S^n$, $T^2 := S^1 times S^1$ is
  $
    H_i (A) = cases(ZZ^m & quad (i = 0), 0 & quad (i > 0)), quad
    H_i (S^n) = cases(ZZ & quad (i = 0\, n), 0 & quad "(otherwise)"), quad
    H_i (T^2) = cases(ZZ & quad (i = 0\, 2), ZZ^2 & quad (i = 1), 0 & quad (i > 2)).
  $

  *($X = S^2$ case)* For $i > 2$, we have $H_i (X) -> H_i (X, A) -> H_(i-1) (A)$ and
  $H_i (X) = H_(i-1) (A) = 0$. Thus $H_i (X, A) = 0$ holds. For $i = 2$, we have
  $H_2 (A) -> H_2 (X) -> H_2 (X, A) -> H_1 (A)$. This is $0 -> ZZ -> H_2 (X, A) -> 0$, so
  $H_2 (X, A) = ZZ$.
  Since $X = S^2$ is path-connected so $A$ meets all path-component of $X$, we can get
  $H_0 (X, A) = 0$ due to previous exercise. Using this, we can get exact sequence
  $ H_1 (X) -> H_1 (X, A) -> H_0 (A) -> H_0 (X) -> H_0 (X, A), $
  that is $0 -> H_1 (X, A) -> ZZ^m -> ZZ -> 0$. From this we can get $H_1 (X, A) = ZZ^(m-1)$.

  *($X = T^2$ case)* For $i > 2$, we have $H_i (X) -> H_i (X, A) -> H_(i-1) (A)$. This is
  $0 -> H_i (X, A) -> 0$, so $H_i (X, A) = 0$. For $i = 2$, we have
  $H_2 (A) -> H_2 (X) -> H_2 (X, A) -> H_1 (A)$. This is $0 -> ZZ -> H_2 (X, A) -> 0$, so
  $H_2 (X, A) = ZZ$.
  Since $X = T^2$ is path-connected so $A$ meets all path-component of $X$, we can get
  $H_0 (X, A) = 0$ due to previous exercise. Using this, we can get exact sequence
  $ H_1 (A) -> H_1 (X) -> H_1 (X, A) -> H_0 (A) -> H_0 (X) -> H_0 (X, A), $
  that is $0 -> ZZ^2 -> H_1 (X, A) -> ZZ^m -> ZZ -> 0$. From this we can get
  $H_1 (X, A) = ZZ^(m+1)$.

  Thus, answer would be:
  $
    H_i (S^2, A) = cases(0 & quad (i = 0), ZZ^(m-1) & quad (i = 1), ZZ & quad (i = 2), 0 & quad (i > 2)), quad
    H_i (T^2, A) = cases(0 & quad (i = 0), ZZ^(m+1) & quad (i = 1), ZZ & quad (i = 2), 0 & quad (i > 2))
  $

  *(b)*
  It is obvious that $(X, A), (X, B)$ are both good pair. So we can say
  $H_n (X, A) = tilde(H)_n (X slash A)$ and $H_n (X, B) = tilde(H)_n (X slash B)$.
  $X slash A tilde.equiv T^2 or T^2 = (T^2 product.co T^2) slash ({x, y})$ with $x, y$ do not
  lie on same torus, so
  $tilde(H)_n (X slash A) = tilde(H)_n (T^2 slash {x}) plus.o tilde(H)_n (T^2 slash {y})$
  holds. Moreover, we can see that $X slash B tilde.equiv T^2 slash {x, y}$ so we can get
  homology of $X slash B$ as
  $tilde(H)_n (X slash B) = tilde(H)_n (T^2 slash {x, y}) = H_n (T^2, {x, y})$ with result of
  *Problem 2.17 a)*.
  Answer is as below:
  $
    H_i (X, A) = cases(0 & quad (i = 0), ZZ^4 & quad (i = 1), ZZ^2 & quad (i = 2), 0 & quad (i > 2)), quad
    H_i (X, B) = cases(0 & quad (i = 0), ZZ^3 & quad (i = 1), ZZ & quad (i = 2), 0 & quad (i > 2))
  $

  Question: Why
  $
    dots.c -> H_n (A) -> H_n (X) -> H_n (X, A) -> H_(n-1) (A) -> dots.c
    -> H_0 (A) -> H_0 (X) -> H_0 (X, A) -> 0
  $
  method do not work?
]
