#import "../colors.typ": lightblue, lighterblue, mainblue

#let kostenaufstellung(titel, projekt, positionen, anmerkungen) = {
  let fmt(betrag) = {
    let euros = calc.floor(betrag)
    let cents = calc.round((betrag - euros) * 100)
    str(euros) + "," + if cents < 10 { "0" + str(cents) } else { str(cents) } + " €"
  }

  let gesamtkosten = positionen.fold(0.0, (acc, p) => acc + p.preis * p.menge)

  let position_rows = positionen
    .enumerate()
    .map(((i, pos)) => {
      let fill = if calc.even(i) { lighterblue } else { lighterblue.lighten(40%) }
      let gesamt = pos.preis * pos.menge
      (
        table.cell(fill: fill, align: left)[#pos.name],
        table.cell(fill: fill, align: center)[#str(pos.menge)],
        table.cell(fill: fill, align: center)[#pos.einheit],
        table.cell(fill: fill, align: right)[#fmt(pos.preis)],
        table.cell(fill: fill, align: right)[#fmt(gesamt)],
      )
    })
    .flatten()

  figure(
    caption: [Kostenaufstellung #titel],
    kind: table,
    table(
      columns: (3fr, 1fr, 1fr, 1.5fr, 1.5fr),
      stroke: none,
      inset: 6pt,
      table.cell(fill: mainblue, colspan: 3, align: left)[*#titel*],
      table.cell(fill: mainblue, colspan: 2, align: right)[*#projekt*],
      table.cell(fill: lightblue, align: left)[*Position*],
      table.cell(fill: lightblue, align: center)[*Menge*],
      table.cell(fill: lightblue, align: center)[*Einheit*],
      table.cell(fill: lightblue, align: right)[*Einzelpreis*],
      table.cell(fill: lightblue, align: right)[*Gesamtpreis*],
      ..position_rows,
      table.cell(fill: mainblue, colspan: 4, align: right)[*Gesamtkosten:*],
      table.cell(fill: mainblue, align: right)[*#fmt(gesamtkosten)*],
      if anmerkungen.len() > 0 {
        table.cell(fill: lighterblue.lighten(50%), colspan: 5, align: left)[
          *Anmerkungen:*
          #for a in anmerkungen [- #a]
        ]
      },
    ),
  )
}
