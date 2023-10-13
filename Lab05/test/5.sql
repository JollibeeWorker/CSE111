.headers on

WITH LineItemValue AS (
    SELECT l.l_partkey,
           p.p_name,
           l.l_extendedprice * (1 - l.l_discount) AS Value
    FROM lineitem l
    JOIN part p ON l.l_partkey = p.p_partkey
    WHERE l.l_shipdate > '1993-10-02'
)
SELECT p_name, Value
FROM LineItemValue
WHERE Value = (SELECT MAX(Value) FROM LineItemValue);