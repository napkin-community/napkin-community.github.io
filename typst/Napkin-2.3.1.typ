#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *
#import "@preview/cetz:0.4.0"

#black_note[Question 2.3.1][
  Can you guess what the corresponding definition for metric spaces is?
]

#solution(users.ghost)[
  $|a - b|$ 를 $d(a, b)$ 로 치환

  #align(center, cetz.canvas(length: 1cm, {
    import cetz.draw: *

    // axes
    line((-0.2, 0), (6.6, 0), mark: (end: ">"))
    content((6.8, 0), anchor: "west", $x$)
    line((0, -0.7), (0, 3.9), mark: (end: ">"))
    content((0.15, 3.9), anchor: "south-west", $f(x)$)

    // graph of f
    catmull(
      (0.15, 0.35),
      (1.3, 2.6),
      (2.5, 2.1),
      (3.3, 1.3),
      (4.1, 0.75),
      (5.0, 1.1),
      (6.0, 3.6),
    )

    let p = (3.3, 1.3)

    // big band (purple): epsilon_1 and delta_1
    set-style(stroke: rgb("#8a5cf5"))
    line((-0.1, 3.35), (5.6, 3.35))
    line((-0.1, -0.35), (5.6, -0.35))
    line((2.4, -0.35), (2.4, 3.35), mark: (start: ">", end: ">"))
    content((2.55, 3.0), anchor: "west", text(rgb("#8a5cf5"))[$epsilon_1$])
    line((0.15, 0.2), (4.5, 0.2), mark: (start: ">", end: ">"))
    content((2.0, 0.45), text(rgb("#8a5cf5"))[$delta_1$])
    line((4.5, 0), (4.5, 3.35), stroke: (paint: rgb("#8a5cf5"), dash: "dotted"))

    // small epsilon-delta at p (red)
    set-style(stroke: red)
    line((p.at(0), p.at(1) - 0.9), (p.at(0), p.at(1) + 1.2), stroke: (
      paint: red,
      dash: "dotted",
    ))
    line(
      (p.at(0) - 0.35, p.at(1) + 1.2),
      (p.at(0) + 0.35, p.at(1) + 1.2),
      mark: (start: ">", end: ">"),
    )
    content((p.at(0), p.at(1) + 1.45), text(red)[$delta$])
    line(
      (p.at(0) + 0.35, p.at(1) - 0.85),
      (p.at(0) + 0.35, p.at(1) + 0.85),
      mark: (start: ">", end: ">"),
    )
    content((p.at(0) + 0.55, p.at(1)), anchor: "west", text(red)[$epsilon$])

    // the point p
    set-style(stroke: black)
    circle(p, radius: 0.05, fill: black, stroke: none)
    content((rel: (-0.12, 0.22), to: p), $p$)
  }))
]
