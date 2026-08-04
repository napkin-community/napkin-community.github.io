#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *
#import "@preview/cetz:0.4.0"

#plain_box(title: [Problem 1E], subtitle: [A hint for Cayley's theorem])[
  Find a subgroup $H$ of $S_8$ which is isomorphic to $D_8$, and write the
  isomorphism explicitly.
]

#solution(users.ghost)[
  $
    S_8 & = { mat(delim: "(", 1, 2, dots.h.c, 8; a, , dots.h.c, h), dots.h.c,
            mat(delim: "(", 1, dots.h.c, 8; h, dots.h.c, a) } \
    D_8 & = { 1, r, r^2, dots.h.c, s, s r, s r^2, dots.h.c }
  $

  $
    limits(mat(delim: "(", 1, 2, 3, 4, 5, 6, 7, 8; a, b, c, d, e, f, g, h))_1
    quad
    limits(mat(delim: "(", 1, , dots.h.c, 8; h, a, b, dots.h.c, g))_r
    quad dots.h.c \
    limits(mat(delim: "(", 1, dots.h.c, 8; h, dots.h.c, a))_s
  $

  $arrow.t$ 저 둘만 쓰면 됨

  #align(center, cetz.canvas({
    import cetz.draw: *
    let pts = range(8).map(i => {
      let a = 90deg + i * 45deg
      (1.2 * calc.cos(a), 1.2 * calc.sin(a))
    })
    line(..pts, close: true)
    for (i, p) in pts.enumerate() {
      content((p.at(0) * 1.3, p.at(1) * 1.3), $#(i + 1)$)
    }
  }))

  $
      1 & = mat(delim: "(", 1, 2, 3, 4, 5, 6, 7, 8) \
      r & = mat(delim: "(", 7, 8, 1, 2, 3, 4, 5, 6) \
    r^2 & = mat(delim: "(", 5, 6, 7, 8, 1, 2, 3, 4) \
    r^3 & = mat(delim: "(", 3, 4, 5, 6, 7, 8, 1, 2) \
      s & = mat(delim: "(", 8, 7, 6, 5, 4, 3, 2, 1) \
    s r & = mat(delim: "(", 6, 5, 4, 3, 2, 1, 8, 7)
  $

  $
          1 & = mat(delim: #none, 1, 2, 3, 4, 5, 6, 7, 8) \
          r & = mat(delim: #none, 7, 8, 1, 2, 3, 4, 5, 6) \
        s r & = mat(delim: #none, 6, 5, 4, 3, 2, 1, 8, 7) \
      r s r & = mat(delim: #none, 8, 7, 6, 5, 4, 3, 2, 1) \
    s r s r & = 1
  $
]
