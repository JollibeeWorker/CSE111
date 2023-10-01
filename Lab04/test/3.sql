.headers on
SELECT c.c_custkey AS customer, SUM(o.o_totalprice) AS total_price
FROM orders o
JOIN customer c ON o.o_custkey = c.c_id
JOIN nation n ON c.c_nationkey = n.n_nationkey
WHERE n.n_name = 'ARGENTINA' AND strftime('%Y', o.o_orderdate) = '1996'
GROUP BY c.c_custkey;