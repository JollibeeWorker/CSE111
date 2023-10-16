.headers on

WITH LeastExpensivePart AS (
    SELECT 
        p.p_partkey
    FROM 
        part p
    WHERE 
        p.p_retailprice = (SELECT MIN(p_retailprice) FROM part)
)
SELECT 
    COUNT(DISTINCT l.l_suppkey) AS supplier_cnt
FROM 
    lineitem l
JOIN 
    LeastExpensivePart lep ON l.l_partkey = lep.p_partkey;