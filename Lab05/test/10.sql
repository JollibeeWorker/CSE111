.headers on

SELECT COUNT(DISTINCT c.c_custkey) AS cust_cnt
FROM customer c
JOIN nation n ON c.c_nationkey = n.n_nationkey
JOIN region r ON n.n_regionkey = r.r_regionkey
WHERE r.r_name NOT IN ('EUROPE', 'ASIA');