#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *
#import "@preview/cetz:0.4.0"

#black_note(subtitle: [MathCounts Chapter Target Round])[Exercise 16.3.3][
  A circular spinner has seven sections of equal size, each of which is colored either red or blue. Two colorings are considered the same if one can be rotated to yield the other. In how many ways can the spinner be colored? (Answer: 20)
]

#solution(users.ghost)[
  #align(center)[
    #cetz.canvas(background: white, padding: 0.2, {
      import cetz.draw: *
      let colors = (blue, red, blue, red, red, blue, blue)
      circle((0, 0), radius: 1)
      for k in range(7) {
        let a = 90deg + k * 360deg / 7
        line((0, 0), (a, 1), stroke: purple)
        arc(
          (0, 0),
          start: a,
          stop: a + 360deg / 7,
          radius: 1.12,
          anchor: "origin",
          stroke: 2.5pt + colors.at(k),
        )
      }
    })
  ]

  $
    1 / 7 sum cases(
      0 & : 2^7,
      1 & : 2,
      2 & : 2,
      3 & : 2,
      4 & : 2,
      5 & : 2,
      6 & : 2,
    ) = (2^7 + 12) / 7 = 20
  $
]
