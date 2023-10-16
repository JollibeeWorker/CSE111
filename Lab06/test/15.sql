.headers on

WITH YearlyEconomicExchange AS (
    SELECT 
        ns.n_name AS country,
        strftime('%Y', l.l_shipdate) AS year,
        (CASE 
            WHEN strftime('%Y', l.l_shipdate) = '1997' THEN SUM(l.l_quantity)
            ELSE 0
         END) AS qty_1997,
        (CASE 
            WHEN strftime('%Y', l.l_shipdate) = '1998' THEN SUM(l.l_quantity)
            ELSE 0
         END) AS qty_1998
    FROM 
        lineitem l
    JOIN 
        orders o ON l.l_orderkey = o.o_orderkey
    JOIN 
        supplier s ON l.l_suppkey = s.s_suppkey
    JOIN 
        nation ns ON s.s_nationkey = ns.n_nationkey
    WHERE 
        strftime('%Y', l.l_shipdate) IN ('1997', '1998') AND printf("%09d", o.o_custkey) <> SUBSTR(ns.n_nationkey, 10)
    GROUP BY 
        ns.n_name, strftime('%Y', l.l_shipdate)
)
SELECT 
    country,
    SUM(qty_1997) AS "1997",
    SUM(qty_1998) AS "1998"
FROM 
    YearlyEconomicExchange
GROUP BY 
    country
ORDER BY 
    country;