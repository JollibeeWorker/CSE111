.headers on
SELECT n.n_name AS country, o.o_orderstatus AS status, COUNT(o.o_orderkey) AS orders
FROM customer c
JOIN orders o ON c.c_id = o.o_custkey
JOIN nation n ON c.c_nationkey = n.n_nationkey
JOIN region r ON n.n_regionkey = r.r_regionkey
WHERE r.r_name = 'AFRICA'
GROUP BY n.n_name, o.o_orderstatus
ORDER BY n.n_name, o.o_orderstatus;