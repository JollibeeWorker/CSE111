.headers on

SELECT p.p_mfgr AS manufacturer
FROM partsupp ps
JOIN part p ON ps.ps_partkey = p.p_partkey
WHERE ps.ps_suppkey = '000000040'
ORDER BY ps.ps_availqty ASC
LIMIT 1;