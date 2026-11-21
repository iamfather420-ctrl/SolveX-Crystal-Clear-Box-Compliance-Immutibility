#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
export HOME="$TMP/home"
mkdir -p "$HOME/.agate_node/vault" "$TMP/fakebin"
export PATH="$TMP/fakebin:$PATH"
cat > "$TMP/fakebin/curl" <<'CURL'
#!/usr/bin/env bash
echo "000"
exit 7
CURL
chmod +x "$TMP/fakebin/curl"

if bash "$ROOT/vault/generate_report.sh" > "$TMP/missing.txt"; then
  echo "Expected missing-log report to return nonzero" >&2
  exit 1
fi
grep -q 'Audit data status: UNAVAILABLE' "$TMP/missing.txt"
grep -q 'Security verification: NOT VERIFIED' "$TMP/missing.txt"

LOG="$HOME/.agate_node/vault/consensus_memory.json"
printf '%s\n' \
  '{"id":1,"status":"SUCCESS","event":"HTTP 200"}' \
  '{"id":2,"status":"UNAVAILABLE","event":"Connection observation unavailable"}' \
  '{"id":3,"status":"HTTP_RESPONSE","event":"Non-200 HTTP response"}' > "$LOG"

bash "$ROOT/vault/generate_live_audit.sh" > "$TMP/live.txt"
grep -q 'TOTAL OBSERVATIONS: 3' "$TMP/live.txt"
grep -q 'NO RESPONSE OBSERVED' "$TMP/live.txt"
grep -q 'SECURITY VERDICT: NOT VERIFIED' "$TMP/live.txt"
if grep -q 'DEFENSE VERIFIED' "$TMP/live.txt"; then
  echo "No-response condition was incorrectly called a verified defense" >&2
  exit 1
fi

bash "$ROOT/vault/generate_report.sh" > "$TMP/report.txt"
grep -q 'Total observations: 3' "$TMP/report.txt"
grep -q 'Connection unavailable: 1' "$TMP/report.txt"
grep -q 'Non-200 HTTP responses: 1' "$TMP/report.txt"
grep -q 'Security verification: NOT VERIFIED' "$TMP/report.txt"

ITERATIONS=2 PORT=18888 bash "$ROOT/vault/forensic_soak_test.sh" > "$TMP/soak.txt"
grep -q '"status":"UNAVAILABLE"' "$LOG"
[[ "$(grep -c '"status":"UNAVAILABLE"' "$LOG")" -ge 3 ]]

echo "Forensic script regression tests passed."
