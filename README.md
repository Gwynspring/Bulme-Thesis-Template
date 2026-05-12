# BULME Diplomarbeitsvorlage

Eine [Typst](https://typst.app)-Vorlage für HTL-Diplomarbeiten an der **BULME Graz-Gösting**.

---

## Voraussetzungen

Typst ist für Linux, macOS und Windows verfügbar [Typst download](https://typst.app/open-source/#download) 

Alternativ kann auch der Online-Editor verwendet werden. [Typst app](https://typst.app/)

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

Die Vorlage ist für **zwei Kandidaten** ausgelegt.
Jeder Kandidat hat einen eigenen Unterordner unter `chapters/`:

```
chapters/
  candidate_1/
    chapter1.typ   ← zeigt Code, Abbildungen, Tabellen, Gleichungen, API-Referenz
  candidate_2/
    chapter1.typ   ← zeigt Textformatierung, Listen, Querverweise, YAML, Zitate
```

Die Kapitel werden in `chapters/content/body.typ` eingebunden. Vor jedem Kandidatenblock muss `page_author` aktualisiert werden, damit der richtige Name in der Fußzeile erscheint:

```typst
#page_author.update("Vorname Nachname Kandidat 1")
#include "../candidate_1/chapter1.typ"

#page_author.update("Vorname Nachname Kandidat 2")
#include "../candidate_2/chapter1.typ"
```

`page_author` ist eine Typst-State-Variable aus `globals.typ`. Durch das Aktualisieren vor jedem `#include` erscheint auf jeder Seite des jeweiligen Kandidaten der korrekte Name in der Fußzeile.

### 4. Literatur eintragen

`references.bib` enthält bereits drei Beispieleinträge (Buch, Online-Quelle, Handbuch) als Vorlage:

```bibtex
@book{stroustrup2013cpp, ... }
@online{arduino2024ref, ... }
@manual{espressif2023esp32, ... }
```

Diese durch eigene Quellen ersetzen und im Text mit `@schluessel` zitieren.
Die Bibliografie verwendet den IEEE-Stil.

### 5. TODO-Boxen abarbeiten

Alle Platzhalter im Dokument sind als gelbe **TODO-Boxen** sichtbar, die im kompilierten PDF erscheinen. Einfach den Inhalt ersetzen und die `#TODO[...]`-Box entfernen.

---

## Verzeichnisstruktur

```
Bulme-Thesis-Template/
├── main.typ                     ← Einstiegspunkt, Seitenlayout, Einbindereihenfolge
├── metadata.typ                 ← Titel, Namen, Betreuer ← HIER BEARBEITEN
├── globals.typ                  ← Globale Variablen: Farbpalette + page_author-State
├── references.bib               ← Literaturverzeichnis (BibTeX, 3 Beispiele)
│
├── utils/                       ← Wiederverwendbare Typst-Funktionen
│   ├── code.typ                 ← Code-Blöcke mit Zeilennummern (C++, Python, YAML)
│   ├── analysis.typ             ← Tabellen für API-/Klassendokumentation
│   ├── work_packages.typ        ← Arbeitspakettabellen für das Projektmanagement
│   ├── cost_breakdown.typ       ← Kostentabellen mit automatischer Summenberechnung
│   ├── todo.typ                 ← Gelbe TODO-Hinweisbox
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
    │   ├── abstract_de.typ      ← Deutsche Kurzfassung (~200 Wörter, mit TODO-Leitfragen)
    │   ├── preface.typ          ← Vorwort (mit TODO-Leitfragen)
    │   ├── acknowledgements.typ ← Danksagung (mit TODO-Leitfragen)
    │   └── team.typ
    ├── content/                 ← Gemeinsame Strukturkapitel
    │   ├── toc.typ
    │   ├── introduction.typ     ← Einleitung (mit TODO-Leitfragen)
    │   ├── task.typ             ← Aufgabenstellung (mit TODO-Leitfragen)
    │   ├── body.typ             ← Bindet Kandidatenkapitel ein; page_author hier setzen
    │   ├── project_management.typ ← Grobplan, Arbeitspakete, Meilensteine, Kosten
    │   ├── conclusion.typ       ← Fazit (mit TODO-Leitfragen)
    │   ├── indices.typ          ← Abbildungs-/Tabellen-/Codelisten, Abkürzungen, Prompts
    │   ├── bibliography.typ
    │   └── appendix.typ
    ├── candidate_1/             ← Inhaltskapitel von Kandidat 1
    │   └── chapter1.typ         ← Beispiel: Code, Abbildung, Tabelle, Gleichung, API-Referenz
    └── candidate_2/             ← Inhaltskapitel von Kandidat 2
        └── chapter1.typ         ← Beispiel: Formatierung, Listen, Querverweise, Zitate
```

---

## Verfügbare Hilfsfunktionen (`utils/`)

| Datei | Funktion(en) | Verwendung |
|---|---|---|
| `code.typ` | `code_cpp()`, `code_py()`, `code_yaml()`, `code()` | Nummerierte Code-Blöcke mit Syntaxhervorhebung |
| `analysis.typ` | `analyse_function_table()`, `analyse_attribute_table()` | API-/Klassendokumentation mit Blauabstufungen |
| `work_packages.typ` | `work_package()` | Arbeitspakettabellen für das Projektmanagement |
| `cost_breakdown.typ` | `cost_breakdown()` | Kostentabellen mit automatischer Summenberechnung |
| `todo.typ` | `TODO` | Gelbe Hinweisbox — im PDF sichtbar, vor Abgabe entfernen |
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

Funktions- und Variablennamen sowie Kommentare im Quellcode sind auf Englisch.
Alle im PDF sichtbaren Tabellentexte (Header, Beschriftungen) sind auf Deutsch.

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
@eq:label     // Gleichung

// Literaturzitat (Eintrag muss in references.bib vorhanden sein)
@stroustrup2013cpp

// Textformatierung
*Fettschrift*  _Kursivschrift_  `Inline-Code`
#footnote[Fußnotentext]

// Aufzählungen
- Unsortiert
+ Nummeriert
/ Begriff: Definition

// Abbildung mit Bild
#figure(
  image("../../img/dein_bild.png", width: 80%),
  caption: [Beschreibung],
) <fig:label>

// Code-Block (C++, Python, YAML)
#import "../../utils/code.typ": code_cpp
#code_cpp(caption: [Meine Funktion], "void setup() { ... }")

// Mathematische Gleichung (nummeriert)
$ F = m dot a $ <eq:newton>

// Mehrzeilige Gleichung mit Ausrichtung
$
  U &= R dot I \
  P &= U dot I
$ <eq:leistung>

// TODO-Box (im PDF sichtbar — vor Abgabe entfernen)
#import "../../utils/todo.typ": TODO
#TODO[Dieser Abschnitt muss noch ausgefüllt werden.]
```

---

## Lizenz

MIT — siehe [LICENSE](LICENSE).
