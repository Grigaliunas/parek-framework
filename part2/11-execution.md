### E – Execution & Migration***

> **Purpose of this chapter** – provide a practical playbook for migrating systems from quantum‑vulnerable cryptography to post‑quantum or hybrid primitives while maintaining service continuity, performance, and compliance.  It covers deployment models, testing strategies, rollback procedures and quality gates.


## 11.1  Guiding principles (≈ 120 words)
1. **Hybrid first** – pair PQC primitives with existing RSA/ECDHE until ecosystem maturity allows full cut‑over.
2. **Incremental roll‑out** – deploy to a small blast radius, monitor, then expand.
3. **Telemetry‑driven** – measure handshake success, latency, error rates in real time.
4. **Reversible** – every deployment must include an automated rollback path.
5. **Compliance aligned** – FIPS‑approved parameter sets, algorithm policy enforced via crypto providers.


## 11.2  Migration patterns (≈ 250 words)
| Pattern ID | Use case              | Description                                                | Pros               | Cons                    |
| ---------- | --------------------- | ---------------------------------------------------------- | ------------------ | ----------------------- |
| **M‑H‑TLS** | Web/API TLS traffic   | TLS 1.3 hybrid KEM: X25519 + ML‑KEM‑768 (RFC 9399)         | Minimal latency; browsers in test builds | Larger ClientHello (~3 kB) |
| **M‑H‑SSH** | Admin shell access    | OpenSSH 9.4c with ECDH‑SHA2 + Kyber768 + dilithium keys    | Easy CI integration | Requires updated clients |
| **M‑PKI‑Nested** | Code signing         | RSA‑2048 + Dilithium cert chain (nested signatures)        | Backwards compatible | 2× cert size            |
| **M‑Hash‑FW** | IoT firmware updates | SPHINCS+ (128s) detached signature; verify in bootloader   | Stateless, audit‑friendly | 1 MB signature size     |
| **M‑Sym‑Wrap** | Large data archives   | AES‑256‑GCM data, key wrapped with Kyber1024 then stored   | Separates data-at-rest from PQC cadence | Key management overhead |


## 11.3  Deployment workflow (≈ 200 words)
1. **Readiness checkpoint** – ensure Stage R work‑package passes go/no‑go gate.
2. **Pre‑prod lab** – replicate production traffic with synthetic load; collect baseline metrics.
3. **Canary release** – enable PQC for 1 % of traffic or a single AZ/node.
4. **Observation window** – monitor KPIs (handshake success ≥ 99.9 %, latency ≤ +5 ms).
5. **Gradual ramp‑up** – double traffic every 24 h if KPIs green.
6. **Full rollout** – 100 % production traffic.
7. **Post‑deployment audit** – verify cert chains, scan for deprecated algorithms.

Automated scripts (`scripts/deploy/hybrid_tls.sh`) orchestrate feature flags via Envoy or nginx annotations.


## 11.4  Testing strategy (≈ 180 words)
| Test type           | Tool / framework           | Success criterion                                    |
| ------------------- | -------------------------- | ---------------------------------------------------- |
| Unit tests          | Google Test / Catch2       | PQC library returns expected ciphertext length       |
| Integration tests   | Docker Compose stack       | Service handshake completes in < 100 ms             |
| Fuzz testing        | libFuzzer + AFL++          | No crashes after 24 h fuzzing                        |
| Interop tests       | OQS‑OpenSSL ↔ OQS‑nginx    | 100 % pass across selected cipher suites            |
| Performance bench   | wrk2, k6, vegeta           | Throughput impact ≤ 5 % of baseline                 |
| Chaos drills        | Pumba / TC‑netem           | Rollback trigger within 30 s of error spike         |

Continuous Integration pipelines in GitLab run these stages; results export to SonarQube and Grafana.


## 11.5  Rollback & contingency (≈ 120 words)
Every deployment artefact includes:
- **Feature flag** to disable PQC handshake at runtime.
- **Blue/green** or **canary** deployment environment.
- **Backup certificates/keys** staged and tested.
- **Automated playbook** `scripts/rollback/hybrid_tls_revert.sh`.

Triggers:
- Error rate > 0.5 % sustained for 5 min.
- Latency increase > 50 ms for 5 min.
- Security incident flagged by SOC.


## 11.6  Telemetry & metrics (≈ 150 words)
| Metric ID | Description                          | Target | Collector  |
| --------- | ------------------------------------ | ------ | ---------- |
| **E‑1**   | PQC handshake success rate           | ≥ 99.9 % | Envoy stats |
| **E‑2**   | Median handshake latency (ms)        | ≤ +5 ms | Prometheus  |
| **E‑3**   | Error 5xx ratio during rollout       | ≤ 0.1 % | Loki logs   |
| **E‑4**   | Deprecated cipher usage (per hour)   | 0       | Zeek        |

Dashboards live at `Grafana › PAREK › Execution`.


## 11.7  Quality gate G3 – Production readiness (≈ 80 words)
CISO (security), CIO (availability) and CFO (budget) sign off when:
1. All tests pass, KPIs within thresholds.
2. Backout plan validated in staging.
3. Supplier HSM firmware certs present.
4. Compliance evidence (FIPS cert numbers) attached to release ticket.


## 11.8  Documentation deliverables (≈ 100 words)
- **Migration run‑book** – step‑by‑step with screenshots/log snippets.
- **Risk acceptance record** – signed PDF by risk owner.
- **Change record** – ITIL ticket with links to pipeline run IDs.
- **Post‑implementation review** – lessons learned, metric screenshots.

Stored in `Confluence › PQC › Execution` with version tags matching Git tags.


## 11.9  Common pitfalls & mitigations (≈ 120 words)
1. **TLS library mismatch** – pin exact OQS‑OpenSSL version; run interop tests.
2. **Certificate‑size blow‑up** – enable TLS 1.3 compression extensions or nested certs.
3. **Log parser breakage** – update regex patterns to parse new cipher suite names.
4. **HSM queue overflow** – capacity test firmware before prod.
5. **Shadow RSA glue code** – static‑link scanners in CI.


## 11.10  Future roadmap (≈ 90 words)
- **Full PQ‑only mode** once browser vendors ship Kyber in stable channels (target 2029).
- **Algorithm agility APIs** (e.g., libpqcrypto v2) to hot‑swap parameter sets.
- **Quantum‑safe VPN and email encryption pilots** (Stage E‑2026‑Q4).


## 11.11  References
1. IETF (2023). *RFC 9399 – Hybrid Key Exchange in TLS 1.3*.
2. Open Quantum Safe (2024). *OQS‑OpenSSL 4.1*.
3. NIST (2024). *FIPS 203 / 204 / 205*.
4. ENISA (2025). *Post‑Quantum Migration Patterns*.



