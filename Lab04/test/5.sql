.headers on
SELECT n.n_name AS country, COUNT(s.s_suppkey) AS cnt
FROM supplier s
JOIN nation n ON s.s_nationkey = n.n_nationkey
WHERE n.n_name IN ('ARGENTINA', 'BRAZIL')
GROUP BY n.n_name;