.headers on

WITH NationsTotalPrice AS (
    SELECT 
        n.n_name AS country,
        SUM(l.l_extendedprice) AS total_price
    FROM 
        lineitem l
    JOIN 
        orders o ON l.l_orderkey = o.o_orderkey
    JOIN 
        customer c ON printf("%09d", o.o_custkey) = SUBSTR(c.c_custkey, 10)
    JOIN 
        nation n ON c.c_nationkey = n.n_nationkey
    WHERE 
        strftime('%Y', l.l_shipdate) = '1994'
    GROUP BY 
        n.n_name
)
SELECT 
    country
FROM 
    NationsTotalPrice
WHERE 
    total_price = (SELECT MIN(total_price) FROM NationsTotalPrice);