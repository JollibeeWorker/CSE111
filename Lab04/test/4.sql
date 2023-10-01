.headers on
SELECT s.s_name AS supplier, COUNT(DISTINCT ps.ps_partkey) AS cnt
FROM partsupp ps
JOIN part p ON ps.ps_partkey = p.p_partkey
JOIN supplier s ON ps.ps_suppkey = s.s_suppkey
JOIN nation n ON s.s_nationkey = n.n_nationkey
WHERE n.n_name = 'KENYA' AND p.p_container LIKE '%BOX%'
GROUP BY s.s_name;