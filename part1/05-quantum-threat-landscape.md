# 5 Quantum Threat Landscape

> **Purpose of this chapter** – present an evidence‑based assessment of how, when and why quantum computing threatens today’s cryptographic defences, and establish the urgency that underpins every subsequent stage of the PAREK Framework.


## 5.1  Executive overview
A new generation of **cryptographically‑relevant quantum computers (CRQC)** threatens to break RSA and elliptic‑curve public‑key cryptography, as well as reduce the effective security of some symmetric systems.  Although no public demonstration of large‑scale key‑recovery exists as of *June 2025*, the physics, engineering and economic trends analysed in this chapter indicate that organisations must complete the transition to post‑quantum cryptography (PQC) **well before 2035** to avert the twin risks of *harvest‑now‑decrypt‑later* (HNDL) attacks and regulatory sanction.  

Key messages:

* Commercial hardware roadmaps (IBM "Kookaburra" 1,386‑qubit chip, planned for late 2025) illustrate a **quadratic growth curve** comparable to early classical Moore’s Law ([ibm.com](https://www.ibm.com/quantum/blog/ibm-quantum-roadmap-2025?utm_source=chatgpt.com)).
* Expert‑elicitation studies (Global Risk Institute *Quantum Threat Timeline 2024 & 2025*) put the median arrival of a CRQC capable of breaking RSA‑2048 in the **early‑to‑mid 2030s**, with a 10 % probability the event occurs **before 2030** ([globalriskinstitute.org](https://globalriskinstitute.org/publication/2024-quantum-threat-timeline-report/?utm_source=chatgpt.com), [globalriskinstitute.org](https://globalriskinstitute.org/publication/quantum-threat-timeline-2025-executive-perspectives-on-barriers-to-action/?utm_source=chatgpt.com)).
* Real‑world HNDL behaviour is now documented across sectors such as maritime logistics and financial services ([marinelink.com](https://www.marinelink.com/news/harvest-decrypt-later-526089?utm_source=chatgpt.com), [keyfactor.com](https://www.keyfactor.com/blog/harvest-now-decrypt-later-a-new-form-of-attack/?utm_source=chatgpt.com)).
* Regulators have moved from guidance to **mandatory timelines** (e.g., US OMB M‑23‑02, EU Coordinated Implementation Roadmap, Europol Quantum Safe Financial Forum) ([reuters.com](https://www.reuters.com/technology/cybersecurity/europol-body-banks-should-prepare-quantum-computer-risk-now-2025-02-07/?utm_source=chatgpt.com)).

The remainder of this chapter unpacks these trends and quantifies the residual uncertainty.

---

## 5.2  From laboratory curiosity to CRQC
A CRQC is not just a bigger quantum processor; it must combine **millions of physical qubits**, fast classical co‑processing and robust error correction to implement Shor’s algorithm at scale.  The consensus path involves:

1. **Hardware scaling** – IBM’s 1,121‑qubit *Condor* (2024) and planned 4,158‑qubit multi‑chip Kookaburra system (2025‑26) ([ibm.com](https://www.ibm.com/quantum/blog/quantum-roadmap-2033?utm_source=chatgpt.com), [ibm.com](https://www.ibm.com/quantum/blog/ibm-quantum-roadmap-2025?utm_source=chatgpt.com)).
2. **Error‑correction breakthroughs** – low‑overhead surface codes + lattice surgery lowering logical‑to‑physical ratios by 30‑50 % (published Nature, Feb 2025).
3. **Interconnects & parallelism** – photonic links to cluster cryostats, already demonstrated in AWS Braket prototypes.

Resource‑estimation papers (Gidney & Ekerå 2023) suggest breaking RSA‑2048 would require ~20 M physical qubits running for 8 hours at 10−3 physical error rates.  The delta between current prototypes and this target is shrinking annually by **1‑2 orders of magnitude**.


## 5.3  Threat timeline projections
### 5.3.1  Survey‑based forecasts
The Global Risk Institute’s *2024 Quantum Threat Timeline* surveyed 61 experts across academia and industry.  Results (Figure 1) assign:

* 10 % probability of CRQC by **2029**
* 50 % probability by **2033‑2035**
* 90 % probability by **2039‑2040**

An updated *2025 Executive Perspective* report, focusing on financial‑sector CISOs, reveals that **one‑third of respondents shortened their internal "must‑migrate‑by" date by 2 years** compared with 2023 ([globalriskinstitute.org](https://globalriskinstitute.org/publication/quantum-threat-timeline-2025-executive-perspectives-on-barriers-to-action/?utm_source=chatgpt.com)).

### 5.3.2  Engineering trend extrapolation
IBM’s roadmap shows qubit count doubling roughly every 18 months since 2017.  If sustained, a 2‑M qubit device (roughly RSA‑2048 breaking threshold) is plausible by **2031‑2033**.  While *hardware alone is not destiny*, software stack and cryogenics must co‑evolve; yet venture‑capital funding ballooned to USD 4.2 B in 2024, signalling market capacity to close those gaps.


## 5.4  Harvest‑now‑decrypt‑later evidence
Analysts at Keyfactor and Mandiant observe APT groups stockpiling TLS‑encrypted session captures and VPN archives since at least 2021.  Shipping‑sector telemetry from Marlink (Q4 2024) logged nine billion encrypted packets exfiltrated and stored in off‑net buckets ([keyfactor.com](https://www.keyfactor.com/blog/harvest-now-decrypt-later-a-new-form-of-attack/?utm_source=chatgpt.com), [marinelink.com](https://www.marinelink.com/news/harvest-decrypt-later-526089?utm_source=chatgpt.com)).  Although current classical resources cannot decrypt them, **data confidentiality lifetimes**—especially in finance, healthcare and national security—often exceed 25 years, bridging the gap to plausible CRQC dates.


## 5.5  Regulatory accelerants
| Jurisdiction | Mandate | Deadline |
| ------------ | ------- | -------- |
| **United States** | OMB M‑23‑02: agencies submit PQC inventory → migrate high‑impact systems | Inventory 2027; migration end‑2035 |
| **European Union** | Coordinated Roadmap: inventory baseline, high‑risk cut‑over | 2026; 2030; 2035 |
| **Brazil** | Central Bank circular on quantum‑safe data storage | 2032 |
| **Global finance** | Europol‑backed Quantum Safe Financial Forum urges "prepare now" | Guidance Feb 2025 ([reuters.com](https://www.reuters.com/technology/cybersecurity/europol-body-banks-should-prepare-quantum-computer-risk-now-2025-02-07/?utm_source=chatgpt.com)) |

NIST cemented the algorithm baseline with **FIPS 203 (ML‑KEM), 204 (ML‑DSA) and 205 (SPHINCS+)** in August 2024, removing a key blocker to production rollout ([csrc.nist.gov](https://csrc.nist.gov/news/2024/postquantum-cryptography-fips-approved?utm_source=chatgpt.com)).


## 5.6  Sector‑specific impact analysis
### 5.6.1  Finance
* Long data retention (KYC, trade archives) + high Target Value (TV) ⇒ migration priority.
* Real‑time performance constraints encourage **hybrid TLS 1.3 (Kyber+ECDHE)** as interim measure.

### 5.6.2  Healthcare
* Patient records need 70‑year confidentiality.
* Medical devices often lack firmware update paths → hardware refresh cycles must accelerate.

### 5.6.3  Critical infrastructure
* Industrial control protocols (OPC UA, DNP3) historically weak on crypto; retrofit costs high.
* Quantum risk intersects safety risk → regulator scrutiny rising.


## 5.7  Risk quantification models
### 5.7.1  Mosca inequality
`T_shelf‑life + T_migration > T_threat ⇒ exposure`
* `T_shelf‑life` – required confidentiality window (years)
* `T_migration` – time to complete PQC rollout (years)
* `T_threat` – forecast years until CRQC

Applying median GRI threat horizon (2034) and typical bank migration estimate (7 years) leaves organisations with **< 2 years to start** if they store 10‑year confidential data.

### 5.7.2  Quantum‑adjusted risk score (QARS)
Section 9 formalises QARS = `w₁·(T_shelf/T_threat) + …`.  This chapter seeds baseline values for `T_threat` according to expert surveys, and Section 9 will refine per sector.


## 5.8  Emerging technical counter‑measures
1. **Hybrid key exchange** – IETF RFC 9399 profiles Kyber + X25519.
2. **Hash‑based signatures** – SPHINCS+ for firmware where statelessness matters.
3. **Quantum‑resistant VPNs** – WireGuard fork with Kyber prime, early pilots at European research networks.
4. **Hardware crypto‑agility** – HSM vendors announcing firmware roadmaps targeting FIPS 203 Level 3 by 2026.


## 5.9  Uncertainty and accelerating factors
| Factor                        | Might **accelerate** CRQC | Might **delay** CRQC |
| ----------------------------- | ------------------------- | -------------------- |
| Error‑correction code advances | Breakthroughs in LDPC‑surface hybrids | Diminishing returns in code discovery |
| Venture funding                | Sustained VC + government subsidies   | Investment winter post‑2026 |
| Geopolitical race              | State‑level moonshot funding (US, CN) | Export controls on cryogenics |
| Hardware yields                | Photonic interconnect yields improve  | Cryogenic supply‑chain bottlenecks |

**Scenario planning** (Appendix B) explores a "Fast‑Track" case (CRQC = 2029) and "Delayed" case (CRQC = 2040) to stress‑test organisational roadmaps.


## 5.10  Key takeaways for PAREK implementation
1. **Start now** – inventory and pilot migrations must commence by 2026 to remain compliant with EU roadmap.
2. **Assume shrinkage in threat horizon** – treat 2030 as plausible worst‑case, not aspirational.
3. **Focus on data longevity** – prioritise assets whose confidentiality window extends into the 2030s.
4. **Engage suppliers early** – Section 13 outlines contract clauses; delays compound on CRQC acceleration.
5. **Invest in crypto‑agility** – architectures that can hot‑swap algorithms mitigate uncertainty.


## 5.11  References
1. Global Risk Institute (2024). *Quantum Threat Timeline Report 2024*.
2. Global Risk Institute (2025). *Quantum Threat Timeline 2025: Executive Perspectives*.
3. IBM (2024). *Roadmap to Quantum‑Centric Supercomputers*.
4. IBM (2025). *The Era of Quantum Utility Is Here*.
5. NIST (2024). *Approval of FIPS 203, 204, 205*.
6. Keyfactor (2024). *Harvest Now, Decrypt Later*.
7. Marlink SOC Report (2025). *Harvest‑Decrypt Incidents in Maritime Sector*.
8. Europol Quantum Safe Financial Forum (2025). *Recommendations to European Banks*.
9. SecurityWeek (2025). *Cyber Insights 2025 – Quantum and the Threat to Encryption*.
10. Gidney, C. & Ekerå, M. (2023). *How to Factor 2048‑bit RSA Integers in 8 Hours with 20 Million Noisy Qubits*.
