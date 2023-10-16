.headers on

WITH NationCustomerCount AS (
    SELECT 
        n.n_name AS country,
        COUNT(c.c_custkey) AS customer_count
    FROM 
        customer c
    JOIN 
        nation n ON c.c_nationkey = n.n_nationkey
    GROUP BY 
        n.n_name
)
SELECT 
    country
FROM 
    NationCustomerCount
WHERE 
    customer_count = (SELECT MAX(customer_count) FROM NationCustomerCount);