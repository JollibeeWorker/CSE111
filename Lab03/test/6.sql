.headers on
SELECT n_name AS nation_name, SUM(s_acctbal) AS total_acct_bal
FROM supplier
JOIN nation ON supplier.s_nationkey = nation.n_nationkey
GROUP BY n_name
ORDER BY n_name;