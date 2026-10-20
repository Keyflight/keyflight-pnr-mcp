# Python 3, needs: pip install requests
import os
import requests

text = """RP/LHRBA/LHRBA            BA/BA  26APR26/1200Z   PQ7XNR
PQ7XNR/BA QLHR 03MAY
1.JOHNSON JOHN
2.JOHNSON JANE
3  BA 178 Y 03MAY 7 LHRJFK HK2  0855 1205  03MAY  E  BA/PQ7XNR
4  BA 117 Y 10MAY 7 JFKLHR HK2  1830 0640  11MAY  E  BA/PQ7XNR
5 TKT/TIME LIMIT
6 OPC LHRBA-10MAY:1900/1S2/Q TKT/T-BA
7 FA PAX 125-2196837482/ETBA/GBP560.20/03MAY26/LHRBA2104/00390755/S3-4"""

response = requests.post(
    "https://keyflight.io/api/v1/pnr/decode",
    headers={"Authorization": f"Bearer {os.environ['KEYFLIGHT_API_KEY']}"},
    json={"text": text, "options": { "view": "table" }},
    timeout=30,
)
data = response.json()
if response.ok:
    for s in data["segments"]:
        print(s["airlineCode"], s["flightNumber"], s["departure"]["date"])
else:
    print(response.status_code, data["error"], data["message"])
