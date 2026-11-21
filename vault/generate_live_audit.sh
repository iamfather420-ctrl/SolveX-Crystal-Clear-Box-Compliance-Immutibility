#!/data/data/com.termux/files/usr/bin/bash
set -u

LOG_FILE="$HOME/.agate_node/vault/consensus_memory.json"
PORT="${PORT:-8888}"
TARGET_IP="${TARGET_IP:-127.0.0.1}"
TARGET_URL="http://$TARGET_IP:$PORT"

echo "--- AGATE CONNECTIVITY OBSERVATION: $(date -u +%Y-%m-%dT%H:%M:%SZ) ---"
if [[ ! -f "$LOG_FILE" ]]; then
    echo "AUDIT DATA STATUS: UNAVAILABLE (log file missing)"
    echo "TOTAL OBSERVATIONS: N/A"
    echo "HTTP FAILURES: N/A"
    echo "SECURITY VERDICT: NOT VERIFIED"
    exit 2
fi

TOTAL_CYCLES=$(wc -l < "$LOG_FILE" | tr -d ' ')
BLOCK_COUNT=$(grep -cE '"status"[[:space:]]*:[[:space:]]*"FAIL"' "$LOG_FILE" 2>/dev/null || true)
SUCCESS_COUNT=$(grep -cE '"status"[[:space:]]*:[[:space:]]*"SUCCESS"' "$LOG_FILE" 2>/dev/null || true)
UNAVAILABLE_COUNT=$(grep -cE '"status"[[:space:]]*:[[:space:]]*"UNAVAILABLE"' "$LOG_FILE" 2>/dev/null || true)
HTTP_RESPONSE_COUNT=$(grep -cE '"status"[[:space:]]*:[[:space:]]*"HTTP_RESPONSE"' "$LOG_FILE" 2>/dev/null || true)

echo "AUDIT DATA STATUS: AVAILABLE"
echo "TOTAL OBSERVATIONS: $TOTAL_CYCLES"
echo "HTTP 200 RESPONSES: $SUCCESS_COUNT"
echo "EXPLICIT FAIL RECORDS: $BLOCK_COUNT"
echo "CONNECTION UNAVAILABLE RECORDS: $UNAVAILABLE_COUNT"
echo "NON-200 HTTP RESPONSES: $HTTP_RESPONSE_COUNT"

HTTP_STATUS="$(curl --silent --show-error --output /dev/null --write-out "%{http_code}" --connect-timeout 1 --max-time 2 -I "$TARGET_URL" 2>/dev/null)"
CURL_EXIT=$?
if [[ "$CURL_EXIT" -eq 0 && "$HTTP_STATUS" != "000" && -n "$HTTP_STATUS" ]]; then
    echo "ENDPOINT OBSERVATION: SERVICE RESPONDED WITH HTTP $HTTP_STATUS"
else
    echo "ENDPOINT OBSERVATION: NO RESPONSE OBSERVED (does not prove firewall blocking)"
fi

echo "SECURITY VERDICT: NOT VERIFIED (connectivity observations alone cannot prove defense effectiveness)"
echo "RAW LOG TAIL:"
tail -n 3 "$LOG_FILE"
