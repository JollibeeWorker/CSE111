.headers on
SELECT s.s_name AS supplier_name, 
       s.s_acctbal AS account_balance
FROM supplier s
JOIN nation n ON s.s_nationkey = n.n_nationkey
JOIN region r ON n.n_regionkey = r.r_regionkey
WHERE r.r_name = 'ASIA' AND s.s_acctbal > 5000
ORDER BY s.s_name;