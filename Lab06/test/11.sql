.headers on

WITH RegionSpend AS (
    SELECT 
        r.r_name AS region,
        SUM(l.l_extendedprice) AS total_spent
    FROM 
        lineitem l
    JOIN 
        orders o ON l.l_orderkey = o.o_orderkey
    JOIN 
        customer c ON printf("%09d", o.o_custkey) = SUBSTR(c.c_custkey, 10)
    JOIN 
        nation cn ON c.c_nationkey = cn.n_nationkey
    JOIN 
        region r ON cn.n_regionkey = r.r_regionkey
    JOIN 
        supplier s ON l.l_suppkey = s.s_suppkey
    JOIN 
        nation sn ON s.s_nationkey = sn.n_nationkey
    WHERE 
        cn.n_regionkey = sn.n_regionkey
    GROUP BY 
        r.r_name
    ORDER BY 
        total_spent DESC
    LIMIT 1
)
SELECT 
    region
FROM 
    RegionSpend;