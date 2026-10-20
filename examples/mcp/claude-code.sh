#!/bin/sh
# Claude Code: add the KeyFlight MCP server (replace kfp_… with your key).
claude mcp add --transport http keyflight https://keyflight.io/mcp --header "Authorization: Bearer kfp_…"
