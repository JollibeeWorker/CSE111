.headers on

WITH SupplierOrderCount AS (
    SELECT 
        l.l_suppkey AS supplier_key,
        COUNT(DISTINCT o.o_orderkey) AS order_count
    FROM 
        lineitem l
    JOIN 
        orders o ON l.l_orderkey = o.o_orderkey
    WHERE 
        printf("%09d", o.o_custkey) IN (
            SELECT 
                SUBSTR(c.c_custkey, 10)
            FROM 
                customer c
            JOIN 
                nation n ON c.c_nationkey = n.n_nationkey
            WHERE 
                n.n_name IN ('EGYPT', 'JORDAN')
        )
    GROUP BY 
        l.l_suppkey
    HAVING 
        order_count < 50
)
SELECT 
    COUNT(*) AS supplier_cnt
FROM 
    SupplierOrderCount;