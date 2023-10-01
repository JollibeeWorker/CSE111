.headers on
SELECT COUNT(DISTINCT o.o_orderkey) AS order_cnt
FROM orders o
JOIN customer c ON o.o_custkey = c.c_id
JOIN supplier s ON o.o_orderkey = s.s_suppkey
WHERE c.c_acctbal < 0 AND s.s_acctbal > 0;