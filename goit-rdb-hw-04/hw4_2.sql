SELECT
    od.order_id,
    o.date
FROM order_details od
JOIN orders o ON od.order_id = o.id;

SELECT
    od.order_id,
    o.date,
    c.name AS customer_name
FROM order_details od
JOIN orders o ON od.order_id = o.id
JOIN customers c ON o.customer_id = c.id;

SELECT
    od.order_id,
    o.date,
    c.name AS customer_name,
    p.name AS product_name
FROM order_details od
JOIN orders o ON od.order_id = o.id
JOIN customers c ON o.customer_id = c.id
JOIN products p ON od.product_id = p.id;

SELECT
    od.order_id,
    o.date,
    c.name AS customer_name,
    p.name AS product_name,
    cat.name AS category_name
FROM order_details od
JOIN orders o ON od.order_id = o.id
JOIN customers c ON o.customer_id = c.id
JOIN products p ON od.product_id = p.id
JOIN categories cat ON p.category_id = cat.id;

SELECT
    od.order_id,
    o.date,
    c.name AS customer_name,
    p.name AS product_name,
    cat.name AS category_name,
    s.name AS supplier_name
FROM order_details od
JOIN orders o ON od.order_id = o.id
JOIN customers c ON o.customer_id = c.id
JOIN products p ON od.product_id = p.id
JOIN categories cat ON p.category_id = cat.id
JOIN suppliers s ON p.supplier_id = s.id;

SELECT
    od.order_id,
    o.date,
    c.name AS customer_name,
    p.name AS product_name,
    cat.name AS category_name,
    s.name AS supplier_name,
    e.first_name,
    e.last_name
FROM order_details od
JOIN orders o ON od.order_id = o.id
JOIN customers c ON o.customer_id = c.id
JOIN products p ON od.product_id = p.id
JOIN categories cat ON p.category_id = cat.id
JOIN suppliers s ON p.supplier_id = s.id
JOIN employees e ON o.employee_id = e.employee_id
LIMIT 0, 1000;

SELECT
    od.order_id,
    o.date,
    c.name AS customer_name,
    p.name AS product_name,
    cat.name AS category_name,
    s.name AS supplier_name,
    e.first_name,
    e.last_name,
    sh.name AS shipper_name
FROM order_details od
JOIN orders o ON od.order_id = o.id
JOIN customers c ON o.customer_id = c.id
JOIN products p ON od.product_id = p.id
JOIN categories cat ON p.category_id = cat.id
JOIN suppliers s ON p.supplier_id = s.id
JOIN employees e ON o.employee_id = e.employee_id
JOIN shippers sh ON o.shipper_id = sh.id
LIMIT 0, 1000;

SELECT COUNT(*) AS total_rows
FROM order_details od
JOIN orders o ON od.order_id = o.id
JOIN customers c ON o.customer_id = c.id
JOIN products p ON od.product_id = p.id
JOIN categories cat ON p.category_id = cat.id
JOIN suppliers s ON p.supplier_id = s.id
JOIN employees e ON o.employee_id = e.employee_id
JOIN shippers sh ON o.shipper_id = sh.id;

SELECT COUNT(*) AS total_rows_with_left
FROM order_details od
LEFT JOIN orders o ON od.order_id = o.id
LEFT JOIN customers c ON o.customer_id = c.id
LEFT JOIN products p ON od.product_id = p.id
LEFT JOIN categories cat ON p.category_id = cat.id
LEFT JOIN suppliers s ON p.supplier_id = s.id
LEFT JOIN employees e ON o.employee_id = e.employee_id
LEFT JOIN shippers sh ON o.shipper_id = sh.id;


SELECT *
FROM order_details od
JOIN orders o ON od.order_id = o.id
JOIN employees e ON o.employee_id = e.employee_id
WHERE e.employee_id > 3 AND e.employee_id <= 10;


SELECT
  cat.name AS category_name,
  COUNT(*) AS row_count,
  AVG(od.quantity) AS avg_quantity
FROM order_details od
JOIN products p ON od.product_id = p.id
JOIN categories cat ON p.category_id = cat.id
GROUP BY cat.name;



SELECT
  cat.name AS category_name,
  COUNT(*) AS row_count,
  AVG(od.quantity) AS avg_quantity
FROM order_details od
JOIN products p ON od.product_id = p.id
JOIN categories cat ON p.category_id = cat.id
GROUP BY cat.name
HAVING AVG(od.quantity) > 21;

SELECT
  cat.name AS category_name,
  COUNT(*) AS row_count,
  AVG(od.quantity) AS avg_quantity
FROM order_details od
JOIN products p ON od.product_id = p.id
JOIN categories cat ON p.category_id = cat.id
GROUP BY cat.name
ORDER BY row_count DESC;

SELECT *
FROM (
    SELECT
      od.order_id,
      o.date,
      c.name AS customer_name,
      p.name AS product_name,
      cat.name AS category_name,
      s.name AS supplier_name,
      e.first_name,
      e.last_name,
      sh.name AS shipper_name
    FROM order_details od
    JOIN orders o ON od.order_id = o.id
    JOIN customers c ON o.customer_id = c.id
    JOIN products p ON od.product_id = p.id
    JOIN categories cat ON p.category_id = cat.id
    JOIN suppliers s ON p.supplier_id = s.id
    JOIN employees e ON o.employee_id = e.employee_id
    JOIN shippers sh ON o.shipper_id = sh.id
    LIMIT 5
) AS sub
LIMIT 4 OFFSET 1;

