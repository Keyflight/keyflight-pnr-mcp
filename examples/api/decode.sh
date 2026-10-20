#!/bin/sh
# PNR API: decode the example Amadeus booking. Needs KEYFLIGHT_API_KEY (kfp_…) in the environment.
curl https://keyflight.io/api/v1/pnr/decode \
  -H "Authorization: Bearer $KEYFLIGHT_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
  "text": "RP/LHRBA/LHRBA            BA/BA  26APR26/1200Z   PQ7XNR\nPQ7XNR/BA QLHR 03MAY\n1.JOHNSON JOHN\n2.JOHNSON JANE\n3  BA 178 Y 03MAY 7 LHRJFK HK2  0855 1205  03MAY  E  BA/PQ7XNR\n4  BA 117 Y 10MAY 7 JFKLHR HK2  1830 0640  11MAY  E  BA/PQ7XNR\n5 TKT/TIME LIMIT\n6 OPC LHRBA-10MAY:1900/1S2/Q TKT/T-BA\n7 FA PAX 125-2196837482/ETBA/GBP560.20/03MAY26/LHRBA2104/00390755/S3-4",
  "options": {
    "view": "table"
  }
}'
