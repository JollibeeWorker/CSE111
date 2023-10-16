.headers on

WITH ExportedItems AS (
    SELECT 
        ns.n_name AS country,
        SUM(l.l_quantity) AS exported_qty
    FROM 
        lineitem l
    JOIN 
        orders o ON l.l_orderkey = o.o_orderkey
    JOIN 
        supplier s ON l.l_suppkey = s.s_suppkey
    JOIN 
        nation ns ON s.s_nationkey = ns.n_nationkey
    WHERE 
        strftime('%Y', l.l_shipdate) = '1997' AND printf("%09d", o.o_custkey) <> SUBSTR(ns.n_nationkey, 10)
    GROUP BY 
        ns.n_name
),
ImportedItems AS (
    SELECT 
        nc.n_name AS country,
        SUM(l.l_quantity) AS imported_qty
    FROM 
        lineitem l
    JOIN 
        orders o ON l.l_orderkey = o.o_orderkey
    JOIN 
        customer c ON printf("%09d", o.o_custkey) = SUBSTR(c.c_custkey, 10)
    JOIN 
        nation nc ON c.c_nationkey = nc.n_nationkey
    WHERE 
        strftime('%Y', l.l_shipdate) = '1997' AND l.l_suppkey <> nc.n_nationkey
    GROUP BY 
        nc.n_name
),
Combined AS (
    SELECT 
        e.country, 
        COALESCE(exported_qty, 0) AS exported_qty, 
        0 AS imported_qty
    FROM 
        ExportedItems e
    UNION ALL
    SELECT 
        i.country, 
        0 AS exported_qty, 
        COALESCE(imported_qty, 0) AS imported_qty
    FROM 
        ImportedItems i
)
SELECT 
    country,
    SUM(exported_qty) - SUM(imported_qty) AS economic_exchange
FROM 
    Combined
GROUP BY 
    country
ORDER BY 
    economic_exchange DESC;