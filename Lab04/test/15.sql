.headers on
SELECT r.r_name AS region, s.s_name AS supplier, s.s_acctbal AS acct_bal
FROM supplier s
JOIN nation n ON s.s_nationkey = n.n_nationkey
JOIN region r ON n.n_regionkey = r.r_regionkey
WHERE (r.r_name, s.s_acctbal) IN (
    SELECT r2.r_name, MAX(s2.s_acctbal)
    FROM supplier s2
    JOIN nation n2 ON s2.s_nationkey = n2.n_nationkey
    JOIN region r2 ON n2.n_regionkey = r2.r_regionkey
    GROUP BY r2.r_name
);