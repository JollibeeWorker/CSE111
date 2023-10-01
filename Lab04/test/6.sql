.headers on
SELECT s.s_name AS supplier, o.o_orderpriority AS priority, COUNT(DISTINCT ps.ps_partkey) AS parts
FROM partsupp ps
JOIN orders o ON ps.ps_suppkey = o.o_custkey
JOIN supplier s ON ps.ps_suppkey = s.s_suppkey
JOIN nation n ON s.s_nationkey = n.n_nationkey
WHERE n.n_name = 'INDONESIA'
GROUP BY s.s_name, o.o_orderpriority;