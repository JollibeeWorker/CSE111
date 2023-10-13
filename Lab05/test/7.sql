.headers on

WITH PartValues AS (
    SELECT p.p_name,
           ps.ps_supplycost * ps.ps_availqty AS Total_Value
    FROM partsupp ps
    JOIN part p ON ps.ps_partkey = p.p_partkey
    JOIN supplier s ON ps.ps_suppkey = s.s_suppkey
    JOIN nation n ON s.s_nationkey = n.n_nationkey
    WHERE n.n_name = 'FRANCE'
),
Top5PercentCount AS (
    SELECT CAST(ROUND(0.05 * COUNT(*)) AS INTEGER) AS Top5Count
    FROM PartValues
)
SELECT p_name
FROM PartValues
ORDER BY Total_Value DESC
LIMIT (SELECT Top5Count FROM Top5PercentCount);