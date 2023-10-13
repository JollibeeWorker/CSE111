.headers on

SELECT o.o_orderpriority AS priority,
       COUNT(l.l_orderkey) AS item_cnt

FROM lineitem l
JOIN orders o ON l.l_orderkey = o.o_orderkey
WHERE strftime('%Y', o.o_orderdate) = '1995'
AND l.l_receiptdate < l.l_commitdate
GROUP BY o.o_orderpriority
ORDER BY o.o_orderpriority;