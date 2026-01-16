#!/usr/bin/env bash
set -euo pipefail

# Usage: ./snmpget_multi_oids.sh devices.txt [timeout] [retries]
# Each line: host community

INPUT_FILE="${1:-}"
TIMEOUT="${2:-2}"
RETRIES="${3:-1}"

community="device_comm"

if [[ -z "$INPUT_FILE" || ! -f "$INPUT_FILE" ]]; then
  echo "Usage: $0 <input_file> [timeout_sec] [retries]" >&2
  exit 1
fi

if ! command -v snmpget >/dev/null 2>&1; then
  echo "Error: snmpget not found. Install net-snmp tools." >&2
  exit 2
fi

# Define the OIDs you want for each device:
OIDS=(
  "1.3.6.1.2.1.31.1.1.1.18"
  "1.3.6.1.2.1.31.1.1.1.1"
)

DEFAULT_PORT=161

while IFS= read -r line; do
  [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue


  read -r -a fields <<<"$line"
  host="$line"
  #community="${fields[1]:-}"

  #read -r host community extra <<<"$line" || true
  if [[ -z "${host:-}" || -z "${community:-}" ]]; then
    echo "Skipping malformed line: $line" >&2
    continue
  fi

  if [[ "$host" == *:* ]]; then
    target="udp6:${host}:${DEFAULT_PORT}"
  else
    target="${host}:${DEFAULT_PORT}"
  fi

  for oid in "${OIDS[@]}"; do
    if output=$(snmpwalk -v 2c -c "$community" -t "$TIMEOUT" -r "$RETRIES" "$target" "$oid" 2>&1); then
      echo -e "${host}\t${oid}\t${output}"
    else
      echo -e "${host}\t${oid}\tERROR: $output" >&2
    fi
  done
done < "$INPUT_FILE"
``
