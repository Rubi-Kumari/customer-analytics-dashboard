-- Customer Analytics Dashboard - Performance Indexes
-- Create additional indexes for optimized query performance

-- ============================================
-- CUSTOMERS TABLE INDEXES
-- ============================================
ALTER TABLE customers ADD INDEX idx_total_spent (total_spent DESC);
ALTER TABLE customers ADD INDEX idx_lifetime_value (lifetime_value DESC);
ALTER TABLE customers ADD INDEX idx_last_purchase_date (last_purchase_date DESC);
ALTER TABLE customers ADD INDEX idx_signup_status (signup_date, account_status);

-- ============================================
-- ORDERS TABLE INDEXES
-- ============================================
ALTER TABLE orders ADD INDEX idx_customer_order_date (customer_id, order_date DESC);
ALTER TABLE orders ADD INDEX idx_total_amount_desc (total_amount DESC);
ALTER TABLE orders ADD INDEX idx_order_date_status (order_date, order_status);
ALTER TABLE orders ADD INDEX idx_payment_method (payment_method);

-- ============================================
-- ORDER ITEMS TABLE INDEXES
-- ============================================
ALTER TABLE order_items ADD INDEX idx_product_order (product_id, order_id);

-- ============================================
-- SUBSCRIPTIONS TABLE INDEXES
-- ============================================
ALTER TABLE subscriptions ADD INDEX idx_customer_status (customer_id, status);
ALTER TABLE subscriptions ADD INDEX idx_plan_status (plan_type, status);
ALTER TABLE subscriptions ADD INDEX idx_start_end_date (start_date, end_date);

-- ============================================
-- CUSTOMER EVENTS TABLE INDEXES
-- ============================================
ALTER TABLE customer_events ADD INDEX idx_customer_event_date (customer_id, event_date DESC);
ALTER TABLE customer_events ADD INDEX idx_type_date (event_type, event_date);
ALTER TABLE customer_events ADD INDEX idx_product_event (product_id, event_date);

-- ============================================
-- COMPOSITE INDEXES FOR COMMON QUERIES
-- ============================================

-- For RFM analysis queries
ALTER TABLE orders ADD INDEX idx_customer_date_amount (customer_id, order_date, total_amount);

-- For cohort analysis
ALTER TABLE customers ADD INDEX idx_signup_status_value (signup_date, account_status, lifetime_value);

-- For churn analysis
ALTER TABLE orders ADD INDEX idx_customer_delivery_date (customer_id, order_status, order_date DESC);

-- For event analysis
ALTER TABLE customer_events ADD INDEX idx_event_type_customer_date (event_type, customer_id, event_date);

-- ============================================
-- ANALYZE TABLE STATISTICS
-- ============================================
ANALYZE TABLE customers;
ANALYZE TABLE products;
ANALYZE TABLE orders;
ANALYZE TABLE order_items;
ANALYZE TABLE subscriptions;
ANALYZE TABLE customer_events;

-- ============================================
-- VERIFY INDEXES
-- ============================================
-- Run these queries to view indexes:
-- SHOW INDEXES FROM customers;
-- SHOW INDEXES FROM orders;
-- SHOW INDEXES FROM customer_events;
-- SELECT * FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_SCHEMA = 'customer_analytics';