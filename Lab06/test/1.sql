.headers on

WITH MaxTotalPrice AS (
    SELECT MAX(o_totalprice) AS max_price
    FROM orders
    WHERE o_orderstatus = 'F'
)
SELECT 
    s.s_name AS supplier,
    c.c_custkey AS customer,
    o.o_totalprice AS price
FROM 
    orders o
JOIN 
    customer c ON printf("%09d", o.o_custkey) = SUBSTR(c.c_custkey, 10)
JOIN 
    lineitem l ON l.l_orderkey = o.o_orderkey
JOIN 
    supplier s ON l.l_suppkey = s.s_suppkey
WHERE 
    o.o_orderstatus = 'F' AND o.o_totalprice = (SELECT max_price FROM MaxTotalPrice)
ORDER BY 
    o.o_totalprice DESC;
