SELECT 
    od.*,
    (SELECT o.customer_id 
     FROM orders o 
     WHERE o.id = od.order_id) AS customer_id
FROM 
    order_details od;


SELECT *
FROM order_details
WHERE order_id IN (
    SELECT id
    FROM orders
    WHERE shipper_id = 3
);


SELECT 
    sub.order_id,
    AVG(sub.quantity) AS avg_quantity
FROM 
    (
        SELECT *
        FROM order_details
        WHERE quantity > 10
    ) AS sub
GROUP BY 
    sub.order_id;


WITH temp AS (
    SELECT *
    FROM order_details
    WHERE quantity > 10
)
SELECT 
    temp.order_id,
    AVG(temp.quantity) AS avg_quantity
FROM 
    temp
GROUP BY 
    temp.order_id;
    
    
    
-- Спочатку видалимо функцію, якщо вона існує
DROP FUNCTION IF EXISTS divide_numbers;

-- Створюємо функцію
DELIMITER //

CREATE FUNCTION divide_numbers(a FLOAT, b FLOAT)
RETURNS FLOAT
DETERMINISTIC
BEGIN
    RETURN a / b;
END;
//

DELIMITER ;
SELECT 
    id,
    order_id,
    product_id,
    quantity,
    divide_numbers(quantity, 2) AS divided_quantity
FROM 
    order_details;


