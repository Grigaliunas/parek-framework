# 13 Supply‑Chain Integration

> **Purpose of this chapter** – embed post‑quantum cryptography (PQC) requirements into the entire supplier life‑cycle so that every external component, cloud service and piece of hardware entering the organisation’s environment supports PAREK objectives and timelines.


## 13.1  Why supply‑chain matters in the quantum era 

Modern digital estates are a mosaic of proprietary SaaS APIs, open‑source libraries, OEM devices and managed service providers.  Research by ENISA shows that 75 % of successful crypto‑deprecation projects failed **not** because internal teams resisted change but because third‑party dependencies lagged two to three years behind security roadmaps.  Quantum migration exacerbates this risk: a single RSA‑signed software update from a vendor can re‑introduce vulnerable primitives across thousands of endpoints.  Therefore, PQC adoption is no longer an internal programme but a **supply‑chain transformation endeavour**.  Section 13 defines the contractual hooks, technical artefacts (CBOM/SBOM), validation workflows and governance forums required to make suppliers first‑class citizens in the PAREK lifecycle.

## 13.2  Scope and definitions

**Supplier** means any external legal entity that designs, builds, sells or operates software, hardware or services running in, or interfacing with, the organisation’s production or pre‑production environments.  This includes SaaS providers, IaaS/PaaS cloud vendors, OEM hardware suppliers, open‑source project maintainers (where code is bundled), consultants and contract developers.  **Supply‑chain integration** spans four control layers: *onboarding*, *contracting*, *operation*, and *termination*.  The chapter applies to all suppliers whose deliverables contain or rely on cryptographic functions, regardless of whether those functions are explicitly exposed to the organisation (e.g., TLS) or hidden inside firmware.


## 13.3  Objectives 

1. **Cryptographic transparency** – every supplier must furnish a machine‑readable Cryptography Bill of Materials (CBOM) aligned to CycloneDX v1.6.
2. **PQC readiness** – high‑risk suppliers deliver PQC‑capable builds by 2028; medium‑risk by 2031.
3. **Continuous assurance** – suppliers attest quarterly that no unsupported algorithms (RSA≤2048, ECC P‑256, SHA‑1) appear in deliverables.
4. **Incident response** – suppliers notify the organisation within 24 hours of any crypto‑related CVE with a CVSS score ≥ 7.0.


## 13.4  Supplier segmentation model

The organisation classifies suppliers into **three tiers**:

| Tier                | Criteria                                                        | Examples                                 | Governance cadence                  |
| ------------------- | --------------------------------------------------------------- | ---------------------------------------- | ----------------------------------- |
| **1 – Strategic**   | Provides mission‑critical platforms or handles classified data. | Core banking engine, national ID cloud.  | Quarterly steering; on‑site audits. |
| **2 – Operational** | Supports key business processes but without systemic impact.    | CRM SaaS, managed network.               | Semi‑annual review; remote audit.   |
| **3 – Commodity**   | Easily replaceable, low data sensitivity.                       | Peripheral hardware, bulk email gateway. | Annual self‑assessment.             |

The tier determines the depth of CBOM detail, test evidence, and contract clauses required.  Tier 1 suppliers must present signed CBOMs, PQC migration roadmaps and evidence of internal crypto‑agility testing.  Tier 3 suppliers may supply a simplified attestation if they leverage a certified Tier 1 sub‑provider.


## 13.5  Contractual requirements 

All new or renewed contracts **must** include a *PQC Annex* covering:

1. **CBOM delivery schedule** – initial CBOM within 30 days of contract signature; refreshed artefact with each major release or monthly for SaaS.
2. **PQC migration milestones** – align with the organisation’s roadmap (§10):
   - Kyber/Dilithium hybrid capability in test by **2027‑12‑31**.
   - FIPS‑validated PQC primitives in production by **2030‑06‑30** for Tier 1; **2031‑12‑31** for Tier 2.
3. **Algorithm deprecation clause** – supplier shall not introduce or re‑enable algorithms listed on the organisation’s *Forbidden Algorithm List* (FAL).
4. **Crypto incident SLA** – acknowledge within 2 business hours; provide root‑cause analysis within 5 working days.
5. **Audit & testing rights** – organisation may perform penetration tests focused on cryptographic endpoints once per calendar year, subject to 10 days’ notice.
6. **Termination for non‑compliance** – failure to meet milestone dates may trigger penalty fees up to 5 % of annual contract value or early termination.

> *Tip –* Legal teams should store the PQC Annex as a standalone template (assets/contracts/pqc‑annex.docx) to streamline procurement.  All clauses reference external artefacts (CBOM spec, FAL) by version number to avoid re‑negotiation when the lists update.


## 13.6  Technical artefacts and interfaces (≈ 300 words)

### 13.6.1  Cryptography Bill of Materials (CBOM)

A CBOM is a JSON document (CycloneDX schema `component:type="cryptography"`) listing:

- Algorithm (e.g., `rsa2048`, `ml‑kem‑768`)
- Protocol context (`tls1.3`, `ssh2`) and key sizes
- Certificates or key IDs, including expiry and usage (signing, encryption)
- Hardware anchoring (TPM, HSM model & firmware version)
- Compliance tags (FIPS 203, CC EAL4+)

Suppliers must sign the CBOM using DSSE (in‑toto) and attach the signature envelope as `*.cbom.sig`.

### 13.6.2  SBOM‑CBOM linkage

If a supplier already provides a Software Bill of Materials (SBOM), the CBOM should reference SBOM components via `bom‑link` for traceability.  Example snippet:

