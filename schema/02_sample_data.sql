-- Customer Analytics Dashboard - Sample Data Generation
-- Generates realistic sample data for analytics queries

-- ============================================
-- INSERT PRODUCTS (100 products across 5 categories)
-- ============================================
INSERT INTO products (product_name, category, price, cost, stock_quantity, created_date) VALUES
('Wireless Earbuds', 'Electronics', 79.99, 35.00, 500, '2024-01-15'),
('USB-C Cable', 'Electronics', 12.99, 3.50, 2000, '2024-01-15'),
('Phone Case', 'Accessories', 24.99, 5.00, 1500, '2024-01-20'),
('Screen Protector', 'Accessories', 9.99, 1.50, 3000, '2024-01-20'),
('Laptop Stand', 'Office', 49.99, 15.00, 800, '2024-02-01'),
('Mechanical Keyboard', 'Office', 89.99, 30.00, 600, '2024-02-01'),
('Wireless Mouse', 'Office', 34.99, 10.00, 1000, '2024-02-05'),
('Monitor Light Bar', 'Office', 59.99, 20.00, 400, '2024-02-10'),
('Phone Mount', 'Accessories', 19.99, 4.00, 2000, '2024-02-15'),
('Portable Charger', 'Electronics', 39.99, 12.00, 1200, '2024-02-20');

-- Add more products to reach 100
INSERT INTO products (product_name, category, price, cost, stock_quantity, created_date)
SELECT 
  CONCAT('Product_', ROW_NUMBER() OVER (ORDER BY RAND())),
  ELT(FLOOR(RAND() * 5) + 1, 'Electronics', 'Accessories', 'Office', 'Fashion', 'Home'),
  ROUND(10 + RAND() * 200, 2),
  ROUND(3 + RAND() * 80, 2),
  FLOOR(100 + RAND() * 2000),
  DATE_ADD('2024-01-01', INTERVAL FLOOR(RAND() * 180) DAY)
FROM (
  SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 
  UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
) t1 
CROSS JOIN (
  SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
  UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9
) t2
LIMIT 90;

-- ============================================
-- INSERT CUSTOMERS (10,000 customers)
-- ============================================
INSERT INTO customers (email, customer_name, country, city, signup_date, account_status, customer_tier)
SELECT 
  CONCAT('customer_', LPAD(ROW_NUMBER() OVER (ORDER BY RAND()), 6, '0'), '@example.com'),
  CONCAT('Customer_', ROW_NUMBER() OVER (ORDER BY RAND())),
  ELT(FLOOR(RAND() * 5) + 1, 'USA', 'UK', 'Canada', 'Australia', 'Germany'),
  ELT(FLOOR(RAND() * 10) + 1, 'New York', 'London', 'Toronto', 'Sydney', 'Berlin', 'Chicago', 'Mumbai', 'Singapore', 'Dubai', 'Paris'),
  DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 365) DAY),
  ELT(FLOOR(RAND() * 4) + 1, 'active', 'active', 'active', 'inactive'),
  ELT(FLOOR(RAND() * 4) + 1, 'bronze', 'silver', 'gold', 'platinum')
FROM (
  SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
  UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
) t1 
CROSS JOIN (
  SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
  UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
) t2
CROSS JOIN (
  SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
  UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
) t3
CROSS JOIN (
  SELECT 1 UNION SELECT 2
) t4
LIMIT 10000;

-- ============================================
-- INSERT ORDERS (50,000 orders from customers)
-- ============================================
INSERT INTO orders (customer_id, order_date, order_timestamp, total_amount, order_status, payment_method, discount_amount, shipping_cost)
SELECT 
  FLOOR(1 + RAND() * 10000),
  DATE_ADD('2024-01-01', INTERVAL FLOOR(RAND() * 250) DAY),
  TIMESTAMP(DATE_ADD('2024-01-01', INTERVAL FLOOR(RAND() * 250) DAY), SEC_TO_TIME(FLOOR(RAND() * 86400))),
  ROUND(50 + RAND() * 1500, 2),
  ELT(FLOOR(RAND() * 6) + 1, 'confirmed', 'confirmed', 'shipped', 'delivered', 'delivered', 'cancelled'),
  ELT(FLOOR(RAND() * 4) + 1, 'credit_card', 'debit_card', 'paypal', 'bank_transfer'),
  ROUND(RAND() * 100, 2),
  ROUND(5 + RAND() * 50, 2)
