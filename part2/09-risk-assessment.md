### A – Assessment of Quantum Risk***

> **Purpose of this chapter** – define a repeatable, data‑driven methodology for quantifying how urgently each system, data set or supplier must migrate to post‑quantum cryptography.  The output of this stage—**Quantum‑Adjusted Risk Scores (QARS)**—feeds Road‑mapping (§10) and underpins budget and resource prioritisation.


## 9.1  Why risk scoring matters 

Cryptographic migration budgets are finite, systems are heterogeneous, and CRQC timelines are uncertain.  A robust risk model ensures that *business‑critical, long‑lived* data is protected first, while low‑impact assets follow a just‑in‑time trajectory.  Without quantification, organisations either under‑invest (and face data‑exposure liability) or over‑invest (and stall other security priorities).  The QARS model harmonises quantitative (years, euros, CVSS‑scores) and qualitative (business impact, regulatory penalty) inputs into a single comparable metric.


## 9.2  Inputs and prerequisites 

| Input                                 | Source                   | Refresh cadence |
| ------------------------------------- | ------------------------ | --------------- |
| Cryptography Bill of Materials (CBOM) | Stage P (§8)             | Nightly         |
| Data‑classification registry          | GDPR/NIS‑2 policy owners | Quarterly       |
| CRQC threat horizon (`T_threat`)      | §5 + external forecasts  | Annual + ad hoc |
| Migration effort estimates            | Architecture & dev‑ops   | Sprintly        |
| Exposure Surface Index (ESI)          | Pentest/vuln‑scan teams  | Monthly         |

If any CBOM asset lacks a data‑classification tag or migration estimate, it is flagged “information incomplete” and cannot be scored until gaps are resolved.


## 9.3  The QARS formula 

PAREK extends Mosca’s inequality into a **multi‑factor linear model**:

```
QARS = w₁·(T_shelf / T_threat) + w₂·(T_migration / T_buffer) + w₃·Data_Sensitivity +
       w₄·Exposure_Surface + w₅·Compliance_Penalty
```

| Symbol               | Explanation                                   | Scale |
| -------------------- | --------------------------------------------- | ----- |
| `T_shelf`            | Required confidentiality window (years)       | 0–25+ |
| `T_threat`           | Forecast years until CRQC (default = 9–15)    | 0–20  |
| `T_migration`        | Estimated time to complete PQC rollout (yrs)  | 0–5   |
| `T_buffer`           | Policy‑set buffer (yrs, default = 2)          | fixed |
| `Data_Sensitivity`   | GDPR Level 1‑3 or internal A‑E scale          | 0.1‑1 |
| `Exposure_Surface`   | Normalised count of public endpoints & CVEs   | 0‑1   |
| `Compliance_Penalty` | 0.2 if asset falls under NIS‑2 critical infra | 0/0.2 |

Weights `w₁…w₅` default to **0.30 / 0.20 / 0.25 / 0.15 / 0.10** but can be re‑tuned at sector level (e.g., finance may increase sensitivity weight to 0.35).  QARS outputs a **unitless value between 0 and 1** where ≥ 0.65 = *high*, 0.35–0.64 = *medium*, < 0.35 = *low*.


## 9.4  Data‑collection pipeline 

1. **Ingest** – nightly ETL job pulls CBOM JSON, joins CMDB IDs, merges data‑classification tags.
2. **Enrich** – scrape CVE feeds (NVD) to calculate Exposure Surface Index for IP addresses/certs.
3. **Estimate** – dev‑ops provides story‑point‑based migration effort which converts to months via team velocity.
4. **Compute** – Python microservice (`scripts/qars_calc.py`) applies formula; outputs per‑asset records to Postgres and Grafana.
5. **Validate** – security architects review anomalies (e.g., QARS > 0.9 for “low” data system) via Jira workflow.

All stages run in a dedicated Kubernetes namespace with signed container images; audit logs export to Splunk for regulator access.


## 9.5  Visualising risk 

Default dashboards include:

- **Heat‑map** – assets on x‑axis (systems) vs. y‑axis (QARS); colour gradient highlights urgency.
- **Scatter** – `T_shelf` on x, `T_migration` on y; diagonal line shows Mosca boundary.
- **Burndown** – number of high‑risk assets over time; target trend = zero by Q4 2030.

Grafana JSON for these panels is stored under `assets/grafana/qars_dash.json`.


## 9.6  Quality gate G2 – QARS sign‑off 

Before Stage R can commence, the CISO (or delegate) must approve:

1. **Coverage** – ≥ 90 % of in‑scope assets have non‑null QARS.
2. **Accuracy** – sample audit (10 %) shows < 5 % variance between estimated and observed parameters.
3. **Documentation** – methodology, weight settings, data sources captured in Confluence page `PQC/Risk‑Method`.

Failure to meet criteria pauses migration planning; corrective actions logged in the *Risk Management* Jira project.


## 9.7  Scenario analysis 

PAREK requires bi‑annual **scenario runs** to test sensitivity:

| Scenario ID        | `T_threat` assumption | Outcome metric           | Implication                        |
| ------------------ | --------------------- | ------------------------ | ---------------------------------- |
| **S‑A (Fast)**     | 5 yrs (2029)          | ΔHigh‑risk assets + 35 % | Budget re‑prioritisation needed    |
| **S‑B (Baseline)** | Median 9 yrs (2034)   | n/a                      | Reference roadmap                  |
| **S‑C (Delayed)**  | 15 yrs (2040)         | ΔBudget – 18 %           | Optional slow‑track for low assets |

Results feed the CFO’s risk‑adjusted cost model; Stage 10 picks whichever roadmap keeps high‑risk completion <= 3 yrs before `T_threat`.


## 9.8  Integration with supplier risk 

Supplier CBOMs (Tier 1 & 2) receive QARS as well.  Additional factor `Supplier_Maturity` (scale 0–0.2) reduces QARS if vendor demonstrates crypto‑agility lab results.  Non‑compliant suppliers auto‑escalate to *Supplier Risk Queue* (§13) and may face contract penalties.


## 9.9  Common pitfalls & mitigations (≈ 100 words)

1. **Stale data** – automate nightly refresh; raise alert if CBOM timestamp > 7 days.
2. **Weight gaming** – lock weights quarter‑by‑quarter; require Steering approval for changes.
3. **False precision** – present score bands (high/med/low) to execs, not raw decimals.
4. **Blind spots** – add “Unknown” category and track reduction KPI.


## 9.10  Outputs

- `risk_registry.csv` – asset‑level QARS, drivers, timestamp.
- Grafana dashboard – URL `/d/qars/quantum‑risk`.
- Executive slide deck template (`assets/templates/qars‑brief.pptx`).


## 9.11  Next steps

Hand off risk‑registry to Stage R for roadmap planning.  Schedule next scenario analysis within 6 months or sooner if IBM announces ≥ 1 M qubits.


## 9.12  References

1. Mosca, M. (2023). *Risk Framework for Quantum Threats*.
2. Global Risk Institute (2024). *Quantum Threat Timeline Report*.
3. ENISA (2024). *Good Practices for Supply‑chain Risk Management*.
4. NIST (2024). *Post‑Quantum Cryptography FIPS 203‑205*.
5. IBM (2025). *Quantum Roadmap*.



