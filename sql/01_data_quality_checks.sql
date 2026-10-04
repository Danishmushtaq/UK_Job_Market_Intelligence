-- ============================================================
-- OLIST E-COMMERCE DATA ANALYSIS
-- SQL BUSINESS ANALYSIS
-- ============================================================


-- ============================================================
-- 1. DATA QUALITY
-- ============================================================

-- Total customers
SELECT
    COUNT(*) AS total_customers
FROM customers;


-- Total orders
SELECT
    COUNT(*) AS total_orders
FROM orders;


-- Total reviews
SELECT
    COUNT(*) AS total_reviews
FROM reviews;


-- Duplicate customer IDs
SELECT
    customer_id,
    COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- Duplicate order IDs
SELECT
    order_id,
    COUNT(*) AS duplicate_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;


-- Missing delivery dates
SELECT
    COUNT(*) AS orders_missing_delivery_date
FROM orders
WHERE order_delivered_customer_date IS NULL;


-- ============================================================
-- 2. ORDER PERFORMANCE
-- ============================================================

-- Orders by status
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- Orders by year
SELECT
    strftime('%Y', order_purchase_timestamp) AS order_year,
    COUNT(*) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers
FROM orders
GROUP BY order_year
ORDER BY order_year;


-- Delivered orders by year
SELECT
    strftime('%Y', order_purchase_timestamp) AS order_year,
    COUNT(*) AS delivered_orders
FROM orders
WHERE order_status = 'delivered'
GROUP BY order_year
ORDER BY order_year;


-- ============================================================
-- 3. REVENUE ANALYSIS
-- ============================================================

-- Total product revenue and freight
SELECT
    ROUND(SUM(price), 2) AS total_product_revenue,
    ROUND(SUM(freight_value), 2) AS total_freight_revenue
FROM order_items;


-- Revenue by year
SELECT
    strftime('%Y', o.order_purchase_timestamp) AS order_year,
    ROUND(SUM(oi.price), 2) AS total_product_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY order_year
ORDER BY order_year;


-- Average order value by year
SELECT
    strftime('%Y', o.order_purchase_timestamp) AS order_year,
    ROUND(
        SUM(oi.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY order_year
ORDER BY order_year;


-- Monthly revenue
SELECT
    strftime('%Y-%m', o.order_purchase_timestamp) AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY order_month
ORDER BY order_month;


-- Top 5 revenue months
SELECT
    strftime('%Y-%m', o.order_purchase_timestamp) AS order_month,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY order_month
ORDER BY total_revenue DESC
LIMIT 5;


-- ============================================================
-- 4. PRODUCT CATEGORY ANALYSIS
-- ============================================================

-- Top categories by revenue
SELECT
    p.product_category_name,
    COUNT(*) AS items_sold,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items AS oi
JOIN products AS p
    ON oi.product_id = p.product_id
WHERE p.product_category_name IS NOT NULL
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;


-- Top categories by sales volume
SELECT
    p.product_category_name,
    COUNT(*) AS items_sold,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items AS oi
JOIN products AS p
    ON oi.product_id = p.product_id
WHERE p.product_category_name IS NOT NULL
GROUP BY p.product_category_name
ORDER BY items_sold DESC
LIMIT 10;


-- Highest average price by category
SELECT
    p.product_category_name,
    COUNT(*) AS items_sold,
    ROUND(AVG(oi.price), 2) AS average_price
FROM order_items AS oi
JOIN products AS p
    ON oi.product_id = p.product_id
WHERE p.product_category_name IS NOT NULL
GROUP BY p.product_category_name
HAVING COUNT(*) >= 50
ORDER BY average_price DESC
LIMIT 10;


-- ============================================================
-- 5. DELIVERY PERFORMANCE
-- ============================================================

-- Delivery performance
SELECT
    CASE
        WHEN order_delivered_customer_date <
             order_estimated_delivery_date
            THEN 'Early'

        WHEN order_delivered_customer_date =
             order_estimated_delivery_date
            THEN 'On Time'

        WHEN order_delivered_customer_date >
             order_estimated_delivery_date
            THEN 'Late'

        ELSE 'Unknown'
    END AS delivery_status,

    COUNT(*) AS total_orders

FROM orders

WHERE order_delivered_customer_date IS NOT NULL

GROUP BY delivery_status

ORDER BY total_orders DESC;


-- Delivery percentage
SELECT
    CASE
        WHEN order_delivered_customer_date <
             order_estimated_delivery_date
            THEN 'Early'

        WHEN order_delivered_customer_date =
             order_estimated_delivery_date
            THEN 'On Time'

        WHEN order_delivered_customer_date >
             order_estimated_delivery_date
            THEN 'Late'
    END AS delivery_status,

    COUNT(*) AS total_orders,

    ROUND(
        COUNT(*) * 100.0 /
        (
            SELECT COUNT(*)
            FROM orders
            WHERE order_delivered_customer_date IS NOT NULL
        ),
        2
    ) AS percentage_of_delivered_orders

FROM orders

WHERE order_delivered_customer_date IS NOT NULL

GROUP BY delivery_status

ORDER BY total_orders DESC;


-- ============================================================
-- 6. CUSTOMER REVIEWS
-- ============================================================

-- Overall review score distribution
SELECT
    review_score,
    COUNT(*) AS total_reviews,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM reviews),
        2
    ) AS percentage_of_reviews
