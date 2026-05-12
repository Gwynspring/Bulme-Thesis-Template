# BULME Diplomarbeitsvorlage

Eine [Typst](https://typst.app)-Vorlage für HTL-Diplomarbeiten an der **BULME Graz-Gösting** (Höhere Technische Bundes-Lehranstalt Graz-Gösting).

---

## Voraussetzungen

Typst installieren: https://github.com/typst/typst#installation

```bash
# macOS / Linux via cargo
cargo install typst-cli

# oder ein vorgefertigtes Binary von der Releases-Seite herunterladen
```

---

## Schnellstart

```bash
git clone https://github.com/Gwynspring/Bulme-Thesis-Template
cd Bulme-Thesis-Template

# Projektdaten eintragen
# (Titel, Namen, Klasse, Betreuer — siehe unten)
$EDITOR metadata.typ

# Kompilieren
typst compile main.typ main.pdf

# Oder mit automatischer Neukompilierung beim Speichern
typst watch main.typ main.pdf
```

---

## Vorlage anpassen

### 1. `metadata.typ` ausfüllen

Dies ist die **einzige Datei**, die für Titel, Namen und Betreuer bearbeitet werden muss. Alle Seiten (Titelseite, Teamseite, Eidesstattliche Erklärung) lesen ihre Daten automatisch daraus.

```typst
#let meta = (
  title: "Titel der Diplomarbeit",
  year:  "2025/2026",
  supervisor: (name: "Prof. ...", ...),
  candidates: (
    (name: "Vorname Nachname", class: "8XYYY", ...),
  ),
)
```

### 2. Fotos ersetzen

Fotos in `img/` ablegen und das `photo`-Feld in `metadata.typ` anpassen.
Hochformat empfohlen (ca. 4 × 6 cm).

### 3. Inhaltskapitel hinzufügen

Die Vorlage ist für **zwei Kandidaten** ausgelegt (typisch für eine BULME-Diplomarbeit).
Jeder Kandidat hat einen eigenen Unterordner unter `chapters/`:

```
chapters/
  candidate_1/
    chapter1.typ   ← Beispielkapitel, umbenennen und erweitern
    chapter2.typ
    ...
  candidate_2/
    chapter1.typ
    ...
```

Die Kapitel werden in `chapters/content/body.typ` eingebunden. Vor jedem Kandidatenblock muss `page_author` aktualisiert werden, damit der richtige Name in der Fußzeile erscheint:

```typst
#page_author.update("Vorname Nachname Kandidat 1")
#include "../candidate_1/chapter1.typ"

#page_author.update("Vorname Nachname Kandidat 2")
#include "../candidate_2/chapter1.typ"
```

`page_author` ist eine Typst-State-Variable aus `colors.typ`. Durch das Aktualisieren vor jedem `#include` erscheint auf jeder Seite des jeweiligen Kandidaten der korrekte Name in der Fußzeile.

### 4. Literatur eintragen

`references.bib` mit BibTeX-Einträgen befüllen.
Zitieren mit `@schlüssel` an beliebiger Stelle im Dokument.
Die Bibliografie verwendet den IEEE-Stil.

---

## Verzeichnisstruktur

```
Bulme-Thesis-Template/
├── main.typ                     ← Einstiegspunkt, Seitenlayout, Einbindereihenfolge
├── metadata.typ                 ← Titel, Namen, Betreuer ← HIER BEARBEITEN
├── colors.typ                   ← Blaue Farbpalette + page_author-State
├── references.bib               ← Literaturverzeichnis (BibTeX)
│
├── utils/                       ← Wiederverwendbare Typst-Funktionen
│   ├── code.typ                 ← Code-Blöcke mit Zeilennummern (C++, Python, YAML)
│   ├── analysis.typ             ← Tabellen für API-/Klassendokumentation
│   ├── work_packages.typ        ← Arbeitspakettabellen für das Projektmanagement
│   ├── cost_breakdown.typ       ← Kostentabellen mit automatischer Summenberechnung
│   ├── todo.typ                 ← TODO-Hinweisbox
│   └── prompt_figure.typ        ← KI-Prompt-Dokumentation für das Promptverzeichnis
│
├── img/                         ← Bilder und Diagramme
│   ├── bulme.png                ← BULME-Logo (nicht ersetzen)
│   ├── htl.png                  ← HTL-Logo (nicht ersetzen)
│   └── placeholder.png          ← Platzhalter — durch eigene Bilder ersetzen
│
└── chapters/
    ├── frontmatter/             ← Titelseite, Erklärung, Kurzfassungen, Teamseite
    │   ├── titlepage.typ
    │   ├── declaration.typ
    │   ├── abstract_en.typ      ← Englischer Abstract (~200 Wörter)
    │   ├── abstract_de.typ      ← Deutsche Kurzfassung (~200 Wörter)
    │   ├── preface.typ
    │   ├── acknowledgements.typ
    │   └── team.typ
    ├── content/                 ← Gemeinsame Strukturkapitel
    │   ├── toc.typ
    │   ├── introduction.typ
    │   ├── task.typ
    │   ├── body.typ             ← Bindet Kandidatenkapitel ein; page_author hier setzen
    │   ├── project_management.typ
    │   ├── conclusion.typ
    │   ├── indices.typ          ← Abbildungs-/Tabellen-/Codelisten, Abkürzungen, Prompts
    │   ├── bibliography.typ
    │   └── appendix.typ
    ├── candidate_1/             ← Inhaltskapitel von Kandidat 1
    │   └── chapter1.typ         ← Beispielkapitel mit allen Template-Funktionen
    └── candidate_2/             ← Inhaltskapitel von Kandidat 2
        └── chapter1.typ
```

---

## Verfügbare Hilfsfunktionen (`utils/`)

| Datei | Funktion(en) | Verwendung |
|---|---|---|
| `code.typ` | `code_cpp()`, `code_py()`, `code_yaml()`, `code()` | Nummerierte Code-Blöcke mit Syntaxhervorhebung |
| `analysis.typ` | `analyse_function_table()`, `analyse_attribute_table()` | Tabellen für API-/Klassendokumentation |
| `work_packages.typ` | `work_package()` | Arbeitspakettabellen für das Projektmanagement |
| `cost_breakdown.typ` | `cost_breakdown()` | Kostentabellen mit automatischer Summenberechnung |
| `todo.typ` | `TODO` | Gelbe Hinweisbox für Entwurfsnotizen |
| `prompt_figure.typ` | `prompt-figure()` | KI-Prompts für das Promptverzeichnis dokumentieren |

---

## Vorgeschriebene deutsche Überschriften

Folgende Überschriften im PDF sind **von der BULME vorgeschrieben** und dürfen nicht geändert werden:

- `Eidesstattliche Erklärung`
- `Kurzfassung`
- `Vorwort`
- `Danksagung`
- `Projektteam und Projektbetreuer`
- `Abbildungsverzeichnis`, `Tabellenverzeichnis`, `Abkürzungsverzeichnis`, `Promptverzeichnis`

Alle anderen Vorlagenkommentare, Platzhaltertexte und Funktionsnamen sind auf Englisch.

---

## Typst-Kurzreferenz

```typst
// Überschrift (nummeriert, erscheint im Inhaltsverzeichnis)
= Kapitelüberschrift <chap:label>
== Abschnitt
=== Unterabschnitt

// Querverweise
@chap:label   // Kapitel
@fig:label    // Abbildung
@tab:label    // Tabelle

// Zitat
@bibschluessel

// Abbildung mit Bild
#figure(
  image("../../img/dein_bild.png", width: 80%),
  caption: [Beschreibung],
) <fig:label>

// Code-Block (C++)
#import "../../utils/code.typ": code_cpp
#code_cpp(caption: [Meine Funktion])[
void setup() { ... }
]

// Mathematische Gleichung (nummeriert)
$ F = m dot a $ <eq:newton>
```

---

## Lizenz

MIT — siehe [LICENSE](LICENSE).
