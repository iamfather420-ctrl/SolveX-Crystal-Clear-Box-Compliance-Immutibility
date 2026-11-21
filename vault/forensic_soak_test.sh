#!/data/data/com.termux/files/usr/bin/bash
set -u

LOG_FILE="$HOME/.agate_node/vault/consensus_memory.json"
ITERATIONS="${ITERATIONS:-50000}"
PORT="${PORT:-8888}"
TARGET="http://127.0.0.1:$PORT"

cleanup() {
    local code=$?
    echo
    echo "Audit interrupted or finished. Releasing Termux wake lock..."
    if command -v termux-wake-unlock >/dev/null 2>&1; then termux-wake-unlock || true; fi
    exit "$code"
}
trap cleanup EXIT
trap 'exit 130' INT TERM

mkdir -p "$(dirname "$LOG_FILE")" || exit 1
if command -v termux-wake-lock >/dev/null 2>&1; then termux-wake-lock || true; fi

echo "Starting $ITERATIONS connectivity observations against $TARGET."
echo "Log format: JSON Lines. HTTP non-200 and connection failures are not classified as intrusions."
for ((i=1; i<=ITERATIONS; i++)); do
    TIMESTAMP="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
    HTTP_STATUS="$(curl --silent --show-error --output /dev/null --write-out "%{http_code}" --connect-timeout 1 --max-time 2 "$TARGET" 2>/dev/null)"
    CURL_EXIT=$?

    if [[ "$CURL_EXIT" -ne 0 || "$HTTP_STATUS" == "000" || -z "$HTTP_STATUS" ]]; then
        STATUS="UNAVAILABLE"
        EVENT="Connection observation unavailable"
    elif [[ "$HTTP_STATUS" == "200" ]]; then
        STATUS="SUCCESS"
        EVENT="HTTP endpoint returned 200"
    else
        STATUS="HTTP_RESPONSE"
        EVENT="HTTP endpoint returned a non-200 response"
    fi

    printf '{"timestamp":"%s","id":%d,"status":"%s","event":"%s","http_status":"%s"}\n' \
        "$TIMESTAMP" "$i" "$STATUS" "$EVENT" "${HTTP_STATUS:-000}" >> "$LOG_FILE"

    if (( i % 1000 == 0 )); then
        echo "Observations: $i / $ITERATIONS"
    fi
    sleep 0.1
done

echo "Observation run complete. This measures endpoint responses only; it does not prove intrusion detection or firewall effectiveness."
