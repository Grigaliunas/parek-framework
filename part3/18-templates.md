# 18  Templates, Check‑lists & Sample Artefacts


> **Purpose** – catalogue the ready‑to‑use artefacts that accelerate PAREK implementation: spreadsheets, questionnaires, run‑books and document stubs.  All templates live under the repository’s **`assets/templates/`** folder so teams can clone or download them directly.

_The table lists each template, its intended use, recommended format and repository path._

| # | Template name | Purpose | Format | Repo path |
|---|---------------|---------|--------|-----------|
| 1 | **CBOM JSON Schema** | Validate supplier cryptography bills of materials against CycloneDX extension | `.json` | `assets/templates/cbom-schema/pqcbom-1.6.json` |
| 2 | **Asset Inventory Spreadsheet** | Manual fallback sheet for systems where automated scanning is not feasible | `.xlsx` | `assets/templates/inventory/inventory‑baseline.xlsx` |
| 3 | **Risk Calculator Notebook** | Jupyter notebook implementing QARS formula with sample data | `.ipynb` | `assets/templates/risk/qars_calc.ipynb` |
| 4 | **Supplier Questionnaire (Q‑PQC‑001)** | Collect vendor crypto posture & roadmap (Tier 1/2) | `.docx` | `assets/templates/supplier/q‑pqc‑001.docx` |
| 5 | **PQC Contract Annex** | Standard legal clause bundle (CRA‑ready) | `.docx` | `assets/templates/contracts/pqc‑annex.docx` |
| 6 | **Migration Run‑book Stub** | Markdown skeleton for Stage E deployments | `.md` | `assets/templates/execution/migration_runbook.md` |
| 7 | **Rollback Playbook** | Script + checklist for emergency cipher rollback | `.sh` + `.md` | `assets/templates/execution/rollback/` |
| 8 | **KPI Dashboard JSON** | Grafana import for executive KPI panel | `.json` | `assets/templates/kpi/kpi_dashboard.json` |
| 9 | **Incident Report Form (ENISA style)** | 72‑hour notification template for NIS 2 major incidents | `.docx` | `assets/templates/incidents/nis2_incident_form.docx` |
|10 | **Lessons‑Learned Retrospective Deck** | Slide deck for post‑migration review meetings | `.pptx` | `assets/templates/lessons/retro_template.pptx` |


### How to use
1. **Download or clone** the required file from the path above.
2. **Fill in the yellow‑highlighted fields** – those are mandatory for audit.
3. **Version‑control** completed artefacts in your project folder (`/project/<work‑package>/docs/`).
4. **Submit** via pull request or the SharePoint drop‑off library as instructed in §10 or §12.


### Planned additions *(placeholder)*
| Template | ETA | Owner |
|----------|-----|-------|
| KPI auto‑emailer script | Q1 2026 | CGO‑DevOps |
| CBOM→Neo4j import Lambda | Q2 2026 | DevOps‑Infra |
