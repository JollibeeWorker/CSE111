.headers on

WITH AfricanSuppliers AS (
    SELECT DISTINCT l.l_orderkey
    FROM lineitem l
    JOIN supplier s ON l.l_suppkey = s.s_suppkey
    JOIN nation n ON s.s_nationkey = n.n_nationkey
    JOIN region r ON n.n_regionkey = r.r_regionkey
    WHERE r.r_name = 'AFRICA'
)
SELECT COUNT(DISTINCT o.o_custkey) AS customer_cnt
FROM orders o
WHERE o.o_orderkey IN (SELECT l_orderkey FROM AfricanSuppliers)
AND o.o_orderkey NOT IN (
    SELECT l.l_orderkey
    FROM lineitem l
    WHERE l.l_suppkey NOT IN (
        SELECT s_suppkey
        FROM supplier
        JOIN nation ON supplier.s_nationkey = nation.n_nationkey
        JOIN region ON nation.n_regionkey = region.r_regionkey
        WHERE region.r_name = 'AFRICA'
    )
);