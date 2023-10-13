.headers on

WITH ExcludedSuppliers AS (
    SELECT DISTINCT l.l_suppkey
    FROM lineitem l
    WHERE strftime('%Y', l.l_shipdate) = '1997'
    AND l.l_extendedprice < 1000
)
SELECT SUM(ps.ps_supplycost) AS total_supply_cost
FROM partsupp ps
JOIN part p ON ps.ps_partkey = p.p_partkey
JOIN lineitem l ON ps.ps_partkey = l.l_partkey AND ps.ps_suppkey = l.l_suppkey
WHERE p.p_retailprice < 2000
AND strftime('%Y', l.l_shipdate) = '1994'
AND l.l_suppkey NOT IN (SELECT l_suppkey FROM ExcludedSuppliers);