#import "../colors.typ": lightblue, lighterblue, mainblue

#let arbeitspaket(
  nummer,
  titel,
  owner,
  inhalte,
  verantwortung,
  termine,
  ressourcen,
  stunden,
  ergebnis,
) = {
  let rows_top = calc.max(inhalte.len(), verantwortung.len(), termine.len())
  let rows_bottom = calc.max(ressourcen.len(), stunden.len())

  let top_rows = (
    for i in range(rows_top) {
      (
        table.cell(fill: lightblue, colspan: 2, align: left)[
          #if i < inhalte.len() {
            [- #inhalte.at(i)]
          }
        ],
        table.cell(fill: lightblue, align: left)[
          #if i < verantwortung.len() {
            [#verantwortung.at(i)]
          }
        ],
        table.cell(fill: lightblue, align: left)[
          #if i < termine.len() {
            [#termine.at(i)]
          }
        ],
      )
    }
  ).flatten()

  let bottom_rows = (
    for i in range(rows_bottom) {
      (
        table.cell(fill: lighterblue, colspan: 3, align: left)[
          #if i < ressourcen.len() {
            [- #ressourcen.at(i)]
          }
        ],
        table.cell(fill: lighterblue, align: left)[
          #if i < stunden.len() {
            [#stunden.at(i)]
          }
        ],
      )
    }
  ).flatten()

  figure(
    caption: [Arbeitspaket #nummer – #titel],
    kind: table,

    table(
      columns: (1fr, 3fr, 2fr, 2fr),
      stroke: none,
      inset: 6pt,

      table.cell(fill: mainblue, align: left)[*#nummer*],
      table.cell(fill: mainblue)[*#titel*],
      table.cell(fill: mainblue, colspan: 2)[*#owner*],

      table.cell(fill: lightblue, colspan: 2, align: left)[*Inhalte:*],
      table.cell(fill: lightblue, align: left)[*Verantwortung:*],
      table.cell(fill: lightblue, align: left)[*Termin:*],

      ..top_rows,

      table.cell(fill: lighterblue, colspan: 3, align: left)[*Ressourcenplanung:*],
      table.cell(fill: lighterblue, align: left)[*Anzahl Stunden*],

      ..bottom_rows,

      table.cell(fill: lighterblue.lighten(50%), colspan: 4, align: left)[
        *Ergebnis:*
        #for e in ergebnis [
          - #e
        ]
      ],
    ),
  )
}
