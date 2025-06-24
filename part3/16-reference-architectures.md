# 16  Reference Architectures & Tooling

> **Purpose of this chapter** – provide opinionated, EU‑aligned reference architectures that engineering teams can adopt or adapt when implementing PAREK migrations.  Each pattern embraces open‑source baselines, indicates where commercial substitutes may slot in, and highlights regulatory hooks (NIS 2, DORA, CRA, eIDAS 2).


## 16.1  Reading guide (≈ 80 words)

Each subsection presents:

1. **Context** – why the pattern matters.
2. **Diagram** – ASCII or UML sketch.
3. **Component list** – open‑source baseline + commercial alternatives.
4. **EU compliance notes** – which articles/standards the pattern satisfies.
5. **Implementation tips** – common pitfalls, performance notes.

Full Terraform or Helm charts live in `assets/infra/`.


## 16.2  PQ‑ready PKI (*Pattern RA‑PKI‑EU*)

### 16.2.1  Context

Most TLS, code‑signing and device‑auth chains depend on a X.509 hierarchy.  Upgrading to hybrid or PQ‑only certificates without forklift replacements requires a crypto‑agile PKI.

### 16.2.2  Diagram

```
               EU Trust List (EUTL)
                      │
        ┌─────────────┴─────────────┐
        │        OFFLINE ROOT       │  (RSA‑4096 + Dilithium5)
        └──────┬──────────┬─────────┘
               │          │
        ┌──────┴───┐  ┌───┴────┐
        │  ISSUING │  │ ISSUING│   (ML‑DSA‑2, RSA‑4096)
        │   CA‑A   │  │  CA‑B  │
        └──┬───┬───┘  └───┬───┬─┘
           │   │         │   │
       ┌───┴─┐ └─┐   ┌───┴─┐ └─┐
       │ TLS │  IoT  │Code │  VPN  (leafs: hybrid certs)
```

### 16.2.3  Components

| Function | Open‑source             | Commercial                       |
| -------- | ----------------------- | -------------------------------- |
| CA core  | EJBCA CE                | Entrust PKIaaS EU                |
| HSM      | SoftHSM + PKCS#11       | Thales Luna HSM7 (EU datacentre) |
| ACME     | `certbot` (OQS‑patched) | Sectigo Certificate Manager      |

### 16.2.4  EU compliance

- **eIDAS 2** QES requirements → Offline root must be hosted in EU + QTSP audit.
- **NIS 2 Art. 21** technical controls → dual control on root key ceremonies.

### 16.2.5  Implementation tips

- Use **nested signatures**: RSA‑4096 outer, Dilithium5 inner to satisfy legacy clients.
- Test OCSP responders for 4 kB cert sizes.


## 16.3  Hybrid TLS termination (*RA‑TLS‑HYB*)

### Context

Web/API gateways must negotiate Kyber + X25519 KEM yet preserve performance.

### Diagram

```
Users ──► Cloudflare Zaraz (TLS 1.3) ─► Envoy Edge ─► Service Mesh ─► App Pods
            │ Kyber768+X25519           │ Kyber768+X25519     │ mTLS (OQS‑gRPC)
```

### Components

| Layer | OSS baseline               | Commercial EU‑hosted         |
| ----- | -------------------------- | ---------------------------- |
| CDN   | Cloudflare beta PQC edge   | Akamai Secure Edge PQC       |
| Proxy | Envoy 1.31 + OQS‑BoringSSL | NGINX Plus FIPS‑PQC module   |
| mTLS  | OQS‑gRPC                   | Istio with Thales DataShield |

### EU notes

- CRA requires “state‑of‑the‑art” crypto → hybrid by 2026 meets “state‑of‑the‑art” definition.
- GDPR Art. 32 encryption → document cipher suite in RoPA.

### Tips

- Enable **GREASE** support to avoid middlebox drops.
- Capture baseline latency; expect +2‑5 ms at 1 kB handshake growth.


## 16.4  Secure code‑signing pipeline (*RA‑CODE‑SIGN*)

