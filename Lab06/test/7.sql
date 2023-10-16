.headers on

SELECT 
    strftime('%m', l.l_shipdate) AS month,
    SUM(l.l_quantity) AS tot_month
FROM 
    lineitem l
WHERE 
    strftime('%Y', l.l_shipdate) = '1997'
GROUP BY 
    month
ORDER BY 
    month ASC;