FROM reviews
GROUP BY review_score
ORDER BY review_score DESC;


-- Average review score by order status
SELECT
    o.order_status,
    COUNT(r.review_id) AS total_reviews,
    ROUND(AVG(r.review_score), 2) AS average_review_score
FROM orders AS o
JOIN reviews AS r
    ON o.order_id = r.order_id
GROUP BY o.order_status
ORDER BY average_review_score DESC;


-- Delivery status vs review score
SELECT
    CASE
        WHEN o.order_delivered_customer_date <
             o.order_estimated_delivery_date
            THEN 'Early'

        WHEN o.order_delivered_customer_date =
             o.order_estimated_delivery_date
            THEN 'On Time'

        WHEN o.order_delivered_customer_date >
             o.order_estimated_delivery_date
            THEN 'Late'

        ELSE 'Unknown'
    END AS delivery_status,

    COUNT(r.review_id) AS total_reviews,

    ROUND(AVG(r.review_score), 2) AS average_review_score

FROM orders AS o

JOIN reviews AS r
    ON o.order_id = r.order_id

WHERE o.order_delivered_customer_date IS NOT NULL

GROUP BY delivery_status

ORDER BY average_review_score DESC;


-- ============================================================
-- 7. SELLER PERFORMANCE
-- ============================================================

-- Top sellers by revenue
SELECT
    seller_id,
    COUNT(*) AS items_sold,
    ROUND(SUM(price), 2) AS total_revenue,
    ROUND(AVG(price), 2) AS average_item_price
FROM order_items
GROUP BY seller_id
ORDER BY total_revenue DESC
LIMIT 10;


-- Top sellers by sales volume
SELECT
    seller_id,
    COUNT(*) AS items_sold,
    ROUND(SUM(price), 2) AS total_revenue
FROM order_items
GROUP BY seller_id
ORDER BY items_sold DESC
LIMIT 10;


-- Sellers with highest average item price
SELECT
    seller_id,
    COUNT(*) AS items_sold,
    ROUND(AVG(price), 2) AS average_item_price
FROM order_items
GROUP BY seller_id
HAVING COUNT(*) >= 50
ORDER BY average_item_price DESC
LIMIT 10;


-- ============================================================
-- 8. ORDER BASKET ANALYSIS
-- ============================================================

-- Orders containing multiple items
SELECT
    order_id,
    COUNT(*) AS items_in_order
FROM order_items
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY items_in_order DESC
LIMIT 10;


-- Average items per order
SELECT
    ROUND(
        CAST(COUNT(*) AS REAL) /
        COUNT(DISTINCT order_id),
        2
    ) AS average_items_per_order
FROM order_items;


-- Highest-value orders
SELECT
    order_id,
    ROUND(SUM(price), 2) AS order_value
FROM order_items
GROUP BY order_id
ORDER BY order_value DESC
LIMIT 10;


-- ============================================================
-- 9. PAYMENT ANALYSIS
-- ============================================================

-- Payment method performance
SELECT
    payment_type,
    COUNT(*) AS total_payments,
    ROUND(SUM(payment_value), 2) AS total_payment_value,
    ROUND(AVG(payment_value), 2) AS average_payment_value
FROM payments
GROUP BY payment_type
ORDER BY total_payment_value DESC;


-- Payment performance by year
SELECT
    strftime('%Y', o.order_purchase_timestamp) AS payment_year,
    p.payment_type,
    COUNT(*) AS total_payments,
    ROUND(SUM(p.payment_value), 2) AS total_payment_value,
    ROUND(AVG(p.payment_value), 2) AS average_payment_value
FROM orders AS o
JOIN payments AS p
    ON o.order_id = p.order_id
GROUP BY payment_year, p.payment_type
ORDER BY payment_year, total_payment_value DESC;


-- ============================================================
-- 10. REPEAT CUSTOMER ANALYSIS
-- ============================================================

-- Customers with more than one order
SELECT
    customer_id,
    COUNT(*) AS number_of_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY number_of_orders DESC;


-- Total repeat customers
SELECT
    COUNT(*) AS repeat_customers
FROM (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(*) > 1
);


-- ============================================================
-- END OF SQL BUSINESS ANALYSIS
-- ============================================================