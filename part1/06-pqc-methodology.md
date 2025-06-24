## PQC Methodology**

### 6.1  Purpose and position of this chapter

This methodology bridges the “**why**” articulated in the quantum-threat literature with the practical “**how**” codified in the PAREK framework. It supplies a repeatable lifecycle—*discover → assess → plan → execute → improve*—that any EU organisation can embed in its security management system and map onto the milestones of the Coordinated Implementation Roadmap (first-steps 2026, high-risk cut-over 2030, medium-risk completion 2035) .

### 6.2  Scientific foundation

**Quantum risk geometry.** Shor’s and Grover’s algorithms prove that once a *cryptographically-relevant quantum computer* (CRQC) exists, RSA/ECC and many symmetric-key constructions lose their assumed security margins. The most widely used quantitative model is the *Mosca Inequality*:

> **T­­shelf-life + T­­migration > T­­threat ⇒ your data will be exposed.**

The shelf-life of the data, the organisation’s migration time, and the expert-assessed CRQC timeline must be evaluated together; breaches can begin long before a CRQC is built through *Harvest-Now-Decrypt-Later* (HNDL) attacks .

**Expert forecasts.** The 2024 Global Risk Institute survey of 32 quantum-hardware experts gives a median estimate of 11–15 years for a CRQC able to break RSA-2048, but with a heavy tail of earlier arrivals . Gidney & Ekerå’s resource estimate (20 million noisy qubits, 8 hours) and subsequent error-correction progress validate that such a machine is an engineering—rather than scientific—challenge . Because these forecasts shift annually, the methodology demands continuous refresh of *T­­threat*.

**Standards landscape.** In August 2024 NIST issued the first three Federal Information Processing Standards: FIPS 203 (ML-KEM / Kyber), FIPS 204 (ML-DSA / Dilithium) and FIPS 205 (SPHINCS+) . Forthcoming FIPS 206 (BIKE) and ISO/ETSI profiles will refine parameter sets, but the decision rule is already clear: design choices should default to these lattice- or hash-based schemes unless an explicit profile (IoT, constrained, statutory) dictates otherwise.

### 6.3  Design principles

1. **Crypto-agility first.** Because algorithm lifetimes are uncertain, architectures must allow hot-swapping of primitives without forklift upgrades .
2. **Inventory before surgery.** Every migration failure studied by TNO traced back to an incomplete asset list; hence inventory is a non-negotiable gate .
3. **Hybrid ≥ single-stack.** Where performance permits, run lattice-based KEMs or signatures *alongside* existing ECC/RSA until the latter can be fully retired. ETSI/IETF interop plug-tests show this halves rollback risk .
4. **Evidence over assertion.** Each stage outputs machine-readable artefacts—CBOMs, risk scores, migration run-books—that auditors and regulators can parse automatically.

### 6.4  Lifecycle phases

#### 6.4.1  Phase 0 – Programme mobilisation

Although not counted among the five PAREK stages, a short mobilisation sprint (4–6 weeks) is advisable to assign roles, secure budget and ratify the scope statements defined in §3.


#### 6.4.2  Phase 1 – Cryptographic discovery & inventory (“P” in PAREK)

**Objective.** Build a *single source of truth* describing every algorithm, key, certificate, protocol, hardware module and crypto-library instance.

**Process.**

* Crawl binaries and source trees with pattern-matching and dynamic-analysis tools.
* Enrich findings with network captures and certificate-transparency logs.
* Normalise results into a **Cryptography Bill of Materials (CBOM)**—an extension of CycloneDX 1.6—which supports >20 asset types (algorithm, protocol, key, seed, nonce, etc.) .
* Link CBOMs back to software SBOMs via *bom-link* URNs so each application instance can be traced to its crypto footprint .

**Output artefacts.**

* CBOM JSON (one per application or shared library)
* Discovery tooling report with false-positive triage
* Gap register listing unscanned networks or black-box third-party services


#### 6.4.3  Phase 2 – Quantum risk assessment (“A”)

**Objective.** Quantify urgency and migration difficulty, then classify systems into EU “high / medium / low” buckets.

**Scoring model.** Extend Mosca’s inequality into a composite *Quantum-Adjusted Risk Score (QARS)*:

```
QARS = w1·(T_shelf-life / T_threat) + w2·(Migration_Cost / CapEx_Budget)
      + w3·(Data_Sensitivity) + w4·(Exposure_Surface)
```

where weights *w1–w4* are calibrated by sector regulators. TNO’s handbook suggests default weightings of 0.35 / 0.25 / 0.25 / 0.15 after pilot workshops .

