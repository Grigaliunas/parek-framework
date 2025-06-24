### 17  Glossary & Acronyms (CEN/CENELEC & ISO‑aligned)***


> **Purpose** – harmonise terminology across the handbook and supplier communications.  Definitions derive, where possible, from authoritative European standards: **CEN/CENELEC Guide 30:2015** (*European Standardisation – Vocabulary*), **EN ISO/IEC 2382** (*Information technology – Vocabulary*) and **ETSI TR 103 684** (*Algorithm Agility and Post‑Quantum Cryptography*).  Where no official wording exists, the editorial team supplies a consensual definition.

_Abbreviations are ordered alphabetically; initialisms are uppercase, terms are in Title Case._

| Term / Acronym | Definition (EU standard reference) |
| -------------- | ----------------------------------- |
| **AES** – Advanced Encryption Standard | Symmetric block cipher standardised in ISO/IEC 18033‑3. |
| **Algorithm Agility** | Ability of a system to support, select and switch between multiple cryptographic algorithms with minimal impact (ETSI TR 103 684). |
| **CBOM** – Cryptography Bill of Materials | Machine‑readable inventory of algorithms, keys, certificates and crypto modules contained in a product; extension to CycloneDX v1.6 (CEN/CENELEC draft prEN 17720). |
| **CEN** – Comité Européen de Normalisation | European Committee for Standardization responsible for non‑electrotechnical standards. |
| **CENELEC** – Comité Européen de Normalisation Électrotechnique | European Committee for Electrotechnical Standardization. |
| **CRQC** – Cryptographically Relevant Quantum Computer | Quantum computer capable of performing Shor‑style attacks on RSA/ECC keys of practical length (EN ISO/IEC 2382‑37 draft). |
| **CRA** – Cyber Resilience Act | EU regulation proposal on cyber‑secured products (COM/2022/454). |
| **CVSS** – Common Vulnerability Scoring System | Industry standard for rating IT vulnerabilities (ISO/IEC 30111). |
| **Dilithium** | Lattice‑based digital‑signature scheme selected by NIST for standardisation (FIPS 204). |
| **DORA** – Digital Operational Resilience Act | EU regulation 2022/2554 on ICT risk management for the financial sector. |
| **DSSE** – Delegated Supply‑chain Signing Envelope | JSON envelope format binding artefact digests and signature metadata (IETF draft). |
| **ENISA** – European Union Agency for Cybersecurity | EU agency providing guidance on cybersecurity and cryptography. |
| **eIDAS 2** | Regulation (EU) 2024/126 on digital identity and trust services. |
| **ETSI** – European Telecommunications Standards Institute | Standards body producing ICT technical specs (e.g., ETSI TS 119 996 on algorithm agility). |
| **FAL** – Forbidden Algorithm List | Organisational list banning weak or deprecated algorithms (internal policy; reference CRA Art 23). |
| **FIPS** – Federal Information Processing Standard | U.S. Government cryptography standards (e.g., FIPS 203 ML‑KEM). |
| **HNDL** – Harvest‑Now‑Decrypt‑Later | Attack model where adversary stores encrypted data today to decrypt after CRQC becomes available (CEN/CENELEC use case). |
| **HSM** – Hardware Security Module | Physical device safeguarding cryptographic keys and operations (ISO/IEC 19790). |
| **Hybrid Key Exchange** | Protocol combining classical and post‑quantum Key Encapsulation Mechanisms (KEMs) to derive a shared secret (IETF RFC 9399). |
| **ISO** – International Organization for Standardization | Global standardisation body collaborating with IEC on IT. |
| **Key Governance** | Processes and controls ensuring lifecycle management of cryptographic keys (EN ISO/IEC 27002:2022, 10.10). |
| **Kyber / ML‑KEM** | Module‑lattice KEM selected by NIST (FIPS 203). |
| **MTTR‑C** – Mean Time to Remediate Crypto | Average time to replace or fix weak cryptography after detection (DORA ICT RTS draft). |
| **NIS 2** | Directive (EU) 2022/2555 on measures for a high common level of cybersecurity across the Union. |
| **OCSP** – Online Certificate Status Protocol | Internet X.509 revocation protocol (IETF RFC 6960). |
| **PAREK** | Five‑stage EU PQC transition framework: **P**‑Inventory, **A**‑Risk Assessment, **R**‑Road‑mapping, **E**‑Execution, **K**‑Governance. |
| **PQC** – Post‑Quantum Cryptography | Cryptographic primitives believed secure against quantum adversaries (ISO/IEC 2382‑37 draft term). |
| **QACKER** – Quantum Hacker | Community-driven portal tracking quantum exploits and proof‑of‑concept attacks on classical cryptography (<https://www.qacker.com>). |
| **QARS** – Quantum‑Adjusted Risk Score | Composite metric weighting shelf‑life, migration effort and threat horizon. |
| **QTSP** – Qualified Trust Service Provider | Entity providing qualified trust services under eIDAS 2. |
| **RSA** | Public‑key cryptosystem based on integer factorisation (ISO/IEC 14888‑2). |
| **SBOM** – Software Bill of Materials | List of software components in a product (ISO/IEC 5962:2021 – SPDX). |
| **SCB** – Supplier Cryptography Board | Governance forum reviewing supplier PQC readiness (§13). |
| **Shor’s Algorithm** | Quantum algorithm for factoring and discrete logarithms (ISO/IEC 2382‑37 ref). |
| **SPHINCS+** | Stateless hash‑based signature scheme selected by NIST (FIPS 205). |
| **TLS 1.3** | Transport Layer Security protocol version 1.3 (IETF RFC 8446). |
| **X.509 Certificate** | Public‑key certificate standard (ITU‑T X.509; also ISO/IEC 9594‑8). |


## Notes on usage
- Where CEN/CENELEC or ISO vocabulary provides an exact wording, that phrasing is preferred verbatim.
- Internal policy acronyms (e.g., QARS, SCB) are capitalised to signal organisational scope.
- Terms introduced by NIST but not yet in ISO (e.g., ML‑KEM) keep NIST naming with cross‑reference to pending ISO work items.
