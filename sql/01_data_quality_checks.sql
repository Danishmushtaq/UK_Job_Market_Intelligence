
SELECT COUNT(*) FROM customers;
SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;
SELECT COUNT(*) AS canceled_orders
FROM orders
WHERE order_status = 'canceled';
SELECT COUNT(*) AS orders_2018
FROM orders
WHERE order_purchase_timestamp >= '2018-01-01'
  AND order_purchase_timestamp < '2019-01-01';