FROM (
  SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
  UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
) t1 
CROSS JOIN (
  SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
  UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
) t2
CROSS JOIN (
  SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
) t3
LIMIT 50000;

-- ============================================
-- INSERT ORDER ITEMS (2-5 items per order)
-- ============================================
INSERT INTO order_items (order_id, product_id, quantity, unit_price, total_price, discount_percent)
SELECT 
  o.order_id,
  FLOOR(1 + RAND() * 100),
  FLOOR(1 + RAND() * 5),
  ROUND(10 + RAND() * 200, 2),
  ROUND((FLOOR(1 + RAND() * 5)) * (10 + RAND() * 200), 2),
  ROUND(RAND() * 20, 2)
FROM orders o
CROSS JOIN (
  SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
) t
WHERE RAND() < 0.8;

-- ============================================
-- INSERT SUBSCRIPTIONS (15,000 active subscriptions)
-- ============================================
INSERT INTO subscriptions (customer_id, plan_type, billing_amount, billing_frequency, start_date, status, auto_renew)
SELECT 
  DISTINCT FLOOR(1 + RAND() * 10000),
  ELT(FLOOR(RAND() * 3) + 1, 'basic', 'standard', 'premium'),
  ELT(FLOOR(RAND() * 3) + 1, 9.99, 19.99, 29.99),
  ELT(FLOOR(RAND() * 3) + 1, 'monthly', 'quarterly', 'annual'),
  DATE_ADD('2024-01-01', INTERVAL FLOOR(RAND() * 200) DAY),
  ELT(FLOOR(RAND() * 4) + 1, 'active', 'active', 'paused', 'cancelled'),
  RAND() > 0.2
FROM (
  SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
  UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
) t1 
CROSS JOIN (
  SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
  UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
) t2
CROSS JOIN (
  SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
) t3
LIMIT 15000;

-- ============================================
-- INSERT CUSTOMER EVENTS (100,000+ events)
-- ============================================
INSERT INTO customer_events (customer_id, event_type, event_date, event_timestamp, product_id, event_value, device_type)
SELECT 
  FLOOR(1 + RAND() * 10000),
  ELT(FLOOR(RAND() * 14) + 1, 'signup', 'login', 'page_view', 'search', 'add_to_cart', 
      'checkout', 'purchase', 'return', 'support_ticket', 'email_opened', 
      'email_clicked', 'wishlist_add', 'review_posted', 'subscription_started'),
  DATE_ADD('2024-01-01', INTERVAL FLOOR(RAND() * 250) DAY),
  TIMESTAMP(DATE_ADD('2024-01-01', INTERVAL FLOOR(RAND() * 250) DAY), SEC_TO_TIME(FLOOR(RAND() * 86400))),
  IF(RAND() > 0.3, FLOOR(1 + RAND() * 100), NULL),
  ROUND(RAND() * 500, 2),
  ELT(FLOOR(RAND() * 3) + 1, 'mobile', 'desktop', 'tablet')
FROM (
  SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
  UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
) t1 
CROSS JOIN (
  SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
  UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
) t2
CROSS JOIN (
  SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
  UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9
) t3
LIMIT 100000;

-- ============================================
-- UPDATE CUSTOMER METRICS
-- ============================================
UPDATE customers c
SET 
  total_spent = (SELECT COALESCE(SUM(total_amount), 0) FROM orders o WHERE o.customer_id = c.customer_id),
  last_purchase_date = (SELECT MAX(order_date) FROM orders o WHERE o.customer_id = c.customer_id),
  lifetime_value = (SELECT COALESCE(SUM(total_amount), 0) FROM orders o WHERE o.customer_id = c.customer_id)
WHERE customer_id IN (SELECT DISTINCT customer_id FROM orders);

-- ============================================
-- VERIFICATION
-- ============================================
-- Run these queries to verify data:
-- SELECT COUNT(*) as total_customers FROM customers;
-- SELECT COUNT(*) as total_products FROM products;
-- SELECT COUNT(*) as total_orders FROM orders;
-- SELECT COUNT(*) as total_items FROM order_items;
-- SELECT COUNT(*) as total_subscriptions FROM subscriptions;
-- SELECT COUNT(*) as total_events FROM customer_events;