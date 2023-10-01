.headers on
SELECT DISTINCT n.n_name
FROM orders o
JOIN customer c ON o.o_custkey = c.c_id
JOIN nation n ON c.c_nationkey = n.n_nationkey
WHERE strftime('%Y-%m', o.o_orderdate) = '1994-12'
ORDER BY n.n_name;