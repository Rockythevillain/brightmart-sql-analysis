-- BrightMart Sales Analysis
-- Analyst: Your Name
-- Tool: SQL

-- Q1: Total revenue per product
SELECT products.product_name, 
       SUM(orders.quantity * products.price) as total_rev
FROM products
LEFT JOIN orders ON products.product_id = orders.product_id
GROUP BY products.product_name
ORDER BY total_rev DESC;

-- Q2: Total revenue per customer
SELECT customers.name, 
       COALESCE(SUM(orders.quantity * products.price),0) as total_rev
FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id
LEFT JOIN products ON orders.product_id = products.product_id
GROUP BY customers.name
ORDER BY total_rev DESC;

-- Q3: Total revenue per city
SELECT customers.city, 
       SUM(orders.quantity * products.price) as total_rev
FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id
LEFT JOIN products ON orders.product_id = products.product_id
GROUP BY customers.city
ORDER BY total_rev DESC;

-- Q4: Total revenue per category
SELECT products.category, 
       SUM(orders.quantity * products.price) as total_rev
FROM products
LEFT JOIN orders ON products.product_id = orders.product_id
GROUP BY products.category
ORDER BY total_rev DESC;

-- Q5: Total revenue per month
SELECT orders.month, 
       SUM(orders.quantity * products.price) as total_rev
FROM products
LEFT JOIN orders ON products.product_id = orders.product_id
GROUP BY orders.month
ORDER BY orders.month ASC;

-- Q6: Top 3 customers by revenue
SELECT customers.name, customers.city, customers.loyalty_tier,
       SUM(orders.quantity * products.price) as total_rev
FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id
LEFT JOIN products ON orders.product_id = products.product_id
GROUP BY customers.name, customers.city, customers.loyalty_tier
ORDER BY total_rev DESC
LIMIT 3;

-- Q7: Revenue and orders per loyalty tier
SELECT customers.loyalty_tier, 
       COUNT(orders.order_id) as num_orders,
       SUM(orders.quantity * products.price) as total_rev
FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id
LEFT JOIN products ON orders.product_id = products.product_id
GROUP BY customers.loyalty_tier
ORDER BY total_rev DESC;

-- Q8: City analysis for Gold/Silver Electronics customers
SELECT customers.city, 
       SUM(orders.quantity * products.price) as total_amt,
       COUNT(DISTINCT customers.customer_id) as total_uniq_cus,
       AVG(orders.quantity * products.price) as total_avg
FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id
LEFT JOIN products ON orders.product_id = products.product_id
WHERE (customers.loyalty_tier = 'Gold' OR customers.loyalty_tier = 'Silver')
AND (products.category = 'Electronics')
GROUP BY customers.city
HAVING total_amt > 500
ORDER BY total_amt DESC;
