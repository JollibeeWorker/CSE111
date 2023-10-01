.headers on
SELECT COUNT(o.o_orderkey) AS order_cnt
FROM orders o
JOIN customer c ON o.o_custkey = c.c_id
JOIN nation n ON c.c_nationkey = n.n_nationkey
WHERE n.n_name = 'ROMANIA' 
AND o.o_orderpriority = '1-URGENT' 
AND strftime('%Y', o.o_orderdate) BETWEEN '1993' AND '1997';