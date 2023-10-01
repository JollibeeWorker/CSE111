.headers on
SELECT s.s_name AS supplier_name, COUNT(l.l_orderkey) AS discounted_items
FROM lineitem l
JOIN supplier s ON l.l_suppkey = s.s_suppkey
WHERE l.l_discount = 0.10
GROUP BY s.s_name
HAVING discounted_items_count > 0
ORDER BY s.s_name;