# 7  Framework Overview

> **Purpose of this chapter** – give readers a *one‑stop* visual and narrative tour of the PAREK Framework, explaining how its five stages interlock, what artefacts they exchange, and how the cycle repeats to deliver continuous crypto‑agility.


## 7.1  At‑a‑glance diagram

```
┌────────┐   Discover     ┌─────────────┐   Quantify     ┌───────────┐   Plan     ┌─────────┐  Deploy     ┌────────────┐  Monitor
│   P    │──────────────►│      A      │──────────────►│     R     │──────────►│    E    │────────────►│      K     │──┐
│ Asset  │   CBOM JSON    │  Risk Score │   QARS heatmap │ Road‑map  │  Gantt      │ Migration│  Telemetry   │  Metrics   │  │
│  Inv   │◄──────────────│             │◄──────────────│           │◄──────────│          │◄────────────│           │◄─┘
└────────┘   Gaps & todo   └─────────────┘   Feedback     └───────────┘  Budget     └─────────┘  Incidents   └────────────┘
```

*Figure 1 – PAREK Framework life‑cycle (high‑level data flow)*


## 7.2  Stage synopses

### 7.2.1  **P – Post‑Quantum Asset & Algorithm Inventory**

*Goal* – create a machine‑readable **Cryptography Bill of Materials (CBOM)** for every software, hardware and service component. Uses automated scanners, manual surveys and supplier attestations. Output feeds directly into Stage A.

### 7.2.2  **A – Assessment of Quantum Risk**

*Goal* – compute a **Quantum‑Adjusted Risk Score (QARS)** for each asset by blending data shelf‑life, migration effort and CRQC timeline inputs. High‑risk items graduate to Stage R while low‑risk items loop back for periodic re‑assessment.

### 7.2.3  **R – Road‑mapping & Readiness Planning**

*Goal* – translate scores into a time‑phased, resourced roadmap aligned to EU milestones (2026‑2035). Outputs Gantt charts, budget forecasts, and supplier alignment plans. Detailed in §10.

### 7.2.4  **E – Execution & Migration**

*Goal* – deploy PQC or hybrid primitives using controlled roll‑outs, rollback strategies and performance monitoring. Produces migration run‑books and incident telemetry.

### 7.2.5  **K – Key‑Governance & Continuous Improvement**

*Goal* – sustain crypto‑agility through continuous scanning, supplier attestations, KPIs and policy refreshes. Feeds new discoveries back to Stage P, closing the loop.


## 7.3  Artefact hand‑offs

| From ▶ To | Artefact                               | Format                | Purpose                          |
| --------- | -------------------------------------- | --------------------- | -------------------------------- |
| P ▶ A     | CBOMs (per system)                     | CycloneDX JSON + sig  | Input for risk scoring           |
| A ▶ R     | QARS risk registry                     | CSV / Grafana feed    | Prioritise backlog               |
| R ▶ E     | Work‑package definitions               | Jira Epics + Stories  | Guide migration teams            |
| E ▶ K     | Deployment telemetry, incident reports | Prometheus / GRC logs | Measure success, trigger alerts  |
| K ▶ P     | Revised asset list, KPIs               | JSON diff, dashboard  | Refresh inventory & repeat cycle |


## 7.4  Governance layers

### 7.4.1  Strategic layer

*PAREK Steering Committee* (quarterly) endorses roadmaps, budget, and policy changes.

### 7.4.2  Operational layer

*Crypto Working Group* (monthly) coordinates cross‑team dependencies, tooling upgrades and incident response.

### 7.4.3  Tactical layer

Dedicated *Migration Squads* execute Jira stories, report blockers and feed metrics to dashboards.


## 7.5  Alignment with PQC Methodology (§6)

Section 6 introduces the **discover → assess → plan → execute → improve** cycle at conceptual level.  This chapter grounds that abstract model in concrete artefacts, roles and data flows, forming the *Rosetta Stone* that maps theory to practice.

Key alignment points:

- **Inventory before surgery** principle manifests as the strict P ▶ A gate.
- **Crypto‑agility first** translates into K metrics (# low‑risk ECDSA certs trending → 0).


## 7.6  Integration with supply‑chain (§13)

Supplier CBOMs are imported into Stage P; supplier roadmaps and compliance clauses sit in Stage R; supplier attestation SLAs are monitored in Stage K.  Thus, the framework treats third‑party components as *co‑equal citizens* in the life‑cycle.


## 7.7  Quality gates & escalation paths

```
[Gate G1] CBOM coverage ≥ 95 % —► proceed to Stage A  | else: raise Inventory CAPA
[Gate G2] QARS sign‑off by CISO —► proceed to Stage R  | else: re‑score anomalies
[Gate G3] Budget approval —► proceed to Stage E        | else: escalate to CFO
[Gate G4] KPI trend green 3 months —► close loop       | else: open incident review
```

Each gate has an *owner*, *entry criteria* and *exit criteria*, ensuring accountability.


## 7.8  Toolchain reference stack

| Stage | Open‑source baseline tools              | Commercial alternatives             |
| ----- | --------------------------------------- | ----------------------------------- |
| P     | **oqs‑scanner**, `cyclonedx‑python‑lib` | Venafi TLS Protect, Fortanix DSM    |
| A     | `pandas + risk‑calc.py`                 | RSA Archer, ServiceNow VRM          |
| R     | `ganttlab`, GitLab Road‑maps            | Atlassian Advanced Roadmaps         |
| E     | `openssl‑oqs`, QEMU testbed             | Entrust nShield, Thales CipherTrust |
| K     | Grafana, Prometheus                     | Splunk ES, Elastic SIEM             |

A Terraform module (`scripts/terraform/parek‑stack.tf`) provisions the open‑source stack for pilots.


## 7.9  Maturity model

| Level                | Characteristics                                  | Typical KPI values          |
| -------------------- | ------------------------------------------------ | --------------------------- |
| **1 – Ad hoc**       | No CBOM, PQC unknown, vendors unmanaged          | SC‑1 < 10 %                 |
| **2 – Defined**      | Static inventory, pilot QARS, roadmap draft      | SC‑1≈50 %, QARS cov. ≥ 30 % |
| **3 – Managed**      | Approved roadmap, hybrid pilots in prod          | SC‑1≥90 %, KPI trend ↑      |
| **4 – Quantitative** | Real‑time metrics, full PQC for high‑risk assets | KPI SLA ≤ 5 % viol.         |
| **5 – Optimising**   | Continuous crypto‑agility, auto‑rotation         | Zero unsupported algs       |

Stage K owns the maturity assessment and reports progression each quarter.


## 7.10  Next steps for readers

- **Architects** – dive into §8–12 for deep‑dive guidance per stage.
- **Project managers** – reference §10 for detailed timelines and resource models.
- **Suppliers** – jump to §13 for contract clauses and CBOM spec requirements.

