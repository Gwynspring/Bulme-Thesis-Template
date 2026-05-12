#import "../../colors.typ": page_author, lightblue, lighterblue, mainblue
#import "../../utils/work_packages.typ": arbeitspaket
#import "../../utils/cost_breakdown.typ": kostenaufstellung

#page_author.update("First Last")

= Projektmanagement

== Grobplan

#show figure: set block(breakable: true)
#figure(
  kind: table,
  caption: [Grobplan],
  table(
    columns: (auto, 1fr),
    stroke: 0.5pt + gray,
    inset: 6pt,
    align: (left + top, left + top),
    fill: (x, _y) => if x == 0 { lightblue } else { lighterblue },

    [*Projekttitel*], [Your project title],
    [*Erstellt von*], [First Last],
    [*Datum*], [DD. Month YYYY],
    [*Starttermin*], [DD.MM.YYYY],
    [*Endtermin*], [DD.MM.YYYY],

    [*Aufgabenstellung*],
    [
      Describe the overall goal of the project in 2–4 sentences.
    ],

    [*Situationsanalyse*],
    [
      List skills or equipment that need to be acquired for this project.
    ],

    [*Projektziele*],
    [
      + Goal 1 (measurable)
      + Goal 2 (measurable)
      + Goal 3 (measurable)
    ],

    [*Projektkosten*],
    [
      *Material costs:* approx. X €

      *Personnel costs:* Y h × 10 €/h = Z €
    ],

    [*Projektrisiken*],
    [
      Describe 2–3 risks and how you plan to mitigate them.
    ],

    [*Projektorganisation*],
    [
      - *Project lead:* First Last
      - *Supervisor:* Prof. ...
    ],
  ),
)<tab:Grobplan>

#show figure: set block(breakable: false)

== Projektstrukturplan

// Insert your work breakdown structure (PSP) image here.
// #figure(
//   image("../../img/your_psp.png", width: 100%),
//   caption: [Projektstrukturplan],
// )<fig:psp>

// Then add work packages using the arbeitspaket() function:
// #arbeitspaket(
//   1,                          // number
//   [Project Management],       // title
//   [First Last],               // owner
//   ([1.1 Planning], [1.2 ...]),// contents
//   ([First Last], [...]),      // responsibility
//   ([DD.MM.YY], [...]),        // deadlines
//   ([1.1 Planning], [...]),    // resources
//   ([5 Stunden], [...]),       // hours
//   ([Project plan completed],), // results
// )

== Meilensteinplan

#figure(
  caption: [Meilensteinplan],
)[
  #table(
    columns: (1fr, auto, auto),
    align: (left, right, right),
    inset: 4pt,
    stroke: 0.3pt + mainblue,

    fill: (x, y) => {
      if y == 0 { mainblue } else if calc.odd(y) { lightblue } else { lighterblue }
    },

    [*Meilenstein*], [*Datum-Soll*], [*Datum-Ist*],

    [Kickoff], [DD.MM.YY], [DD.MM.YY],
    [Milestone 2], [DD.MM.YY], [offen],
    [Milestone 3], [DD.MM.YY], [offen],
    [Project completed], [DD.MM.YY], [offen],
  )
] <tab:milestones>

== Balken-Zeit-Diagramm

// Insert your Gantt chart image here.
// #figure(
//   image("../../img/your_gantt.png", width: 100%),
//   caption: [Balken-Zeit-Diagramm],
// )

== Tagebuch

// Document your project diary here.
// You can either write entries manually or import from a CSV file.
// See utils/work_packages.typ for the table helper.
//
// Manual example:
// #table(
//   columns: (auto, auto, auto, 1fr),
//   stroke: 0.3pt + mainblue,
//   table.header([Datum], [Von], [Bis], [Beschreibung]),
//   [DD.MM.YY], [HH:MM], [HH:MM], [What you did],
// )

== Soll-Ist-Vergleich

// Compare planned vs actual hours and costs here.
// Use the kostenaufstellung() function from utils/cost_breakdown.typ
// to generate a formatted cost table. Example:
//
// #let positions = (
//   (name: "Component A", menge: 2, einheit: "Stück", preis: 15.00),
//   (name: "Component B", menge: 1, einheit: "Stück", preis: 49.90),
// )
// #kostenaufstellung("Hardware", "Your Project", positions, ("All prices incl. VAT.",))
