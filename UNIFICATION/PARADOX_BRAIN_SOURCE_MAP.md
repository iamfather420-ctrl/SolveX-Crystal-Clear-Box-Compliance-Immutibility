# Paradox → Proof → Daisy Brain Source Map

Audit anchor: `iamfather420-ctrl/SOLVEX-PARADOX-BOX@660b11ade67b4358a162de756a4f0f76ec675050`

## 1. Canonical paradox knowledge

Authoritative executable registry:
`src/paradoxes/ParadoxRegistry.ts`

Observed:
- 32 canonical bootstrap records: DH-P-001 through DH-P-032.
- Registry taxonomy contains VERIFIED, FAMILY_VARIANT, CLAIM_ONLY and PARTIAL states.
- Registry labels are metadata, not proof by themselves.

Current registry status counts:
- VERIFIED: 20
- FAMILY_VARIANT: 5
- CLAIM_ONLY: 4
- PARTIAL: 3

## 2. Formal proof layer

DFRL:
`src/proofs/DFRL.ts`

Formal engine:
`src/proofs/Z3FormalProofEngine.ts`

Termination engine:
`src/proofs/NOPOTProof.ts`

Proof bundle:
`src/proofs/ProofBundle.ts`

Proof engine:
`src/proofs/ProofEngine.ts`

Daisy brain:
`src/brain/DaisyBrain.ts`
`src/brain/AgentBrainState.ts`

### Current DFRL contracts

Eight canonical contracts are registered:

| Contract | Paradox |
|---|---|
| spc_russell_01 | px_002 |
| spc_barber_02 | px_003 |
| spc_liar_03 | px_004 |
| spc_curry_04 | px_005 |
| spc_inductive_05 | px_006 |
| spc_zeno_06 | px_001 |
| spc_byzantine_07 | px_007 |
| spc_pigeonhole_08 | px_008 |

These are the currently wired formal-resolution routes. They are not evidence that all 32 paradoxes have been formally proved.

## 3. Brain wiring completed

Branch:
`iamfather420-ctrl/SOLVEX-PARADOX-BOX@integration/daisy-paradox-brain`

Implemented:
- `ProofEngine.verifyCanonicalParadox(paradoxId)`
- accepts either canonical internal ID or DH-P code
- resolves the canonical registry entry
- locates a matching DFRL contract
- executes the DFRL contract
- accepts only PROVEN_UNSAT or TERMINATION_BOUNDED as verified
- returns REJECTED_UNKNOWN for an uncontracted paradox
- never promotes a registry label into proof status

Integration test added:
`src/tests/paradoxBrainIntegration.ts`

The test requires:
- exactly 32 canonical bootstrap paradox records
- at least 8 DFRL contracts
- every DFRL contract must successfully route through ProofEngine
- an uncontracted paradox must remain fail-closed

## 4. Evidence boundary

The following are evidence artifacts or claims and must remain distinguished from executable proof:
- README files
- audit reports
- JSON status reports
- cryptographic hashes without replay/checker evidence
- UI status labels
- registry verification labels

The executable trust path is:

`ParadoxRegistry → ProofEngine → DFRLEngine → Z3/NOPOT → DFRLResult → audit chain`

## 5. Remaining brain construction

The remaining 24 registry entries need proof-obligation generation and domain-specific verification routes. They must not be bulk-labeled VERIFIED.

For each remaining paradox, Daisy should create:
1. canonical identity
2. mechanism statement
3. proposed resolution
4. formalization target
5. executable checker route
6. expected result
7. observed result
8. independent oracle
9. deterministic replay
10. reproducible artifact
11. failure/unknown classification when any requirement is missing

This is the path from a paradox catalogue to an evidence-backed reasoning brain.

## 6. Historical-count rule

Old 88/105/etc. counts are not current proof ceilings. The current executable registry observed here is 32 bootstrap records. Future expansion must be additive and provenance-preserving.
