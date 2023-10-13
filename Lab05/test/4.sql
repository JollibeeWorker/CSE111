.headers on

SELECT COUNT(DISTINCT ps.ps_suppkey) AS supp_cnt
FROM partsupp ps
JOIN part p ON ps.ps_partkey = p.p_partkey
WHERE p.p_type LIKE '%POLISHED%'
AND p.p_size IN (10, 20, 30, 40);