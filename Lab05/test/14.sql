.headers on

WITH RevenueFromFrance AS (
    SELECT SUM(l.l_extendedprice * (1 - l.l_discount)) AS France_Revenue
    FROM lineitem l
    JOIN orders o ON l.l_orderkey = o.o_orderkey
    JOIN customer c ON o.o_custkey = c.c_custkey
    JOIN nation cn ON c.c_nationkey = cn.n_nationkey
    JOIN region cr ON cn.n_regionkey = cr.r_regionkey
    JOIN supplier s ON l.l_suppkey = s.s_suppkey
    JOIN nation sn ON s.s_nationkey = sn.n_nationkey
    WHERE strftime('%Y', l.l_shipdate) = '1994'
    AND cr.r_name = 'AMERICA'
    AND sn.n_name = 'FRANCE'
),
TotalRevenue AS (
    SELECT SUM(l.l_extendedprice * (1 - l.l_discount)) AS Total_Revenue
    FROM lineitem l
    JOIN orders o ON l.l_orderkey = o.o_orderkey
    JOIN customer c ON o.o_custkey = c.c_custkey
    JOIN nation cn ON c.c_nationkey = cn.n_nationkey
    JOIN region cr ON cn.n_regionkey = cr.r_regionkey
    WHERE strftime('%Y', l.l_shipdate) = '1994'
    AND cr.r_name = 'AMERICA'
)
SELECT (France_Revenue / Total_Revenue) * 100 AS France_in_AMERICA_in_1994
FROM RevenueFromFrance, TotalRevenue;