.headers on

SELECT o.o_orderpriority AS priority,
       COUNT(DISTINCT o.o_orderkey) AS order_cnt
FROM orders o
JOIN lineitem l ON o.o_orderkey = l.l_orderkey
WHERE strftime('%Y', o.o_orderdate) = '1995'
AND l.l_receiptdate > l.l_commitdate
GROUP BY o.o_orderpriority
ORDER BY o.o_orderpriority;