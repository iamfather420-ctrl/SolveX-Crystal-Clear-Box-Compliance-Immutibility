#!/data/data/com.termux/files/usr/bin/bash
set -u

LOG_FILE="$HOME/.agate_node/vault/consensus_memory.json"
REPORT_FILE="$HOME/.agate_node/vault/forensic_summary.txt"
TIMESTAMP="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

if [[ ! -f "$LOG_FILE" ]]; then
    mkdir -p "$(dirname "$REPORT_FILE")"
    {
        echo "--- AGATE FORENSIC OBSERVATION REPORT: $TIMESTAMP ---"
        echo "Audit data status: UNAVAILABLE"
        echo "Total observations: N/A"
        echo "Explicit fail records: N/A"
        echo "HTTP 200 responses: N/A"
        echo "Security verification: NOT VERIFIED"
        echo "--- END REPORT ---"
    } > "$REPORT_FILE"
    cat "$REPORT_FILE"
    exit 2
fi

TOTAL_ATTEMPTS=$(wc -l < "$LOG_FILE" | tr -d ' ')
BLOCKED_ATTEMPTS=$(grep -cE '"status"[[:space:]]*:[[:space:]]*"FAIL"' "$LOG_FILE" 2>/dev/null || true)
SUCCESS_ATTEMPTS=$(grep -cE '"status"[[:space:]]*:[[:space:]]*"SUCCESS"' "$LOG_FILE" 2>/dev/null || true)
UNAVAILABLE_ATTEMPTS=$(grep -cE '"status"[[:space:]]*:[[:space:]]*"UNAVAILABLE"' "$LOG_FILE" 2>/dev/null || true)
HTTP_RESPONSE_ATTEMPTS=$(grep -cE '"status"[[:space:]]*:[[:space:]]*"HTTP_RESPONSE"' "$LOG_FILE" 2>/dev/null || true)

mkdir -p "$(dirname "$REPORT_FILE")"
{
    echo "--- AGATE FORENSIC OBSERVATION REPORT: $TIMESTAMP ---"
    echo "Audit data status: AVAILABLE"
    echo "Total observations: $TOTAL_ATTEMPTS"
    echo "Explicit fail records: $BLOCKED_ATTEMPTS"
    echo "HTTP 200 responses: $SUCCESS_ATTEMPTS"
    echo "Connection unavailable: $UNAVAILABLE_ATTEMPTS"
    echo "Non-200 HTTP responses: $HTTP_RESPONSE_ATTEMPTS"
    echo "Security verification: NOT VERIFIED"
    echo "Note: connectivity observations do not establish intrusion attempts or firewall effectiveness."
    echo "--- END REPORT ---"
} > "$REPORT_FILE"

cat "$REPORT_FILE"
