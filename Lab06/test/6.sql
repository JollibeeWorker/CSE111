.headers on

WITH SupplierPartCount AS (
    SELECT 
        s.s_suppkey,
        COUNT(DISTINCT l.l_partkey) AS part_count
    FROM 
        supplier s
    JOIN 
        lineitem l ON s.s_suppkey = l.l_suppkey
    JOIN 
        nation n ON s.s_nationkey = n.n_nationkey
    WHERE 
        n.n_name = 'PERU'
    GROUP BY 
        s.s_suppkey
    HAVING 
        part_count > 40
)
SELECT 
    COUNT(*) AS supplier_cnt
FROM 
    SupplierPartCount;