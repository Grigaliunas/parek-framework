# 8 P – Post‑Quantum Asset & Algorithm Inventory


> **Purpose** – provide a succinct overview of how to catalogue all cryptographic assets and algorithms so that subsequent risk scoring (Stage A) is based on complete, reliable data.  This short version is intended as a quick‑start guide; a full procedural manual will follow in v0.2.


## 8.1  What is a CBOM?
A **Cryptography Bill of Materials (CBOM)** is a machine‑readable inventory (CycloneDX JSON) listing every algorithm, key, certificate, protocol and crypto‑module used by a software, hardware or service component.  Think of it as an SBOM for cryptography.


## 8.2  Minimal discovery workflow
| Step | Action                         | Tool / Source           | Output |
| ---- | ------------------------------ | ----------------------- | ------ |
| 1    | Binary & source code scan      | `oqs‑scanner`, regex     | Algorithm list |
| 2    | Network traffic sampling       | Zeek, Wireshark         | Cipher‑suite map |
| 3    | Certificate inventory          | CT logs, PKI DB         | x509 dump |
| 4    | Supplier CBOM ingest           | API / S3 / email (§13)  | External JSON |
| 5    | Manual survey for edge assets  | Google Forms            | Gap register |

Run steps 1–4 in parallel; perform step 5 only if coverage < 95 %.


## 8.3  Essential data fields
1. `algorithm` – e.g., `rsa2048`, `ml‑kem‑768`  
2. `context` – `tls1.3`, `ssh2`, `jwt`  
3. `keySize` / `parameterSet`  
4. `usage` – signing, encryption, key agreement  
5. `expires` – ISO date for certificates/keys  
6. `hardwareAnchor` – HSM/TPM model + firmware  

Include a `scanTimestamp` and digital signature (`*.cbom.sig`).


## 8.4  Quality gate G1 (inventory lock)
- **Metric** – % assets with valid CBOM ≥ 95 %.
- **Owner** – Asset‑Inventory Lead.
- **Tool** – Grafana dashboard `CBOM‑coverage`.

If coverage < 95 %, raise Corrective Action Plan and block Stage A.


## 8.5  Outputs
- **CBOM repository** – `git@repo:cbom/` with one JSON per system.
- **Gap register** – CSV of unscanned or unknown assets.
- **Coverage dashboard** – auto‑refreshed via Prometheus.


## 8.6  Common pitfalls
1. **Duplicate asset IDs** – enforce UUID naming.
2. **Missing hardware mapping** – integrate CMDB export.
3. **Supplier lag** – tie CBOM submission to invoice milestone.


## 8.7  Next steps
Once G1 is passed, hand off the consolidated CBOM set to Stage A for QARS calculation.  Retain automated nightly scans to catch drift.