```json
{
  "bom‑link": "urn:uuid:123e4567‑e89b‑12d3‑a456‑426614174000",
  "algorithm": "ml‑kem‑768",
  "context": "tls1.3",
  "status": "hybrid"
}
```

### 13.6.3  Delivery channels

- **API** – Tier 1 suppliers push CBOMs to `/api/v1/cbom` with OAuth 2.0 MTLS.
- **S3 bucket** – Tier 2 post JSON files to `s3://cbom‑uploads/<supplier>/<YYYY‑MM>/`.
- **Email gateway** – Tier 3 may email CBOMs signed with PGP; files routed to an ingest Lambda.

### 13.6.4  Validation pipeline

Upon receipt, the organisation’s **Crypto Intake Service** performs:

1. **Schema validation** – rejects non‑conformant JSON.
2. **Signature check** – DSSE verification against supplier’s root cert.
3. **Policy scan** – flag forbidden algorithms; raise ticket if found.
4. **Graph merge** – append assets to central CBOM graph database.

Failures trigger alerts to the *Supplier Risk Queue* (Jira project `SRQ`).


## 13.7  Supplier assessment workflow (≈ 180 words)

The following swim‑lane illustrates the annual assessment for a Tier 1 supplier:

```
Supplier ─┬─► Submit self‑assessment (questionnaire Q‑PQC‑001)
          │
Risk Team ├─► Score questionnaire (scale 0‑5)
          │
Crypto‑Sec COE ├─► Review CBOM → run lab tests (hybrid TLS)
              │
Procurement ─┴─► Evaluate penalties/bonuses → update contract
```

Scores below 3 trigger a **Corrective Action Plan (CAP)**.  CAP tasks are tracked in the PAREK Programme backlog and must close within 90 days.  Suppliers with sustained scores ≥4 across two consecutive assessments may earn incentive rebates (1 % of contract value) or preferred tender status.


## 13.8  Tooling ecosystem (≈ 150 words)

| Function            | Recommended tool / spec | Notes                   |
| ------------------- | ----------------------- | ----------------------- |
| CBOM authoring      | `cyclonedx‑python‑lib`  | CLI + library support   |
| DSSE signing        | `sigstore/cosign`       | Leverage Fulcio CA      |
| Validation pipeline | Custom Go microservice  | Pluggable policy engine |
| Graph storage       | Neo4j or Amazon Neptune | Supports GraphQL API    |
| Dashboard & KPIs    | Grafana + Prometheus    | CBOM ingestion metrics  |

Integration playbooks live under `scripts/integration/` with Terraform modules for AWS and Azure, ensuring suppliers can spin up the same pipeline in their staging environments.


## 13.9  Governance forums (≈ 120 words)

- **Quarterly Supplier Cryptography Board (SCB)** – chaired by the CISO; Tier 1 suppliers present migration progress.  Outputs: meeting minutes, updated risk register.
- **Monthly CBOM Ops Call** – operational teams review ingestion metrics, false‑positive rates, upcoming schema changes.
- **Annual PQC Summit** – all suppliers invited; roadmap updates, lessons learned, and tooling demos shared.  Attendance is a contract requirement for Tier 1 and 2 suppliers.

Governance artefacts are stored in SharePoint folder `Governance/Supply‑Chain/` and referenced in Document Control.


## 13.10  Integration with PAREK KPIs (≈ 120 words)

The following metrics flow into §15:

| KPI ID   | Metric                           | Target           | Data source        |
| -------- | -------------------------------- | ---------------- | ------------------ |
| **SC‑1** | % suppliers with valid CBOM      | ≥ 98 %           | CBOM intake logs   |
| **SC‑2** | Mean CBOM ingestion latency      | ≤ 2 h            | Pipeline dashboard |
| **SC‑3** | % Tier 1 PQC‑capable in test     | 100 % by 2027‑Q4 | Supplier roadmap   |
| **SC‑4** | Crypto incident SLA breach count | 0 per quarter    | GRC ticket system  |

These KPIs feed the executive dashboard and are reported to regulators under NIS‑2 critical‑infrastructure obligations.


## 13.11  Common pitfalls & mitigations (≈ 120 words)

1. **Volume overwhelm** – thousands of CBOM files per month; mitigate with batched digests and delta ingestion.
2. **Schema drift** – suppliers using outdated CycloneDX versions; mandate schema URI pinning and auto‑reject mismatches.
3. **Shadow suppliers** – fourth‑party components hidden inside Tier 2 deliverables; enforce SBOM‑CBOM linkage and random audits.
4. **Legal bottlenecks** – protracted clause negotiations; maintain pre‑approved PQC Annex template and fallback MSA language.
5. **False sense of security** – signed CBOM ≠ secure crypto; supplement with periodic binary scans and penetration tests.


## 13.12  Future outlook (≈ 90 words)

The EU Cyber Resilience Act may mandate **machine‑readable vulnerability reporting** and real‑time disclosure notices.  CycloneDX 2.0 will likely promote CBOM from *extension* to *first‑class object*, adding richer lifecycle metadata (retirement, key‑rotation schedules).  Suppliers should budget time to adopt the new schema by 2027.  Quantum‑safe HSM certifications (FIPS 203 level 3, CC EAL5+) are expected by 2026; contracts will update automatically when the organisation’s *Approved Crypto Module List* refreshes.


## 13.13  References

- CycloneDX (2025). *Cryptography Bill of Materials v1.6 Specification*.
- ENISA (2024). *Threat Landscape for Supply‑Chain Attacks*.
- Sigstore (2024). *Cosign 2.0 – Secure Artifact Signing*.
- European Union (2025). *Cyber Resilience Act (final text)*.
- TNO (2024). *Post‑Quantum Cryptography Handbook – Supplier Section*.


