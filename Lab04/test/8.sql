.headers on
SELECT COUNT(DISTINCT o.o_clerk) AS clerks
FROM orders o
JOIN customer c ON o.o_custkey = c.c_id
JOIN nation n ON c.c_nationkey = n.n_nationkey
WHERE n.n_name = 'PERU';