SELECT
  r.id,
  u.id,
  u.name, 
  t.id,
  t.name,
  r.checkoutAt, 
  r.returnAt
FROM
  rental r
INNER JOIN
  user u ON r.user_id = u.id,
  tool t ON r.tool_id = t.id
WHERE
  ? OR r.returnAt is NULL
GROUP BY 
  r.id;
ORDER BY 
  r.checkoutAt;
