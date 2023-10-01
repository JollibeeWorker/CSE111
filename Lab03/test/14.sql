.headers on
SELECT r.r_name AS region_name, COUNT(o.o_orderkey) AS order_cnt
FROM orders o
JOIN customer c ON o.o_custkey = c.c_id
JOIN nation n ON c.c_nationkey = n.n_nationkey
JOIN region r ON n.n_regionkey = r.r_regionkey
WHERE o.o_orderstatus = 'F'
GROUP BY r.r_name
ORDER BY r.r_name;