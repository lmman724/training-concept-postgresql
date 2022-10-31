
select * from lmman_practice.orders
----


SELECT order_date,
    order_status,
    count(1)
FROM lmman_practice.orders
GROUP BY order_date,
    order_status
ORDER BY order_date,
    order_status
LIMIT 18


----


----

SELECT * FROM crosstab(
    'SELECT order_date,
        order_status,
        count(1) AS order_count
    FROM lmman_practice.orders
    GROUP BY order_date,
        order_status',
    'SELECT DISTINCT order_status FROM lmman_practice.orders ORDER BY 1'
) AS (
    order_date DATE,
    "CANCELED" INT,
    "CLOSED" INT,
    "COMPLETE" INT,
    "ON_HOLD" INT,
    "PAYMENT_REVIEW" INT,
    "PENDING" INT,
    "PENDING_PAYMENT" INT,
    "PROCESSING" INT,
    "SUSPECTED_FRAUD" INT
)
LIMIT 10