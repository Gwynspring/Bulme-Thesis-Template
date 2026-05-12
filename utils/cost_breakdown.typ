#import "../colors.typ": lightblue, lighterblue, mainblue

#let cost_breakdown(title, project, items, notes) = {
  let fmt(amount) = {
    let euros = calc.floor(amount)
    let cents = calc.round((amount - euros) * 100)
    str(euros) + "," + if cents < 10 { "0" + str(cents) } else { str(cents) } + " €"
  }

  let total_cost = items.fold(0.0, (acc, p) => acc + p.price * p.quantity)

  let item_rows = items
    .enumerate()
    .map(((i, item)) => {
      let fill = if calc.even(i) { lighterblue } else { lighterblue.lighten(40%) }
      let line_total = item.price * item.quantity
      (
        table.cell(fill: fill, align: left)[#item.name],
        table.cell(fill: fill, align: center)[#str(item.quantity)],
        table.cell(fill: fill, align: center)[#item.unit],
        table.cell(fill: fill, align: right)[#fmt(item.price)],
        table.cell(fill: fill, align: right)[#fmt(line_total)],
      )
    })
    .flatten()

  figure(
    caption: [Cost Breakdown #title],
    kind: table,
    table(
      columns: (3fr, 1fr, 1fr, 1.5fr, 1.5fr),
      stroke: none,
      inset: 6pt,
      table.cell(fill: mainblue, colspan: 3, align: left)[*#title*],
      table.cell(fill: mainblue, colspan: 2, align: right)[*#project*],
      table.cell(fill: lightblue, align: left)[*Item*],
      table.cell(fill: lightblue, align: center)[*Quantity*],
      table.cell(fill: lightblue, align: center)[*Unit*],
      table.cell(fill: lightblue, align: right)[*Unit Price*],
      table.cell(fill: lightblue, align: right)[*Total Price*],
      ..item_rows,
      table.cell(fill: mainblue, colspan: 4, align: right)[*Total Cost:*],
      table.cell(fill: mainblue, align: right)[*#fmt(total_cost)*],
      if notes.len() > 0 {
        table.cell(fill: lighterblue.lighten(50%), colspan: 5, align: left)[
          *Notes:*
          #for a in notes [- #a]
        ]
      },
    ),
  )
}
