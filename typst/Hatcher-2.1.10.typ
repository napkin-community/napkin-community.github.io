#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

// Workaround: lib/users/ghost.json declares avatar format "jpeg",
// which Typst's image() rejects (expects "jpg").
#let ghost = (
  ..users.ghost,
  avatar: (source: users.ghost.avatar.source, format: "jpg"),
)

#plain_box(title: "AT-2.1.10")[
  (a) Show the quotient space of a finite collection of disjoint 2-simplices obtained by
  identifying pairs of edges is always a surface, locally homeomorphic to $RR^2$.

  (b) Show the edges can always be oriented so as to define a #sym.Delta\-complex structure on
  the quotient surface. [This is more difficult.]
]

#solution(ghost)[
  *(a)* Given: a set of vertices $V$, and a set of edges $E subset.eq V times V$ s.t. $E$ is
  irreflexive, $forall e in E. thin overline(e) in E$ (where $overline((v_1, v_2)) = (v_2, v_1)$),
  and every connected component of $(V, E)$ is isomorphic to $K_3$.
  Suppose there is an edge identification relation $R subset.eq E times E$ s.t.

  #enum(numbering: "(i)")[
    $forall (e_1, e_2) in R. thin (overline(e)_1, overline(e)_2) in R$
  ][
    $forall e. thin (e, e) in.not R and (e, overline(e)) in.not R$
  ][
    $forall (e_1, e_2) in R. thin (e_2, e_1) in R$
  ][
    $forall e_1. thin exists ! e_2. thin (e_1, e_2) in R$
  ]

  *Def.* $tilde_V = {(v_1, v_1 ') mid(|) (v_1, v_2) tilde_R (v_1 ', v_2 ') "for some" v_2, v_2 '}^*$.

  *Fact.* $u tilde_V v => exists (u, e_u), dots.c, (v, e_v)$ — a chain of corners
  $(v, e) in V times E$.

  #figure(
    caption: [Corners $(v_i, e_i)$, $(v_i, e_i ')$ chained by the identifications
      $e_1 ' tilde_R e_2$, $e_2 ' tilde_R e_3$, ...],
    {
      import "@preview/cetz:0.4.1"
      let typst-grid = grid
      import cetz.draw: *
      let canvas = cetz.canvas.with(length: 1.4cm)
      let mark = mark.with(
        symbol: ">",
        stroke: 0pt,
        anchor: "center",
        fill: black,
      )
      let corner(i) = canvas({
        set-style(stroke: (cap: "round"))
        let (a, l, r) = ((0.55, 0.85), (0, 0), (1.1, 0))
        line(a, l)
        line(a, r)
        line(l, r)
        mark((a, 55%, l), l)
        mark((a, 55%, r), r)
        content((rel: (0, 0.1), to: a), $v_#i$, anchor: "south")
        content((rel: (-0.1, 0), to: (a, 50%, l)), $e_#i$, anchor: "east")
        content((rel: (0.1, 0), to: (a, 50%, r)), $e_#i '$, anchor: "west")
      })
      typst-grid(
        align: center + horizon,
        columns: 3,
        column-gutter: 2em,
        corner(1),
        corner(2),
        corner(3),
      )
    },
  )

  Walk around a corner: $l$ takes the other edge of the same corner, $r$ takes the identified
  edge of the next 2-simplex.
  $
    (v_1, e_1) attach(->, t: l) (v_1, e_1 ') attach(->, t: r) (v_2, e_2), (v_2, e_2 '), dots.c
  $
  Since $|E|$ is finite, this sequence is repeat of
  $ (v_1, e_1), (v_1, e_1 '), dots.c, (v_n, e_n), (v_n, e_n ') $
  — the corners at each vertex, $v_1 / (e_1, e_1 ')$, $v_2 / (e_2, e_2 ')$, ..., close up into a
  fan of triangles around the identified vertex:

  #figure(
    caption: [The star of a vertex in the quotient],
    {
      import "@preview/cetz:0.4.1"
      import cetz.draw: *
      cetz.canvas(length: 1.1cm, {
        set-style(stroke: (cap: "round"))
        let c = (0, 0)
        circle(c, radius: 0.045, fill: black, stroke: none)
        for i in range(6) {
          let a = i * 60deg
          let b = (i + 1) * 60deg
          line(c, (calc.cos(a), calc.sin(a)))
          line((calc.cos(a), calc.sin(a)), (calc.cos(b), calc.sin(b)))
        }
      })
    },
  )

  *(b)* #sym.Delta\-complex structure: find appropriate total order on $V$.
  If $e_1 = (v_1, v_2)$ is identified with $e_2 = (v_3, v_4)$, the order has to satisfy
  $ (v_1 < v_2 and v_3 < v_4) or (v_1 > v_2 and v_3 > v_4). $

  Example (two 2-simplices with vertices $x = 0, dots, 5$, edges identified in the three
  coloured pairs): the gluings force $1 = 0 = 2$; #h(0.5em) $2 = 4$, $1 = 5$; #h(0.5em)
  $3 = 5 = 4$; and the quotient is a single triangle. #sym.checkmark

  Writing $l$ for the parametrization of an edge and $r$ for the gluing map of an identified
  pair: $x tilde_E y => r compose l (x) tilde_E r compose l (y)$, where $tilde_E$ is the
  equivalence closure of $R$.

  Chains of identified vertices, e.g. $v_p tilde v_1 - v_2 - v_3$. If $u tilde_V v$ then ...;
  for a class ${u mid(|) [v] = [u]} = {u_0, u_1, dots}$ the corner simplices
  $(Delta^(u_1))(Delta^(u_2) dots.c Delta^(u_n))$ are glued by $tilde_f$; $u_0 tilde.not_V u_2$.
  // The sketch for (b) trails off here without reaching a conclusion.
]
