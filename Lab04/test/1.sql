.headers on
SELECT n.n_name AS country, COUNT(o.o_orderkey) AS cnt
FROM orders o
JOIN customer c ON o.o_custkey = c.c_id
JOIN nation n ON c.c_nationkey = n.n_nationkey
JOIN region r ON n.n_regionkey = r.r_regionkey
WHERE r.r_name = 'EUROPE'
GROUP BY n.n_name;