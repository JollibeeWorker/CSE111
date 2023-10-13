.headers on

WITH AverageDiscount AS (
    SELECT AVG(l.l_discount) AS Avg_Discount
    FROM lineitem l
    JOIN orders o ON l.l_orderkey = o.o_orderkey
)
SELECT MAX(l.l_discount) AS max_small_disc
FROM lineitem l
JOIN orders o ON l.l_orderkey = o.o_orderkey
WHERE strftime('%Y-%m', o.o_orderdate) = '1994-10'
AND l.l_discount < (SELECT Avg_Discount FROM AverageDiscount);
