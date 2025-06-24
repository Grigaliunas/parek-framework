# 12 K – Key‑Governance & Continuous Improvement


> **Purpose of this chapter** – define how EU‑based organisations maintain crypto‑agility, monitor post‑quantum cryptography (PQC) compliance, and sustain supplier accountability after initial migrations are complete.  Governance mechanisms align with **NIS 2**, **DORA**, **GDPR**, the forthcoming **EU Cyber Resilience Act (CRA)**, and ENISA good‑practice guidelines.


## 12.1  Governance objectives (≈ 100 words)
1. **Assurance** – demonstrate to EU supervisory authorities (e.g., NIS Cooperation Group, ECB‑SSM, EBA) that PQC controls remain effective.
2. **Transparency** – provide board‑level and regulator‑level dashboards for cryptographic health.
3. **Continuous agility** – support hot‑swaps to new PQC algorithms (e.g., ML‑KEM→ML‑KEM‑1024) without business disruption.
4. **Incident resilience** – detect, triage and remediate crypto failures within predefined Mean Time to Remediate Crypto (MTTR‑C) targets.


## 12.2  Organisational structure (≈ 150 words)
| Body                                | Frequency | Mandate                                                          | EU reference |
| ----------------------------------- | --------- | ---------------------------------------------------------------- | ------------ |
| **PAREK Steering Committee**        | Quarterly | Approve metrics, budget, policy updates                          | NIS 2 Art.20 (management oversight) |
| **Crypto Governance Office (CGO)**  | Monthly   | Operate dashboards, coordinate audits, own algorithm policy      | ENISA Good Practice 4.2 |
| **Crypto Review Board (CRB)**       | Ad hoc    | Assess new algorithms/parameters, sanction emergency swaps       | ETSI TS 119 996 input |
| **Supplier Cryptography Board (SCB)**| Quarterly | Review Tier‑1 supplier attestation and CBOM status               | CRA Art.35 (supplier obligations) |

Role mappings live in `part3/14-raci.md`.


## 12.3  Policy stack (≈ 120 words)
1. **Cryptographic Policy (CP‑01)** – lists approved algorithms, key lengths and protocols; revision every 6 months.
2. **Key Management Standard (KMS‑EU‑02)** – describes lifecycle (generation, storage in EU Qualified Trust Service Provider (QTSP) HSMs, rotation, destruction).
3. **Algorithm Deprecation Procedure (ADP‑03)** – triggers, timelines and communication templates for banning weak algorithms.
4. **Supplier Cryptography Policy (SCP‑04)** – references §13 PQC Annex, aligns with CRA Article 10.

Policies are version‑controlled in Git (`/policy/*`) and published to the intranet Confluence space `PQC/Policies`.


## 12.4  Metrics & KPIs (≈ 200 words)
| KPI ID | Metric                                           | Target | EU linkage |
| ------ | ------------------------------------------------ | ------ | ---------- |
| **K‑1** | % Assets with valid CBOM (< 24 h old)            | ≥ 98 % | CRA Art.23 (SBOM/CBOM) |
| **K‑2** | Unsupported algorithm instances detected        | 0      | NIS 2 Art.21 (technical measures) |
| **K‑3** | Mean Time to Remediate Crypto (MTTR‑C)          | ≤ 30 days high‑risk; ≤ 90 days medium | DORA RTS on ICT risk |
| **K‑4** | % Supplier attestations received on time        | ≥ 95 % | CRA Art.35 |
| **K‑5** | Annual crypto penetration test coverage         | 100 % Tier‑1, 80 % Tier‑2 | EBA Guidelines (ICT security) |

All KPIs surface in Grafana dashboard `PQC › Governance › EU Metrics` and feed quarterly NIS 2 reports.


## 12.5  Continuous CBOM scanning (≈ 150 words)
A **CBOM Delta Scanner** (Rust microservice) polls the CBOM graph database hourly, compares it with the last approved baseline and flags:
- **Additions** – new algorithms or keys not in policy.
- **Deletions** – removed assets (possible shadow IT).
- **Parameter drift** – changed key size or version.

Alerts integrate with ServiceNow (CIRF module).  False positives must be closed within 72 h.  All deltas export to `assets/reports/cbom-delta-YYYY‑MM‑DD.csv` for audit evidence.


## 12.6  Algorithm lifecycle management (≈ 180 words)
### 12.6.1  Evaluation pipeline
1. **Research ▶ Intake** – CGO tracks NIST, ETSI, CEN/CENELEC outputs.
2. **Lab benchmark** – CRB benchmarks latency, CPU, memory on reference workloads.
3. **Security review** – external academic peer review (EU PQC Consortium).
4. **Pilot flag** – enable new algorithm behind feature flag for selected services.
5. **Policy update** – if successful, CP‑01 revision published.

### 12.6.2  Deprecation stages
| Stage | Marker                          | Timeline |
| ----- | -------------------------------- | -------- |
| **Proposed**   | New candidate algorithm in ETSI draft | 0 months |
| **Approved**   | Added to CP‑01                        | +6 mths  |
| **Mandatory**  | Required for all new deployments     | +18 mths |
| **Forbidden**  | Outgoing algorithm banned            | +36 mths |

Communication packs sent via email and intranet; affected product owners get Jira tasks auto‑generated.


## 12.7  Incident response & reporting (≈ 150 words)
Crypto incidents are handled under the **EU NIS 2 major incident** framework:

1. **Detection** – SOC rule “unsupported_ciphersuite” fires.
2. **Initial report** – Incident Response Team logs case in TheHive; notif to national CSIRT within 24 h.
3. **Containment** – activate rollback script or key rotation.
4. **Eradication** – remove bad certs, patch firmware.
5. **Post‑incident report** – deliver ENISA‑template report within 72 h to competent authority.
6. **Lessons‑learned review** – CRB updates ADP‑03 or KMS‑EU‑02.

All steps timestamped; evidence archived in EU datacentre (GDPR compliant).


## 12.8  Audit & assurance (≈ 120 words)
- **Internal audit** – annual review aligned with ISAE 3402, reports to Audit Committee.
- **External audit** – Big 4 or qualified auditor validates KPIs, CBOM process, compliance with CRA and NIS 2.
- **Regulator review** – ECB‑SSM may request additional evidence for systemically important banks; DORA mandates ICT third‑party risk audits.

Audit findings tracked in Jira project `AUDIT‑PQC`; remediation owned by CGO.


## 12.9  Integration with other PAREK stages (≈ 100 words)
- **From Stage E** – deployment telemetry populates KPIs K‑1 to K‑3.
- **To Stage P** – CBOM deltas feed new asset discovery.
- **To Stage R** – maturity scores influence roadmap reprioritisation.
- **With Stage A** – incident metrics adjust Exposure Surface Index for QARS re‑runs.


## 12.10  Future EU developments (≈ 80 words)
The **EU Digital Identity Wallet** regulation (eIDAS 2) will require PQC‑capable Qualified Electronic Signatures (QES) by 2030.  The **EU AI Act** may impose additional controls for cryptographic integrity in AI systems.  Governance policy CP‑01 plans review cycles aligned to these legislative sunsets.


## 12.11  References
1. ENISA (2025). *Good Practices for Crypto‑Agility and Post‑Quantum Preparedness*.
2. European Commission (2023). *NIS 2 Directive*.
3. European Parliament (2025). *Cyber Resilience Act – final text*.
4. ECB‑SSM (2024). *Cyber Resilience Oversight Expectations for FMIs*.
5. ETSI (2024). *TS 119 996 – Algorithm Agility Guidance*.
6. CEN/CENELEC (2025). *PQC Standards Roadmap*.

