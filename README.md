# BULME Thesis Template

A [Typst](https://typst.app) template for HTL diploma theses at **BULME Graz-Gösting** (Höhere Technische Bundes-Lehranstalt Graz-Gösting).

---

## Prerequisites

Install Typst: https://github.com/typst/typst#installation

```bash
# macOS / Linux via cargo
cargo install typst-cli

# or download a pre-built binary from the releases page
```

---

## Quickstart

```bash
git clone https://github.com/Gwynspring/Bulme-Thesis-Template
cd Bulme-Thesis-Template

# Edit your project details
# (title, names, class, supervisor — see below)
$EDITOR metadata.typ

# Compile
typst compile main.typ main.pdf

# Or watch for changes (auto-recompile on save)
typst watch main.typ main.pdf
```

---

## Customising the template

### 1. Fill in `metadata.typ`

This is the **single file** you need to edit to set your title, names, and supervisor. All pages (title page, team page, declaration) pull from it automatically.

```typst
#let meta = (
  title: "Your Thesis Title",
  year:  "2025/2026",
  supervisor: (name: "Prof. ...", ...),
  candidates: (
    (name: "First Last", class: "8XYYY", ...),
  ),
)
```

### 2. Replace placeholder photos

Put your photos in `img/` and update the `photo` field in `metadata.typ`.
Photos should be portrait-oriented (approx. 4 × 6 cm).

### 3. Add your content chapters

The template is structured for **two candidates** (typical for a BULME Diplomarbeit).
Each candidate has their own subfolder under `chapters/`:

```
chapters/
  candidate_1/
    chapter1.typ   ← demo chapter, rename and extend
    chapter2.typ
    ...
  candidate_2/
    chapter1.typ
    ...
```

Include them in `chapters/content/body.typ` and update the `page_author` state before each candidate's chapters so their name appears in the page footer:

```typst
#page_author.update("First Last candidate 1")
#include "../candidate_1/chapter1.typ"

#page_author.update("First Last candidate 2")
#include "../candidate_2/chapter1.typ"
```

`page_author` is a Typst state variable defined in `colors.typ`. Updating it before each `#include` causes the footer to display the correct author name on every page of that candidate's chapters.

### 4. Add references

Edit `references.bib` with your BibTeX entries.
Cite with `@yourkey` anywhere in the document.
The bibliography uses IEEE style.

---

## Directory structure

```
Bulme-Thesis-Template/
├── main.typ                     ← entry point, page layout, include order
├── metadata.typ                 ← title, names, supervisor ← EDIT THIS
├── colors.typ                   ← blue colour palette + page_author state
├── references.bib               ← bibliography (BibTeX)
│
├── utils/                       ← reusable Typst functions
│   ├── code.typ                 ← code blocks with line numbers (C++, Python, YAML)
│   ├── analysis.typ             ← API documentation tables
│   ├── work_packages.typ        ← project management work package tables
│   ├── cost_breakdown.typ       ← cost tables with automatic totals
│   ├── todo.typ                 ← TODO highlight box
│   └── prompt_figure.typ        ← AI prompt documentation figures
│
├── img/                         ← images and diagrams
│   ├── bulme.png                ← BULME logo (do not replace)
│   ├── htl.png                  ← HTL logo (do not replace)
│   └── placeholder.png          ← placeholder — replace with your images
│
└── chapters/
    ├── frontmatter/             ← title page, declaration, abstracts, team
    │   ├── titlepage.typ
    │   ├── declaration.typ
    │   ├── abstract_en.typ      ← English abstract (~200 words)
    │   ├── abstract_de.typ      ← German Kurzfassung (~200 words)
    │   ├── preface.typ
    │   ├── acknowledgements.typ
    │   └── team.typ
    ├── content/                 ← shared structural chapters
    │   ├── toc.typ
    │   ├── introduction.typ
    │   ├── task.typ
    │   ├── body.typ             ← includes candidate chapters; update page_author here
    │   ├── project_management.typ
    │   ├── conclusion.typ
    │   ├── indices.typ          ← figure/table/code lists + abbreviations + AI prompts
    │   ├── bibliography.typ
    │   └── appendix.typ
    ├── candidate_1/             ← candidate 1's content chapters
    │   └── chapter1.typ         ← demo chapter showing all features
    └── candidate_2/             ← candidate 2's content chapters
        └── chapter1.typ
```

---

## Available utilities (`utils/`)

| File | Function(s) | Usage |
|---|---|---|
| `code.typ` | `code_cpp()`, `code_py()`, `code_yaml()`, `code()` | Numbered code blocks with syntax highlighting |
| `analysis.typ` | `analyse_function_table()`, `analyse_attribute_table()` | API / class documentation tables |
| `work_packages.typ` | `work_package()` | Project management work package tables |
| `cost_breakdown.typ` | `cost_breakdown()` | Cost tables with automatic total calculation |
| `todo.typ` | `TODO` | Yellow highlight box for draft notes |
| `prompt_figure.typ` | `prompt-figure()` | Document AI prompts for the Promptverzeichnis |

---

## German headings

Several headings in the compiled PDF are in German — this is **required by BULME** and must not be changed:

- `Eidesstattliche Erklärung` (statutory declaration)
- `Kurzfassung` (German abstract)
- `Vorwort` (preface)
- `Danksagung` (acknowledgements)
- `Projektteam und Projektbetreuer` (team page)
- `Abbildungsverzeichnis`, `Tabellenverzeichnis`, `Abkürzungsverzeichnis`, `Promptverzeichnis` (index sections)

All other template code, comments, and placeholder text are in English.

---

## Typst quick reference

```typst
// Heading (numbered, appears in TOC)
= Chapter Title <chap:label>
== Section
=== Subsection

// Cross-reference
@chap:label   // chapter
@fig:label    // figure
@tab:label    // table

// Citation
@bibkey

// Figure with image
#figure(
  image("../../img/your_image.png", width: 80%),
  caption: [Description],
) <fig:label>

// Code block (C++)
#import "../../utils/code.typ": code_cpp
#code_cpp(caption: [My function])[
void setup() { ... }
]

// Math equation (numbered)
$ F = m dot a $ <eq:newton>
```

---

## License

MIT — see [LICENSE](LICENSE).
