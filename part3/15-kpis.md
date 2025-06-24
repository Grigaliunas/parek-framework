###15 KPIs & Reporting Dashboard" authors***

> **Purpose of this chapter** – define the key‑performance indicators (KPIs), data flows and reporting dashboards that quantify progress and operational health of the PAREK Programme.  Metrics are calibrated to EU supervisory expectations under **NIS 2**, **DORA** and the forthcoming **Cyber Resilience Act (CRA)**.


## 15.1  Why KPIs matter (≈ 120 words)

The EU regulatory shift from *best‑effort* to *demonstrable assurance* means boards must produce hard evidence that quantum‑risk controls are working.  KPIs convert the qualitative objectives of PAREK into quantifiable signals that:

1. **Steer execution** – highlight bottlenecks early.
2. **Inform regulators** – feed mandatory NIS 2 incident and compliance reports.
3. **Drive supplier accountability** – tie contract penalties/bonuses to measurable outcomes.

Without robust KPIs, crypto‑agility devolves into one‑off migrations, risking drift and audit findings.


## 15.2  KPI taxonomy (≈ 100 words)

KPIs are grouped into three tiers:

| Tier                 | Audience          | Frequency | Purpose                                |
| -------------------- | ----------------- | --------- | -------------------------------------- |
| **T1 – Executive**   | Board, regulators | Quarterly | Programme health, compliance status    |
| **T2 – Operational** | CISO, CGO, PMO    | Monthly   | Stage‑level performance, SLA breaches  |
| **T3 – Tactical**    | Dev‑Ops squads    | Daily     | Deployment metrics, incident telemetry |

This chapter lists core Tier 1 and Tier 2 KPIs.  Tactical metrics are documented in Stage E run‑books.


## 15.3  Core KPI catalogue (≈ 250 words)

| KPI ID   | Stage link | Metric (EU aligned)                                | Calculation / data source                    | Target         | Alert threshold      | Reg. mapping       |
| -------- | ---------- | -------------------------------------------------- | -------------------------------------------- | -------------- | -------------------- | ------------------ |
| **P‑1**  | P          | CBOM coverage                                      | `#assets with valid CBOM / #assets in scope` | ≥ 98 %         | < 95 %               | CRA Art 23         |
| **A‑1**  | A          | High‑risk assets (QARS ≥ 0.65) remaining           | Count from `risk_registry.csv`               | → 0 by 2029‑Q4 | > Baseline trendline | NIS 2 Art 21       |
| **R‑1**  | R          | Schedule variance                                  | `planned finish – actual` (days)             | ± 0–10 days    | > 15 days            | DORA Art 12        |
| **E‑1**  | E          | PQC handshake success rate                         | Envoy / Prometheus metric                    | ≥ 99.9 %       | < 99.5 %             | NIS CSIRT guidance |
| **E‑2**  | E          | Median handshake latency delta                     | `PQC_latency – baseline_latency`             | ≤ +5 ms        | > +10 ms             | ENISA perf. rec.   |
| **K‑1**  | K          | Unsupported algorithm instances detected           | Zeek/Suricata rules                          | 0              | > 0                  | GDPR Art 32        |
| **K‑2**  | K          | Mean Time to Remediate Crypto (MTTR‑C) – high‑risk | `Σ resolution time / # incidents`            | ≤ 30 days      | > 45 days            | DORA RTS           |
| **SC‑1** | §13        | Suppliers with on‑time CBOM and attestation        | `#compliant / #total suppliers`              | ≥ 95 %         | < 90 %               | CRA Art 35         |
| **M‑1**  | §10        | Programme budget adherence                         | `actual spend / budget`                      | ≤ 110 %        | > 120 %              | Board policy       |


## 15.4  Data architecture (≈ 150 words)

```
CBOM API ─┐                 ┌──► Postgres (risk_registry) ──► Grafana API
          │   Lambda ETL   │
Zeek logs ─┤──► Kafka bus ──┤
          │                 │
Jira API ──┘                 └──► Prometheus (E‑metrics) ───► Grafana API
```

