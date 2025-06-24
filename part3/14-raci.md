### Roles, Responsibilities & RACI***


> **Purpose of this chapter** – assign clear **R**esponsible, **A**ccountable, **C**onsulted and **I**nformed ownership for every stage, artefact and quality gate in the PAREK Framework, so that decision‑making is transparent and compliant with EU governance norms (NIS 2, DORA, GDPR, CRA).


## 14.1  RACI legend
| Code | Meaning                                                            |
| ---- | ------------------------------------------------------------------ |
| **R** | **Responsible** – executes the task / delivers the artefact       |
| **A** | **Accountable** – final sign‑off, owns success or failure         |
| **C** | **Consulted** – provides input or subject‑matter expertise        |
| **I** | **Informed** – kept up to date via dashboards, reports or email   |

An individual or group may hold multiple codes but each task must have **exactly one Accountable (A)**.


## 14.2  Key organisational roles (EU context)
| Abbr. | Role / body                         | Typical EU alignment                     |
| ----- | ----------------------------------- | ---------------------------------------- |
| BoD   | Board of Directors                  | NIS 2 Art. 20 – management oversight     |
| CISO  | Chief Information Security Officer  | NIS 2 Art. 21 – technical measures       |
| CIO   | Chief Information Officer           | DORA ICT strategy                        |
| CFO   | Chief Financial Officer             | Budget approvals, risk cost modelling    |
| CGO   | Crypto Governance Office            | Operates CP‑01, KMS‑EU‑02 policies       |
| CRB   | Crypto Review Board                 | Reviews new algorithms, deprecations     |
| SCB   | Supplier Cryptography Board         | Oversees Tier‑1 suppliers (§13)          |
| PMO   | Programme Management Office         | Tracks roadmap (§10)                     |
| Squad | Migration Squad (Dev‑Ops)           | Executes Stage E run‑books               |
| Sup   | Tier‑1 Supplier Representative      | Provides CBOMs, attestations             |


## 14.3  PAREK life‑cycle RACI matrix
| Stage / Artefact                          | BoD | CISO | CIO | CFO | CGO | CRB | SCB | PMO | Squad | Sup |
| ----------------------------------------- | :-: | :-:  | :-: | :-: | :-: | :-: | :-: | :-: | :-:   | :-: |
| **P – Inventory**                         | I   | A    | C   | I   | R   | C   | I   | I   | R     | R   |
| — CBOM schema & tooling                   | I   | C    | C   | I   | A   | C   | I   | I   | R     | R   |
| — Gap register                            | I   | A    | C   | I   | R   | —   | I   | C   | R     | C   |
| **A – Quantum Risk Assessment**           | I   | A    | C   | C   | R   | C   | I   | C   | —     | C   |
| — QARS model weights                      | I   | A    | C   | C   | R   | C   | —   | C   | —     | I   |
| **R – Road‑map & Readiness**              | A   | C    | A   | A   | C   | —   | C   | R   | C     | I   |
| — Budget baseline                         | A   | C    | C   | A   | C   | —   | —   | R   | —     | I   |
| — Supplier alignment plan                 | I   | C    | C   | C   | C   | —   | A   | R   | —     | R   |
| **E – Execution & Migration**             | I   | A    | A   | I   | C   | C   | I   | C   | R     | R   |
| — Pilot roll‑out                          | I   | C    | A   | I   | C   | C   | I   | C   | R     | R   |
| — Rollback execution                      | I   | A    | A   | I   | —   | —   | I   | C   | R     | R   |
| **K – Key Governance & Improvement**      | I   | A    | C   | C   | R   | A   | C   | I   | C     | C   |
| — KPI dashboard (K‑1 → K‑5)               | I   | A    | C   | C   | R   | C   | C   | I   | C     | I   |
| — Policy CP‑01 revision                   | I   | C    | C   | I   | A   | R   | I   | I   | —     | C   |
| **Quality gates (G1‑G4)**                 | A   | A    | A   | C   | R   | C   | I   | R   | C     | I   |

Legend: **R = Responsible, A = Accountable, C = Consulted, I = Informed**.


## 14.4  Governance cadence (≈ 100 words)
| Forum          | Frequency | Chair | Key outputs                    |
| -------------- | --------- | ----- | ------------------------------ |
| Steering Comm. | Quarterly | BoD   | Budget, KPI review, escalations |
| CGO Weekly Ops | Weekly    | CGO   | CBOM delta report, KPI trend   |
| CRB Algorithm  | Ad hoc    | CRB   | Algorithm approval/deprecation |
| SCB Supplier   | Quarterly | CISO  | Supplier compliance scorecard |

Outputs feed Document Control and Stage K dashboards.


## 14.5  EU regulatory mapping (≈ 150 words)
- **NIS 2 Art. 20** – Board is *Accountable* for cybersecurity risk management → BoD holds **A** for quality gates.
- **DORA (EU 2022/2554) Art. 12** – ICT risk management → CIO shares **A** in Stages R and E.
- **GDPR Art. 32** – Security of processing → CISO ensures encryption strength (**A** in A, E, K).
- **CRA Draft Art. 35** – Supplier obligations → SCB assigns **A** to supplier compliance artefacts.

Alignment table stored under `assets/compliance/eu‑mapping.xlsx`.


## 14.6  Role onboarding & training (≈ 80 words)
Each role receives a tailored induction pack (OneDrive folder `Training/PAREK/<role>`), containing:
- Role charter & RACI excerpt
- Relevant policies (CP‑01, KMS‑EU‑02)
- Playbooks (incident response, algorithm review)
- e‑Learning module (SCORM) with EU regulatory quiz

Completion tracked via LMS; minimum pass score = 85 %.


