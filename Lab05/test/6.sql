.headers on

WITH SteelPartSuppliers AS (
    SELECT p.p_size,
           s.s_name AS Supplier_Name,
           ps.ps_supplycost AS Supply_Cost,
           RANK() OVER(PARTITION BY p.p_size ORDER BY ps.ps_supplycost DESC) AS Rank

    FROM part p
    JOIN partsupp ps ON p.p_partkey = ps.ps_partkey
    JOIN supplier s ON ps.ps_suppkey = s.s_suppkey
    JOIN nation n ON s.s_nationkey = n.n_nationkey
    JOIN region r ON n.n_regionkey = r.r_regionkey
    WHERE p.p_type LIKE '%STEEL%'
    AND r.r_name = 'AMERICA'
)

SELECT p_size, Supplier_Name, Supply_Cost
FROM SteelPartSuppliers
WHERE Rank = 1
ORDER BY p_size;