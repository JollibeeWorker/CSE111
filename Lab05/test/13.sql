.headers on

SELECT sr.r_name AS supp_region,
       cr.r_name AS cust_region,
       strftime('%Y', l.l_shipdate) AS year,
       SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue
FROM lineitem l
JOIN orders o ON l.l_orderkey = o.o_orderkey
JOIN customer c ON o.o_custkey = c.c_custkey
JOIN nation cn ON c.c_nationkey = cn.n_nationkey
JOIN region cr ON cn.n_regionkey = cr.r_regionkey
JOIN supplier s ON l.l_suppkey = s.s_suppkey
JOIN nation sn ON s.s_nationkey = sn.n_nationkey
JOIN region sr ON sn.n_regionkey = sr.r_regionkey
WHERE strftime('%Y', l.l_shipdate) IN ('1994', '1995')
AND sr.r_name != cr.r_name
GROUP BY sr.r_name, cr.r_name, strftime('%Y', l.l_shipdate)
ORDER BY sr.r_name, cr.r_name, strftime('%Y', l.l_shipdate);