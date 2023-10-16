.headers on

WITH AsiaCustomerOrderedParts AS (
    SELECT DISTINCT
        l.l_partkey
    FROM 
        lineitem l
    JOIN 
        orders o ON l.l_orderkey = o.o_orderkey
    JOIN 
        customer c ON printf("%09d", o.o_custkey) = SUBSTR(c.c_custkey, 10)
    JOIN 
        nation n ON c.c_nationkey = n.n_nationkey
    JOIN 
        region r ON n.n_regionkey = r.r_regionkey
    WHERE 
        r.r_name = 'ASIA'
),
AfricaSuppliersForParts AS (
    SELECT 
        ps.ps_partkey,
        COUNT(DISTINCT ps.ps_suppkey) AS supplier_count
    FROM 
        partsupp ps
    JOIN 
        supplier s ON ps.ps_suppkey = s.s_suppkey
    JOIN 
        nation n ON s.s_nationkey = n.n_nationkey
    JOIN 
        region r ON n.n_regionkey = r.r_regionkey
    WHERE 
        r.r_name = 'AFRICA'
    GROUP BY 
        ps.ps_partkey
    HAVING 
        supplier_count = 3
)
SELECT 
    p.p_name AS part
FROM 
    part p
JOIN 
    AsiaCustomerOrderedParts acop ON p.p_partkey = acop.l_partkey
JOIN 
    AfricaSuppliersForParts asfp ON p.p_partkey = asfp.ps_partkey;