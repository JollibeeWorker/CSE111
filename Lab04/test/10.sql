.headers on
SELECT p.p_type AS part_type, MIN(l.l_discount) AS min_disc, MAX(l.l_discount) AS max_disc
FROM part p
JOIN lineitem l ON p.p_partkey = l.l_partkey
WHERE p.p_type LIKE '%ECONOMY%' OR p.p_type LIKE '%COPPER%'
GROUP BY p.p_type;