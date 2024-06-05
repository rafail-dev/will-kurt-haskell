 SELECT 
    t.id, 
    t.name, 
    t.description, 
    COALESCE(MAX(r.returnAt), NULL) AS last_returned,
    COUNT(r.tool_id) AS timesBorrowed
FROM 
    tools t
LEFT JOIN 
    rental r ON t.id = r.tool_id
WHERE 
  name like '%' || ? || '%' or description like '%' || ? || '%'
GROUP BY 
    t.id, t.name, t.description
