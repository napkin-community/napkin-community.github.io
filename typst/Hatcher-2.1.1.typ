#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

// Workaround: lib/users/ghost.json declares avatar format "jpeg",
// which Typst's image() rejects (expects "jpg").
#let ghost = (
  ..users.ghost,
  avatar: (source: users.ghost.avatar.source, format: "jpg"),
)

#plain_box(title: "AT-2.1.1")[
  What familiar space is the quotient #sym.Delta\-complex of a 2-simplex $[v_0, v_1, v_2]$ obtained
  by identifying the edges $[v_0, v_1]$ and $[v_1, v_2]$, preserving the ordering of vertices?
]

#solution(ghost)[
  // The whiteboard also has photos of a physical model: a long paper 2-simplex marked as in the
  // first picture, looped and glued along the identified edges into a Möbius band.
  #figure(
    caption: [
      Cut $Delta^2$ along $[v_1, v_3]$ ($v_3$ the midpoint of $[v_0, v_2]$) and glue $[v_0, v_1]$
      to $[v_1, v_2]$: a rectangle with its two ends identified with a flip — a Möbius band.
    ],
    {
      import "@preview/cetz:0.4.1"
      let typst-grid = grid
      import cetz.draw: *
      let canvas = cetz.canvas.with(length: 1.5cm)
      let mark = mark.with(
        symbol: ">",
        stroke: 0pt,
        anchor: "center",
        fill: black,
      )
      let arrow1(a, b) = mark((a, 50%, b), b)
      let arrow2(a, b) = {
        mark((a, 42%, b), b)
        mark((a, 58%, b), b)
      }

      let triA = canvas({
        set-style(stroke: (cap: "round"))
        let (v0, v1, v2, v3) = ((0, 0), (1.4, 0.7), (2.8, 0), (1.4, 0))
        line(v0, v1)
        line(v1, v2)
        line(v0, v2)
        arrow1(v0, v1)
        arrow1(v1, v2)
        circle(v3, radius: 0.035, fill: black, stroke: none)
        content((rel: (-0.08, 0), to: v0), $v_0$, anchor: "east")
        content((rel: (0, 0.1), to: v1), $v_1$, anchor: "south")
        content((rel: (0.08, 0), to: v2), $v_2$, anchor: "west")
        content((rel: (0, -0.1), to: v3), $v_3$, anchor: "north")
      })
      let triB1 = canvas({
        set-style(stroke: (cap: "round"))
        let (v0, v1, v3) = ((0, 0), (1.0, 0.7), (1.3, 0))
        line(v0, v1)
        line(v1, v3)
        line(v0, v3)
        arrow1(v0, v1)
        arrow2(v1, v3)
        content((rel: (-0.08, 0), to: v0), $v_0$, anchor: "east")
        content((rel: (0, 0.1), to: v1), $v_1$, anchor: "south")
        content((rel: (0, -0.1), to: v3), $v_3$, anchor: "north")
      })
      let triB2 = canvas({
        set-style(stroke: (cap: "round"))
        let (v1, v3, v2) = ((0.25, 0.7), (0, 0), (1.5, 0))
        line(v1, v3)
        line(v1, v2)
        line(v3, v2)
        arrow2(v1, v3)
        arrow1(v1, v2)
        content((rel: (0, 0.1), to: v1), $v_1$, anchor: "south")
        content((rel: (0, -0.1), to: v3), $v_3$, anchor: "north")
        content((rel: (0.08, 0), to: v2), $v_2$, anchor: "west")
      })
      let triC1 = canvas({
        set-style(stroke: (cap: "round"))
        let (v0, v1, v3) = ((0, 0), (1.3, 0.7), (1.55, 0))
        line(v0, v1)
        line(v1, v3)
        line(v0, v3)
        arrow1(v0, v1)
        arrow2(v1, v3)
        content((rel: (-0.08, 0), to: v0), $v_0$, anchor: "east")
        content((rel: (0, 0.1), to: v1), $v_1$, anchor: "south")
        content((rel: (0, -0.1), to: v3), $v_3$, anchor: "north")
      })
      let triC2 = canvas({
        set-style(stroke: (cap: "round"))
        let (v3, v2, v1) = ((0, 0.7), (1.4, 0.7), (0.25, 0))
        line(v1, v3)
        line(v3, v2)
        line(v1, v2)
        arrow2(v1, v3)
        arrow1(v1, v2)
        content((rel: (0, 0.1), to: v3), $v_3$, anchor: "south")
        content((rel: (0, 0.1), to: v2), $v_2$, anchor: "south")
        content((rel: (0, -0.1), to: v1), $v_1$, anchor: "north")
      })
      let band = canvas({
        set-style(stroke: (cap: "round"))
        let (bl, br, tr, tl) = ((0, 0), (2.3, 0), (2.3, 0.7), (0, 0.7))
        line(bl, br)
        line(br, tr)
        line(tr, tl)
        line(tl, bl)
        arrow2(bl, tl)
        arrow2(tr, br)
      })

      stack(
        spacing: 1em,
        align(center, typst-grid(
          align: center + horizon,
          columns: 5,
          column-gutter: 0.8em,
          triA,
          $=>$,
          triB1,
          $union$,
          triB2,
        )),
        align(center, typst-grid(
          align: center + horizon,
          columns: 6,
          column-gutter: 0.8em,
          $=>$,
          triC1,
          $union$,
          triC2,
          $=>$,
          band,
        )),
      )
    },
  )
]
