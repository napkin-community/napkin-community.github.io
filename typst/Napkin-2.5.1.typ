#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *
#import "@preview/cetz:0.4.0"

#black_note[Exercise 2.5.1][
  Verify that
  $
    d_max (p_1, p_2) <= d_"Euclid" (p_1, p_2) <= d_"taxicab" (p_1, p_2) <= 2 d_max (p_1, p_2).
  $
  Use this to show that the metric spaces we obtain by imposing any of the three metrics are homeomorphic, with the homeomorphism being just the identity map.
]

#solution(users.ghost)[
  $
    d_"euclid" >= sqrt(d_max^2) \
    d_"taxi"^2 >= d_"euclid"^2 \
    d_max + d_max >= d_"taxi"
  $

  #align(center, cetz.canvas({
    import cetz.draw: *

    // max ball, euclid ball, and half-size max ball
    rect((-1.1, -1.1), (1.1, 1.1))
    circle((0, 0), radius: 0.75)
    rect((-0.45, -0.45), (0.45, 0.45))
    line((0.1, -0.2), (0.4, 1.35), stroke: (paint: red, dash: "dotted"))
    for pt in ((0.22, 0.45), (0.28, 0.73), (0.35, 1.1)) {
      circle(pt, radius: 0.045, fill: red, stroke: none)
    }

    // max ball, taxicab ball, euclid ball, and small max ball
    scope({
      set-origin((3.4, 0))
      rect((-1.1, -1.1), (1.1, 1.1))
      line((0, 1.05), (1.05, 0), (0, -1.05), (-1.05, 0), close: true)
      circle((0, 0), radius: 0.55)
      rect((-0.3, -0.3), (0.3, 0.3))
    })
  }))
]
