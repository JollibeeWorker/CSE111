.headers on
SELECT strftime('%Y-%m', l.l_receiptdate) AS year_month, 
       COUNT(*) AS items
FROM lineitem l
JOIN orders o ON l.l_orderkey = o.o_orderkey
JOIN customer c ON o.o_custkey = c.c_id
WHERE c.c_custkey = 'Customer#000000227'
GROUP BY year_month
ORDER BY year_month;