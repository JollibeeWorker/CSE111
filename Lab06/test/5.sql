.headers on

WITH CustomerOrderCount AS (
    SELECT 
        o.o_custkey,
        COUNT(o.o_orderkey) AS order_count
    FROM 
        orders o
    WHERE 
        strftime('%Y-%m', o.o_orderdate) = '1995-11'
    GROUP BY 
        o.o_custkey
    HAVING 
        order_count <= 3
)
SELECT 
    COUNT(*) AS customer_cnt
FROM 
    CustomerOrderCount;