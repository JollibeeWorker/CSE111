.headers on
SELECT c.c_custkey AS customer, COUNT(o.o_orderkey) AS cnt
FROM orders o
JOIN customer c ON o.o_custkey = c.c_id
JOIN nation n ON c.c_nationkey = n.n_nationkey
WHERE n.n_name = 'EGYPT' AND strftime('%Y', o.o_orderdate) = '1992'
GROUP BY c.c_custkey;