#!/bin/sh
# Talk to the MCP server without an MCP client: one JSON-RPC message per POST, JSON back.
# Needs KEYFLIGHT_API_KEY (kfp_…) in the environment and python3 (to put the PNR text into JSON).
set -e
URL=https://keyflight.io/mcp
PNR_FILE="$(dirname "$0")/../pnr-amadeus.txt"

call() {
  curl -sS "$URL" \
    -H "Authorization: Bearer $KEYFLIGHT_API_KEY" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json, text/event-stream" \
    -d "$1"
  echo
}

# 1. Handshake
call '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-06-18","capabilities":{},"clientInfo":{"name":"curl","version":"1.0"}}}'

# 2. The tools and their input schemas
call '{"jsonrpc":"2.0","id":2,"method":"tools/list"}'

# 3. decode_pnr on the example booking (counts towards the monthly decodes of your subscription)
BODY=$(python3 -c 'import json,sys; print(json.dumps({"jsonrpc":"2.0","id":3,"method":"tools/call","params":{"name":"decode_pnr","arguments":{"text":open(sys.argv[1]).read(),"view":"lines2"}}}))' "$PNR_FILE")
call "$BODY"
