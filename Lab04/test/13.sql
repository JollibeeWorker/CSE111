.headers on
SELECT r1.r_name AS supp_region, r2.r_name AS cust_region, MIN(o.o_totalprice) AS min_price
FROM orders o
JOIN customer c ON o.o_custkey = c.c_id
JOIN supplier s ON o.o_orderkey = s.s_suppkey
JOIN nation n1 ON s.s_nationkey = n1.n_nationkey
JOIN nation n2 ON c.c_nationkey = n2.n_nationkey
JOIN region r1 ON n1.n_regionkey = r1.r_regionkey
JOIN region r2 ON n2.n_regionkey = r2.r_regionkey
WHERE r1.r_name != r2.r_name
GROUP BY r1.r_name, r2.r_name;