### R – Road‑mapping & Readiness Planning ***

> **Purpose of this chapter** – translate the quantitative urgency produced in *§9 Assessment of Quantum Risk* into a resourced, dated and regulator‑aligned action plan that will deliver quantum resilience across the organisation’s entire technology estate.


## 10.1  Scope and positioning
Road‑mapping and readiness planning (the **R** in *P‑A‑R‑E‑K*) is the linchpin phase that turns analytical findings into concrete, executive‑approved commitments.  It spans three macro tasks:

1. **Prioritise** – decide which systems, business services and supply‑chain partners move first, based on QARS scores, EU risk categories and practical constraints;
2. **Plan** – build a realistic programme schedule with phased deployments, governance checkpoints and budget allocations; and
3. **Prepare** – ensure that people, processes and technology are in place when execution starts (tooling, contracts, training, fallback strategies).

The output is a *single authoritative roadmap* that boards, regulators and suppliers can cite.  Without it, migration efforts splinter into ad hoc projects that stall or overrun.


## 10.2  Key inputs
| Artefact | Source section | Description |
|----------|----------------|-------------|
| **CBOM inventory** | §8 | Machine‑readable list of algorithms, keys and protocols per system |
| **QARS scores** | §9 | Composite urgency rating (0–1) per system/service |
| **EU roadmap milestones** | External | 2026 early pilots, 2030 high‑risk cut‑over, 2035 medium‑risk completion |
| **Budget envelope** | CFO | Multi‑year capital & operational funding ceiling |
| **Resource capacity** | HR / PMO | Available FTEs, external consultants, supplier bandwidth |


## 10.3  Process overview

```
┌───────────────┐   1   ┌──────────────────┐     2     ┌────────────────┐   3   ┌──────────────────┐
│  Risk & Asset │──►──►│  Prioritisation  │───►───►──►│  Road‑map Plan  │──►──►│   Readiness Set   │
│   Intelligence│       └──────────────────┘           └────────────────┘       └──────────────────┘
    (§8 & §9)             (10.4)                           (10.5)                   (10.6)
```

Each arrow represents a *quality gate* – the roadmap cannot progress until the preceding artefacts are baseline‑approved.


## 10.4  Step 1  Prioritisation (4 weeks)
The goal is an **ordered backlog** of migration work‑packages.

### 10.4.1  Segmentation
* **Risk bucket** – map QARS ≥ 0.65 to *high*, 0.35–0.64 to *medium*, < 0.35 to *low*.
* **Business criticality** – overlay impact tiers (mission‑critical, regulatory, customer‑facing, internal).
* **Dependency heat‑map** – identify technical couplings (shared crypto libraries, common PKI roots, hardware modules).

### 10.4.2  Scoring matrix
Create a *Prioritisation Index (PI)* = `w_risk × QARS + w_imp × Impact + w_dep × Coupling`.  Default weights 0.4 / 0.4 / 0.2 can be tuned in steering committee.

### 10.4.3  Pilot selection
Select at least one representative workload in each domain (web, mobile, embedded, data‑at‑rest) to validate migration playbooks.  Early pilots should have:
* ≤ 10 k TPS (to limit blast radius)
* Dedicated dev‑ops pipeline for rapid iteration
* Supportive product owner


## 10.5  Step 2  Road‑map planning (6 weeks)
This step converts the ordered backlog into a **multi‑year, resource‑levelled Gantt**.

### 10.5.1  Timeline alignment
| Milestone | EU target | Local target | Notes |
|-----------|-----------|--------------|-------|
| **Inventory baseline** | 2026‑03‑31 | 2026‑03‑15 | lock CBOM scope |
| **Pilot migrations live** | 2026‑12‑31 | 2026‑11‑30 | include telemetry & rollback |
| **High‑risk systems PQC‑ready** | 2030‑12‑31 | 2030‑06‑30 | 6‑month buffer for audit |
| **Medium‑risk systems PQC‑ready** | 2035‑12‑31 | 2035‑06‑30 | contingent buffer |

> *Rationale* – buffer dates absorb supplier slippage, new standard releases (FIPS 206, ISO/ETSI), or geopolitical disruptions.