- **Ingest layer** – Kafka collects CBOM deltas, Zeek alerts, deployment metrics.
- **Storage layer** – time‑series in Prometheus; relational in Postgres.
- **Analytics layer** – Python notebook (`scripts/analysis/kpi_report.ipynb`) calculates monthly aggregates.
- **Visual layer** – Grafana dashboards; snapshots auto‑export as PNG for board packs.

All components run in EU datacentres (GDPR Art 44 compliant).  Access controls via Azure AD groups.


## 15.5  Dashboard design (≈ 120 words)

### Executive dashboard

- **Gauge** – CBOM coverage (P‑1)
- **Stacked bar** – High/medium/low assets over time (A‑1)
- **Line** – Budget vs. actual (M‑1)
- **Heat‑map** – Supplier compliance (SC‑1)

### Operational dashboard

- **Table** – Unsupported algorithm findings (K‑1) by business unit
- **Histogram** – MTTR‑C distribution (K‑2)
- **Sankey** – Incident cause → resolution path
- **Alert panel** – Live E‑metrics (E‑1, E‑2)

Grafana JSON imports stored under `assets/grafana/kpi_dashboards/`.


## 15.6  Governance & review cadence (≈ 120 words)

| Report               | Audience   | Frequency | Delivery channel   | Owner |
| -------------------- | ---------- | --------- | ------------------ | ----- |
| KPI snapshot (PDF)   | Board      | Quarterly | SharePoint / email | PMO   |
| KPI drill‑down deck  | CGO        | Monthly   | Confluence         | CGO   |
| KPI raw export (CSV) | Regulators | Annual    | SFTP to CSIRT      | CISO  |

Each quarter, the Steering Committee reviews trend deltas.  Any KPI breaching alert threshold triggers a **Corrective Action Plan (CAP)** logged in Jira.


## 15.7  Continuous improvement loop (≈ 100 words)

1. **Detect** – KPI alert fires.
2. **Diagnose** – Root‑cause analysis meeting within 5 days.
3. **Decide** – CRB or CGO selects remediation (e.g., policy tweak, supplier escalation).
4. **Deliver** – Squad implements; KPI flagged “watch” for 30 days.
5. **Document** – Lessons‑learned stored in Confluence.

KPIs themselves undergo annual review (Stage K).  Weightings or new metrics added through change‑control procedure CP‑01‑KPI‑UPDATE.


## 15.8  EU regulatory reporting alignment (≈ 120 words)

- **NIS 2** – P‑1, K‑1, K‑2 feed into the *Security Measures* section of the annual NIS 2 compliance report sent to the national CSIRT.
- **DORA** – K‑2, E‑metrics underpin the ICT Risk Management template required by ESAs.
- **CRA** – SC‑1 and CBOM coverage support product security declarations.
- **ECB TIBER‑EU** – A‑1 trend informs the threat‑intelligence baseline for red‑team tests.

Mapping table maintained at `assets/compliance/kpi‑eu‑map.xlsx`.

## 15.9  Common pitfalls & mitigations (≈ 100 words)

1. **Metric overload** – focus on < 15 KPIs; archive vanity metrics.
2. **Gaming the numbers** – random audits of data sources; automated anomaly detection.
3. **Stale dashboards** – CI job fails; alert on last data‑refresh timestamp > 1 day.
4. **One‑size targets** – calibrate KPIs per business unit; avoid blanket thresholds.


## 15.10  Next steps

- Finalise Grafana dashboard JSON after Sections 8–12 baseline metrics.
- Include KPI snapshot in next Board pack (Q3 2025).
- Schedule ENISA‑style KPI workshop for suppliers (Q4 2025).


## 15.11  References

1. ENISA (2024). *Guidelines on KPIs for Cybersecurity Measures*.
2. European Commission (2023). *NIS 2 Directive*.
3. European Parliament (2025). *Cyber Resilience Act – Final Text*.
4. EBA (2024). *ICT Risk Management under DORA*.
5. Grafana Labs (2025). *Best Practices for KPI Dashboards*.

