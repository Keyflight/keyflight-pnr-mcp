// Node.js 18+ (fetch is built in), in an ES module or an async function
const text = `RP/LHRBA/LHRBA            BA/BA  26APR26/1200Z   PQ7XNR
PQ7XNR/BA QLHR 03MAY
1.JOHNSON JOHN
2.JOHNSON JANE
3  BA 178 Y 03MAY 7 LHRJFK HK2  0855 1205  03MAY  E  BA/PQ7XNR
4  BA 117 Y 10MAY 7 JFKLHR HK2  1830 0640  11MAY  E  BA/PQ7XNR
5 TKT/TIME LIMIT
6 OPC LHRBA-10MAY:1900/1S2/Q TKT/T-BA
7 FA PAX 125-2196837482/ETBA/GBP560.20/03MAY26/LHRBA2104/00390755/S3-4`;

const response = await fetch('https://keyflight.io/api/v1/pnr/decode', {
  method: 'POST',
  headers: {
    Authorization: `Bearer ${process.env.KEYFLIGHT_API_KEY}`,
    'Content-Type': 'application/json',
  },
  body: JSON.stringify({ text, options: { "view": "table" } }),
});
const data = await response.json();
if (response.ok) {
  data.segments.forEach((s) => console.log(s.airlineCode, s.flightNumber, s.departure.date));
} else {
  console.error(response.status, data.error, data.message);
}