### 10.5.2  Work‑package design
Break down migrations into **Epics** (e.g., *TLS Stack Upgrade*) and **Stories** (e.g., *enable hybrid Kyber in nginx 1.25*).  Attach:
* Definition of Done (test cases, security sign‑off)
* Estimated story points & duration
* Owner team and SME reviewers

### 10.5.3  Capacity & cost modelling
* **FTE mapping** – match story points to sprint velocity.
* **External spend** – licences, new HSMs, PKI vouchers, test‑bed cloud costs.
* **Contingency reserve** – 15 % of total CapEx based on Monte Carlo simulation of schedule risk.

### 10.5.4  Governance calendar
Publish quarterly steering reviews and monthly working‑group checkpoints.  Each high‑risk migration has a *go/no‑go gate* with rollback cut‑off defined.


## 10.6  Step 3  Readiness preparation (ongoing)
### 10.6.1  Supplier alignment
* Embed *PQC‑ready clause* requiring CBOM + SPDX attestation with FIPS‑cert IDs by 2028.
* Incentivise via payment milestones – 10 % retainage until PQC compliance confirmed.

### 10.6.2  Toolchain hardening
| Tool category | Minimum capability |
|---------------|--------------------|
| **CI/CD scanner** | Detect lattice or hash‑based algorithm support, block RSA‑2048 certs |
| **Traffic analyser** | Real‑time handshake cipher suite telemetry |
| **HSM firmware** | Supports ML‑KEM‑768, ML‑DSA‑5, hybrid wrapping |

### 10.6.3  Skills uplift
Deliver a role‑based training matrix:
* **Dev‑ops** – PQC libraries, hybrid handshake patterns (2‑day workshop)
* **IT Ops** – firmware‑signing, key rotation (1‑day lab)
* **Risk officers** – QARS methodology, reporting dashboard (webinar + playbook)

### 10.6.4  Fallback planning
Run *table‑top exercises* for:
1. PQC handshake failure in production causing 5xx spike.
2. Upstream library CVE requiring emergency algorithm swap.
3. Supplier unable to deliver CBOM by contractual date.

Each scenario results in a *response run‑book* with RACI mapping and MTTR target.


## 10.7  Outputs and deliverables
* **Master roadmap** (interactive Gantt or Kanban) stored in PMO repository.
* **Budget & resource plan** linked to finance system cost centres.
* **Supplier tracker** – contract ID, CBOM status, PQC clause compliance.
* **Risk‑adjusted timeline** – spreadsheet showing QARS, PI, and planned migration date per asset.

All deliverables should version via Git (for content) and SharePoint/Confluence (for presentation decks).  Use semantic version tags (e.g., `roadmap‑v1.1.0`) to sync with Document Control.


## 10.8  Quality gates & KPIs
| Gate | Artefacts required | Approver | KPI trigger |
|------|-------------------|----------|-------------|
| **G1 – Inventory lock** | CBOM freeze, gap register | CISO | < 95 % asset coverage |
| **G2 – Pilot go‑live** | Run‑book, rollback plan, test report | Head of Ops | Error rate > 0.1 % |
| **G3 – High‑risk cut‑over** | External audit attestation | Regulator liaison | Audit finding severity > “medium” |
| **G4 – Programme closure** | Lessons‑learned report, metrics dashboard | Board | MTTR‑C > 30 days |

Key performance indicators track *Predictability* (variance vs. baseline), *Quality* (defects, CVEs), and *Crypto‑compliance* (% PQC certs).


## 10.9  Common pitfalls & how to avoid them
1. **Over‑reliance on vendor roadmaps** – mitigate by testing open‑source PQC libraries in parallel.
2. **Ignoring hidden dependencies** (e.g., SSO tokens signed with RSA) – mandate *dependency graph export* before migration.
3. **Resource starvation** during long tail of low‑risk systems – secure multi‑year budget with ring‑fenced FTEs.
4. **One‑shot big‑bang** migrations – favour *incremental hybrid* roll‑outs with fast rollback.
5. **Communication gaps** – publish monthly progress dashboards to executives and teams.

## 10.10  References
* European Union (2025). *Coordinated Implementation Roadmap for Post‑Quantum Cryptography*.
* TNO (2024). *Post‑Quantum Cryptography Handbook*.
* NIST (2024). *FIPS 203, 204, 205*.
* Mosca, M., et al. (2023). "Cloud migration timelines for quantum risk".



