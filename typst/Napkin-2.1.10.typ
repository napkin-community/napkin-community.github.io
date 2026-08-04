#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *
#import "@preview/cetz:0.4.0"

#black_note[Question 2.1.10][
  Check the conditions of a metric space for the metrics on the discrete space and for the connected graph.
]

#solution(users.ghost)[
  #align(center, cetz.canvas({
    import cetz.draw: *

    let a = (-1.5, 0)
    let b = (0, 0.85)
    let c = (0.1, -0.85)
    let d = (1.6, 0.1)

    line(a, b)
    line(a, c)
    line(b, c)
    line(b, d)
    line(c, d)

    for (pt, lbl, off) in (
      (a, $a$, (-0.25, 0)),
      (b, $b$, (0, 0.28)),
      (c, $c$, (0, -0.3)),
      (d, $d$, (0.25, 0)),
    ) {
      circle(pt, radius: 0.05, fill: black, stroke: none)
      content((rel: off, to: pt), lbl)
    }
  }))

  직결 안된 두 점은 최단 경로 따라가는 걸로 하면:

  $
    d(x, y) = d(y, x) \
    d >= 0 \
    d(x, y) + d(y, z) >= d(x, z)
  $
]
