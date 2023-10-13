.headers on

SELECT r.r_name AS region,
       COUNT(DISTINCT c.c_custkey) AS cust_cnt

FROM customer c
JOIN orders o ON c.c_custkey = o.o_custkey
JOIN nation n ON c.c_nationkey = n.n_nationkey
JOIN region r ON n.n_regionkey = r.r_regionkey
WHERE c.c_acctbal > (SELECT AVG(c_acctbal) FROM customer)
GROUP BY r.r_name
ORDER BY r.r_name;