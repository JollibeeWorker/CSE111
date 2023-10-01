.headers on
SELECT r.r_name AS region, MAX(s.s_acctbal) AS max_bal
FROM supplier s
JOIN nation n ON s.s_nationkey = n.n_nationkey
JOIN region r ON n.n_regionkey = r.r_regionkey
GROUP BY r.r_name
HAVING max_bal > 9000;