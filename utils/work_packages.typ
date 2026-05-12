#import "../colors.typ": lightblue, lighterblue, mainblue

#let work_package(
  number,
  title,
  owner,
  contents,
  responsibilities,
  deadlines,
  resources,
  hours,
  results,
) = {
  let rows_top = calc.max(contents.len(), responsibilities.len(), deadlines.len())
  let rows_bottom = calc.max(resources.len(), hours.len())

  let top_rows = (
    for i in range(rows_top) {
      (
        table.cell(fill: lightblue, colspan: 2, align: left)[
          #if i < contents.len() {
            [- #contents.at(i)]
          }
        ],
        table.cell(fill: lightblue, align: left)[
          #if i < responsibilities.len() {
            [#responsibilities.at(i)]
          }
        ],
        table.cell(fill: lightblue, align: left)[
          #if i < deadlines.len() {
            [#deadlines.at(i)]
          }
        ],
      )
    }
  ).flatten()

  let bottom_rows = (
    for i in range(rows_bottom) {
      (
        table.cell(fill: lighterblue, colspan: 3, align: left)[
          #if i < resources.len() {
            [- #resources.at(i)]
          }
        ],
        table.cell(fill: lighterblue, align: left)[
          #if i < hours.len() {
            [#hours.at(i)]
          }
        ],
      )
    }
  ).flatten()

  figure(
    caption: [Work Package #number – #title],
    kind: table,

    table(
      columns: (1fr, 3fr, 2fr, 2fr),
      stroke: none,
      inset: 6pt,

      table.cell(fill: mainblue, align: left)[*#number*],
      table.cell(fill: mainblue)[*#title*],
      table.cell(fill: mainblue, colspan: 2)[*#owner*],

      table.cell(fill: lightblue, colspan: 2, align: left)[*Contents:*],
      table.cell(fill: lightblue, align: left)[*Responsibility:*],
      table.cell(fill: lightblue, align: left)[*Deadline:*],

      ..top_rows,

      table.cell(fill: lighterblue, colspan: 3, align: left)[*Resource Planning:*],
      table.cell(fill: lighterblue, align: left)[*Hours*],

      ..bottom_rows,

      table.cell(fill: lighterblue.lighten(50%), colspan: 4, align: left)[
        *Results:*
        #for e in results [
          - #e
        ]
      ],
    ),
  )
}
