.headers on

WITH NationSpend AS (
    SELECT 
        n.n_name AS country,
        SUM(o.o_totalprice) AS total_spent
    FROM 
        orders o
    JOIN 
        customer c ON printf("%09d", o.o_custkey) = SUBSTR(c.c_custkey, 10)
    JOIN 
        nation n ON c.c_nationkey = n.n_nationkey
    GROUP BY 
        n.n_name
)
SELECT 
    country
FROM 
    NationSpend
WHERE 
    total_spent = (SELECT MAX(total_spent) FROM NationSpend)
ORDER BY 
    total_spent DESC;