### Diagram

```
Git Commit ─► CI Build ─► Cosign Sign (Dilithium2) ─► Rekor Transparency Log ─► Artifactory
```

### Components

| Step   | Tool (OSS)                            | Alt (Commercial)        |
| ------ | ------------------------------------- | ----------------------- |
| Sign   | `sigstore/cosign --key dilithium.key` | Venafi CodeSign Protect |
| Log    | `sigstore/rekor` EU cluster           | Ledger EU Notary        |
| Verify | `cosign verify --key dilithium.pub`   | Jenkins PQC plugin      |

### EU alignment

- CRA mandates SBOM/CVEs disclosure → attach CBOM + SBOM via Sigstore DSSE.
- DORA ICT ‑ data integrity → use Transparency Log proofs.


## 16.5  CBOM ingestion & graph (*RA‑CBOM‑EU*)

### Diagram

```
Supplier CBOM JSON ─► API Gateway (OAuth) ─► Kafka topic `cbom.raw`
        │                                   │
        └───────── error queue ─────────────┘
                   │
             ETL (Rust Lambda) ─► Neo4j GraphDB ─► Grafana Dash
```

### Components

| Function | OSS             | Commercial          |
| -------- | --------------- | ------------------- |
| Gateway  | Kong Gateway    | Azure APIM EU       |
| Queue    | Kafka           | AWS MSK (eu‑west‑1) |
| Graph    | Neo4j Community | Amazon Neptune      |

### EU notes

- Store all supplier data within EEA to satisfy GDPR Art. 44.


## 16.6  Crypto‑agile secret management (*RA‑SECRETS*)

### Diagram

```
Apps ► HashiCorp Vault (Transit Engine PQC plugin) ► HSM partition (ML‑KEM)
```

### Implementation tips

- Use **Key Versioning** to rotate to future algorithms (e.g., ML‑KEM‑1024).
- Enable **Key Type Tags** to block RSA key generation post‑2030.


## 16.7  Mapping architectures to PAREK stages

| Stage | Primary reference pattern    | Artefacts produced |
| ----- | ---------------------------- | ------------------ |
| **P** | RA‑CBOM‑EU                   | CBOM graph export  |
| **A** | (N/A) – consumes CBOM        | Risk registry      |
| **R** | Integration of RA‑PKI‑EU     | Roadmap epics      |
| **E** | RA‑TLS‑HYB, RA‑CODE‑SIGN     | Run‑books, metrics |
| **K** | RA‑SECRETS, monitoring stack | KPI dashboards     |


## 16.8  EU compliance cross‑reference (summary)

| Pattern      | NIS 2 | DORA | CRA | eIDAS 2 | GDPR |
| ------------ | ----- | ---- | --- | ------- | ---- |
| RA‑PKI‑EU    | ✔     | —    | —   | ✔       | —    |
| RA‑TLS‑HYB   | ✔     | ✔    | ✔   | —       | ✔    |
| RA‑CODE‑SIGN | ✔     | ✔    | ✔   | ✔       | —    |
| RA‑CBOM‑EU   | ✔     | ✔    | ✔   | —       | ✔    |
| RA‑SECRETS   | ✔     | ✔    | —   | —       | ✔    |

Full mapping sheet lives in `assets/compliance/patterns‑eu‑matrix.xlsx`.


## 16.9  Next steps

- Pilot **RA‑TLS‑HYB** on staging APIs (Q4 2025).
- Migrate code‑signing pipeline to Dilithium2 by Q1 2026.
- Integrate CBOM graph with risk dashboard (Stage K KPI P‑1) before next NIS 2 audit.


## 16.10  References

1. ETSI (2024). *TS 119 996 – Algorithm Agility Principles*.
2. Sigstore (2025). *PQC Roadmap*.
3. ENISA (2025). *Architecture Patterns for Post‑Quantum Migration*.
4. Cloudflare (2025). *Hybrid KEM Performance Whitepaper*.
5. CEN/CENELEC (2025). *Guideline on PQC‑Ready PKIs*.

