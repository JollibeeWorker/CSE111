.headers on
SELECT COUNT(l.l_orderkey) AS items
FROM lineitem l
JOIN orders o ON l.l_orderkey = o.o_orderkey
JOIN customer c ON o.o_custkey = c.c_id
JOIN supplier s ON l.l_suppkey = s.s_suppkey
JOIN nation n1 ON s.s_nationkey = n1.n_nationkey
JOIN nation n2 ON c.c_nationkey = n2.n_nationkey
JOIN region r ON n1.n_regionkey = r.r_regionkey
WHERE r.r_name = 'ASIA' AND n2.n_name = 'KENYA';