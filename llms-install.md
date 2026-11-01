# Installing the KeyFlight MCP server

Notes for AI agents (Cline and others) that set up this server for a user.

The server is hosted by KeyFlight at `https://keyflight.io/mcp` (Streamable HTTP, `POST` only, no sessions). There is nothing to clone, install or build.

## 1. Get the API key from the user

Ask the user for their KeyFlight API key. It starts with `kfp_` and is followed by 43 letters, digits, `-` and `_`. Do not invent one and do not continue without it.

If the user has no key: it comes with the KeyFlight subscription for travel agents (https://keyflight.io/subscription). On that page, "Already subscribed?" sends a link to the account page, where "Create API key" shows the key once.

## 2. Add the server

Cline, in `cline_mcp_settings.json` (MCP Servers → Configure MCP Servers):

```json
{
  "mcpServers": {
    "keyflight": {
      "type": "streamableHttp",
      "url": "https://keyflight.io/mcp",
      "headers": {
        "Authorization": "Bearer kfp_…"
      },
      "disabled": false,
      "autoApprove": []
    }
  }
}
```

Replace `kfp_…` with the user's key. The value of the header is `Bearer `, a space, then the key.

## 3. Check it works

The server lists two tools: `decode_pnr` and `make_ticket`. The list is available without a key; calling a tool needs a valid key with an active subscription.

Test with a short Amadeus PNR:

```
RP/LHRBA/LHRBA            BA/BA  26APR26/1200Z   PQ7XNR
1.JOHNSON JOHN
2  BA 178 Y 03MAY 7 LHRJFK HK1  0855 1205  03MAY  E  BA/PQ7XNR
```

`decode_pnr` with this text answers with one British Airways flight from London Heathrow to New York JFK.

Errors you may see:

- `401 missing_api_key` or `invalid_api_key`: the header is missing, misspelled or the key is wrong.
- `403 subscription_inactive`: the subscription of the key is not active.
- `429`: too many requests or the monthly limit is used; wait and retry later.

Full reference: https://keyflight.io/pnr-api#mcp
