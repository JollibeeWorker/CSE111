.headers on
SELECT SUM(c.c_acctbal) AS tot_acct_bal
FROM customer c
JOIN nation n ON c.c_nationkey = n.n_nationkey
JOIN region r ON n.n_regionkey = r.r_regionkey
WHERE r.r_name = 'AMERICA' AND c.c_mktsegment = 'FURNITURE';
