#import "../colors.typ": lightblue, lighterblue, mainblue
#import "@preview/cetz:0.4.2": canvas, draw

#let grid-size = 8

#let maze-table(maze-file: "./test_maze_simulator.txt") = {
  let raw-content = read(maze-file)
  let lines = raw-content.split("\n").map(line => line.trim()).filter(line => line != "" and not line.starts-with("#"))
  let maze = lines.map(line => {
    line.split(regex("\s+")).filter(x => x != "")
  })

  if maze.len() != 8 or maze.at(0).len() != 8 {
    return [Error: maze file must contain exactly 8×8 hex values.]
  }

  let hex-to-int(h) = {
    let digits = (
      "0": 0, "1": 1, "2": 2, "3": 3, "4": 4,
      "5": 5, "6": 6, "7": 7, "8": 8, "9": 9,
      "A": 10, "B": 11, "C": 12, "D": 13, "E": 14, "F": 15,
    )
    let upper = upper(h)
    let result = 0
    for c in upper {
      let d = digits.at(c, default: 0)
      result = result * 16 + d
    }
    result
  }

  canvas({
    import draw: *

    let wall-stroke = (red + 2pt)
    let grid-stroke = gray + 0.8pt
    let border-stroke = black + 1.4pt

    content(
      (grid-size / 2, grid-size + 0.2),
      anchor: "south",
      {
        set text(9.5pt)
        table(
          columns: (auto, auto, auto, auto),
          inset: 9pt,
          align: left + horizon,
          stroke: 0.5pt + gray,
          fill: (x, y) => {
            if y == 0 { mainblue } else if calc.odd(y) { lighterblue } else { lightblue }
          },
          table.header([*Direction*], [*Bit*], [*Value*], [*Meaning*]),
          [North], [3], [8], [(1 << 3) — top wall],
          [East],  [2], [4], [(1 << 2) — right wall],
          [South], [1], [2], [(1 << 1) — bottom wall],
          [West],  [0], [1], [(1 << 0) — left wall],
        )
      },
    )

    rect((0, 0), (grid-size, grid-size), stroke: border-stroke)

    for i in range(1, grid-size) {
      line((0, i), (grid-size, i), stroke: grid-stroke)
      line((i, 0), (i, grid-size), stroke: grid-stroke)
    }

    for x in range(0, grid-size) {
      content((x + 0.5, -0.25), text(9pt, $#x$), anchor: "north")
    }
    content((grid-size / 2, -0.7), text(10.5pt, weight: "bold", $x$), anchor: "north")

    for y in range(0, grid-size) {
      content((-0.25, y + 0.5), text(9pt, $#y$), anchor: "east")
    }
    content((-0.7, grid-size / 2), text(10.5pt, weight: "bold", $y$), anchor: "east", angle: 90deg)

    for array-row in range(8) {
      let cy = 7 - array-row
      for x in range(8) {
        let val = hex-to-int(maze.at(array-row).at(x))

        content(
          (x + 0.5, cy + 0.5),
          text(size: 9.5pt, weight: "bold", fill: black, maze.at(array-row).at(x)),
        )

        if calc.rem(calc.div-euclid(val, 8), 2) == 1 {
          line((x, cy + 1), (x + 1, cy + 1), stroke: wall-stroke)
        }
        if calc.rem(calc.div-euclid(val, 2), 2) == 1 {
          line((x, cy), (x + 1, cy), stroke: wall-stroke)
        }
        if calc.rem(calc.div-euclid(val, 4), 2) == 1 {
          line((x + 1, cy), (x + 1, cy + 1), stroke: wall-stroke)
        }
        if calc.rem(val, 2) == 1 {
          line((x, cy), (x, cy + 1), stroke: wall-stroke)
        }
      }
    }
  })
}
