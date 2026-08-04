#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

// Workaround: lib/users/ghost.json declares avatar format "jpeg",
// which Typst's image() rejects (expects "jpg").
#let ghost = (
  ..users.ghost,
  avatar: (source: users.ghost.avatar.source, format: "jpg"),
)

#plain_box(title: "AT-2.1.16")[
  #enum(numbering: "(a)")[
    Show that $H_0 (X, A) = 0$ iff $A$ meets each path-component of $X$.
  ][
    Show that $H_1 (X, A) = 0$ iff $H_1 (A) -> H_1 (X)$ is surjective and each path-component
    of $X$ contains at most one path-component of $A$.
  ]
]

#solution(ghost)[
  *(a)*
  Following sequence is exact: $H_0 (A) -> H_0 (X) -> H_0 (X, A) -> 0$

  $
         & quad A "meets each path-component of" X \
    <==> & iota_* : H_0 (A) -> H_0 (X) "is surjective" \
    <==> & "cokernel is zero" \
    <==> & H_0 (X, A) = 0
  $

  *(b)*
  Following sequence is exact:
  $H_1 (A) -> H_1 (X) -> H_1 (X, A) -> H_0 (A) -> H_0 (X)$

  Rest is same as above using exact sequence
]