**Scientific reference.** Mosca & Mulholland’s original risk methodology underpins the formula and justifies linear aggregation of shelf-life and migration vectors .

**Output artefacts.**

* Per-system risk dossier (QARS, assumptions, reviewer sign-off)
* Heat-map dashboard for C-suite and board reporting


#### 6.4.4  Phase 3 – Road-mapping & readiness planning (“R”)

**Objective.** Translate scores into dated, budgeted work-packages aligned with EU milestones.

**Steps.**

1. **Prioritise** systems with QARS ≥ 0.65 for immediate pilot migrations.
2. **Allocate buffer time** for external dependencies (e.g., hardware security modules awaiting FIPS 203 validation).
3. **Sequence pilots** to maximise knowledge reuse—start with a low-volume API gateway, then propagate the playbook to high-volume payment stacks.
4. **Integrate supplier clauses** requiring CBOM delivery and PQC-ready firmware by 2028 for high-risk contracts .

**Output artefacts.**

* Gantt chart or kanban milestones
* Budget breakdown: licences, hardware refresh, training, contingency
* Contract addenda language for suppliers


#### 6.4.5  Phase 4 – Execution & migration (“E”)

**Objective.** Replace—or wrap in hybrid mode—all quantum-vulnerable primitives, while preserving service levels.

**Preferred migration patterns (scientific rationale in brackets):**

* **Kyber-in-TLS 1.3 hybrid KEM:** Adds <2 kB to handshake; end-to-end field results show negligible latency increase at sub-10 ms RTT .
* **Dilithium signatures for code signing:** Larger certificates (\~14 kB) but verified 100× faster than SPHINCS+, making it fit for CI/CD pipelines.
* **SPHINCS+ for long-life artefacts (firmware, legal archives):** Stateless hash-based design offers security with minimal cryptanalysis uncertainty.
* **Double-wrap archives:** Encrypt once with AES-256-GCM, then wrap the symmetric key via Kyber or BIKE to separate confidentiality from PQC adoption pace.

**Change-control safeguards.** Each rollout includes a cryptographic *canary test*, real-time telemetry on handshake success rates, and a rollback plan tied to traffic shadowing.

**Output artefacts.**

* Migration run-books and playbooks per platform
* Performance-impact report versus baseline
* Certificate revocation & renewal schedule


#### 6.4.6  Phase 5 – Key-governance & continuous improvement (“K”)

**Objective.** Ensure that once migrated, systems stay quantum-resilient—even as algorithms evolve or new vulnerabilities surface.

**Controls.**

* **Continuous CBOM scanning:** Weekly delta scans detect drift; policy engines flag any newly imported RSA/ECC library versions .
* **Policy attestation via CycloneDX Attestations:** Suppliers attach machine-readable claims linking binaries to NIST/FIPS conformity, automating compliance checks .
* **Crypto-agility playbooks:** Design patterns (algorithm-independent keystores, versioned protocol negotiation, feature flags) enable hot re-parametrisation—a requirement emphasised by NCSC-NL and echoed in TNO Step 4.4 .
* **Metric suite:** Mean Time To Remediate Weak Crypto (MTTR-C), % assets with valid CBOM, % PQC certificates in production. These feed into ENISA reporting and, under NIS-2, into supervisory audits.


### 6.5  Embedding the methodology in EU governance

Member States’ NIS Cooperation Group work-stream recommends each national roadmap publish quarterly status against the core measures above and contribute pilot results to the EU testing infrastructure . By harmonising metrics and artefacts (CBOM JSON, QARS spreadsheets, FIPS certificate IDs), the methodology enables cross-border comparability and pooled threat-intelligence.


### 6.6  Limitations and future research

While lattice-based KEMs currently lead standardisation, code-based (Classic McEliece) and isogeny-based (SIKE-like) schemes deserve niche consideration; the methodology therefore reserves an *Experimental Track* for low-volume prototypes. The scientific community is still refining fault-tolerance thresholds—e.g., the debate around “dynamic-logical qubits” may shift T­­threat earlier or later. Organisations must budget for annual model recalibration as these estimates mature.


### 6.7  Conclusion

This PQC Methodology equips EU organisations with a science-grounded, regulator-aligned and audit-ready pathway from cryptographic discovery to long-term quantum resilience. By anchoring every decision in measurable artefacts—CBOMs, risk scores, migration run-books—and iterating through the PAREK lifecycle, enterprises can defend today’s and tomorrow’s data against the quantum horizon.
