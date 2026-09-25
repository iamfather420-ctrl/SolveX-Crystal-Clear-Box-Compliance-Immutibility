# Solvex / Daisy / Compliance Unification Manifest

Status: INTEGRATION BRANCH INITIALIZED — SOURCE-PRESERVING

This branch is the integration staging point for the three source systems requested for consolidation. Source repositories are not modified by this operation.

## Source A — Compliance & Immutibility

Repository: `iamfather420-ctrl/SolveX-Crystal-Clear-Box-Compliance-Immutibility`
Branch: `main`
Observed source commit: `da4d8c188f06f055c263a40c8d57127e30adb8cf`
Role: Compliance / immutability product core and existing compliance dashboard lineage.

## Source B — Solvex Crystal Clear Black Box

Repository: `Solvex-Paradox-Box/Solvex-Crystal-Clear-Black-Box`
Branch: `main`
Observed source commit: `7be16c1db8d25b2d71d6c0f95f8f07aa30997cff`
Role: Solvex Crystal Clear / Android application source currently exposed under the Solvex-Paradox-Box organization. Its README identifies it as an Android Studio project with Gemini API configuration.

## Source C — Daisy Himinja AI UI OS

Repository: `Solvex-Paradox-Box/Daisy-Himinja-AI-UI-OS`
Branch: `main`
Observed source commit: `208674f7d4f1b4d1452955099e6eff6ef894ed4f`
Role: Daisy UI/OS, brain, audit, authentication, database, marketplace, MMTAI and related application layers.

## Integration rules

1. Preserve source provenance and commit references.
2. Do not treat UI labels, audit JSON, README claims, or catalog entries as proof of execution.
3. Preserve existing verification states such as VERIFIED, PARTIAL, CLAIM_ONLY, EXTERNAL_PROVIDER_REQUIRED, UNIMPLEMENTED and UNKNOWN.
4. Do not copy secrets, `.env` credentials, private keys, or provider credentials into the unified tree.
5. Compliance/immutability remains a first-class subsystem rather than being replaced by Daisy UI code.
6. Daisy becomes the application/control surface; Solvex reasoning/proof capabilities remain separated behind explicit interfaces.
7. External providers remain fail-closed until independently executed and evidenced.
8. The next integration phase must compare dependency manifests, duplicate modules, API contracts, evidence/proof paths, build systems and test suites before destructive merges.

## Planned target layout

```text
unified-solvex-daisy/
  compliance/
  solvex/
  daisy/
  contracts/
  evidence/
  verification/
  adapters/
  docs/
```

This manifest intentionally does not claim that the three repositories have already been byte-for-byte merged. It records the exact source anchors for the controlled integration pass.
