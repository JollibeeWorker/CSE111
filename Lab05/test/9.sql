.headers on

SELECT r.r_name AS region,
       COUNT(DISTINCT s.s_suppkey) AS supp_cnt
FROM supplier s
JOIN nation n ON s.s_nationkey = n.n_nationkey
JOIN region r ON n.n_regionkey = r.r_regionkey
WHERE s.s_acctbal > (SELECT AVG(s_inner.s_acctbal)
                    FROM supplier s_inner
                    JOIN nation n_inner ON s_inner.s_nationkey = n_inner.n_nationkey
                    WHERE n_inner.n_regionkey = r.r_regionkey)
GROUP BY r.r_name
ORDER BY r.r_name;