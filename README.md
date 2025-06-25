# PAREK Framework – EU Post‑Quantum Cryptography Transition Handbook

Welcome to the **PAREK Framework** repository. Here you will find the full Markdown source, assets and build tooling for the *PAREK Framework: EU Post‑Quantum Cryptography Transition Handbook*.

*Live handbook preview →* [**https://www.pqc.lt**](https://www.pqc.lt)\
*Contact →* [**hello@pqc.lt**](mailto\:hello@pqc.lt)

---

## 📚 What is the Handbook?

The handbook is a practitioner‑oriented guide that stitches together the latest EU regulations, NIST standards, and academic research into a five‑stage lifecycle—**P**ost‑quantum asset & algorithm inventory, **A**ssessment of quantum risk, **R**oad‑mapping & readiness planning, **E**xecution & migration, and **K**ey‑governance & continuous improvement (P‑A‑R‑E‑K).

This repository keeps each numbered section in its **own Markdown file** so you can:

- **Edit chapters independently** via pull requests.
- **Generate PDFs/HTML** with Pandoc or MkDocs.
- **Track issues** per chapter.

---

## 🗂️ Handbook Table of Contents

Below you’ll see the official ToC (gap‑free numbering). Each bullet links to the corresponding Markdown file that lives in this repo.

### Front Matter

| # | Section                             | Source File                             |
| - | ----------------------------------- | --------------------------------------- |
| 1 | Document Control & Revision History | `front‑matter/01-document-control.md`   |
| 2 | Executive Summary                   | `front‑matter/02-executive-summary.md`  |
| 3 | Purpose, Scope & Audience           | `front‑matter/03-purpose-scope.md`      |
| 4 | Regulatory & Strategic Context      | `front‑matter/04-regulatory-context.md` |

### Part I – Foundations

| # | Section                  | Source File                            |
| - | ------------------------ | -------------------------------------- |
| 5 | Quantum Threat Landscape | `part1/05-quantum-threat-landscape.md` |
| 6 | PQC Methodology          | `part1/06-pqc-methodology.md`          |
| 7 | Framework Overview       | `part1/07-framework-overview.md`       |

### Part II – PAREK Lifecycle

| #  | Section                                      | Source File                   |
| -- | -------------------------------------------- | ----------------------------- |
| 8  | P – Post‑Quantum Asset & Algorithm Inventory | `part2/08-inventory.md`       |
| 9  | A – Assessment of Quantum Risk               | `part2/09-risk-assessment.md` |
| 10 | R – Road‑mapping & Readiness Planning        | `part2/10-roadmap.md`         |
| 11 | E – Execution & Migration                    | `part2/11-execution.md`       |
| 12 | K – Key‑governance & Continuous Improvement  | `part2/12-key-governance.md`  |

### Part III – Enablers & Annexes

| #  | Section                                   | Source File                           |
| -- | ----------------------------------------- | ------------------------------------- |
| 13 | Supply‑Chain Integration                  | `part3/13-supply-chain.md`            |
| 14 | Roles, Responsibilities & RACI            | `part3/14-raci.md`                    |
| 15 | KPIs & Reporting Dashboard                | `part3/15-kpis.md`                    |
| 16 | Reference Architectures & Tooling         | `part3/16-reference-architectures.md` |
| 17 | Glossary & Acronyms                       | `part3/17-glossary.md`                |
| 18 | Templates, Check‑lists & Sample Artefacts | `part3/18-templates.md`               |
| 19 | Appendices                                | `part3/19-appendices.md`              |

---

## 🏗️ Repository Layout

```
├── front‑matter/                # 01–04
├── part1/                       # 05–07 (Foundations)
├── part2/                       # 08–12 (PAREK Lifecycle)
├── part3/                       # 13–19 (Enablers & Annexes)
├── assets/                      # Images, diagrams, data tables
├── scripts/                     # build‑pdf.sh, link‑check.py, etc.
├── LICENSE                      # MIT License
└── README.md                    # You are here
```

> **Heads‑up 📝**  Each Markdown file starts with YAML front‑matter (title, authors, revision date) so we can auto‑populate Document Control tables.

---

## 🚀 Quick Start

```bash
# Clone
$ git clone https://github.com/Grigaliunas/parek-framework.git
$ cd parek-framework

# Install dependencies (Pandoc + filters)
$ ./scripts/setup.sh

# Build the handbook as a single PDF
$ ./scripts/build_pdf.sh
# → output/parek-handbook.pdf

# Serve as HTML (MkDocs)
$ mkdocs serve
# → http://localhost:8000
```

---

## 🤝 Contributing

1. **Fork** the repo & create a branch: `git checkout -b section-08-typos`.
2. **Edit the Markdown file** in question.
3. **Run **`` to ensure style and link checks pass.
4. **Submit Pull Request** referencing the issue number (if any).

Check the **CONTRIBUTING.md** for detailed style guidance.

---

## 🪪 License

Distributed under the **MIT License**. See `LICENSE` for more information.

---

## 🙏 Acknowledgements

- EU NCC Quantum Working Group for roadmap alignment.
- TNO & ENISA for open‑source threat models.
- The wider open‑quantum‑safe community.


