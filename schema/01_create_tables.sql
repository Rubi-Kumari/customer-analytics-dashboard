-- Customer Analytics Dashboard - Database Schema
-- Create all necessary tables for customer analytics

-- Drop tables if they exist (for fresh setup)
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS subscriptions;
DROP TABLE IF EXISTS customer_events;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- ============================================
-- CUSTOMERS TABLE
-- ============================================
CREATE TABLE customers (
  customer_id INT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(255) UNIQUE NOT NULL,
  customer_name VARCHAR(255) NOT NULL,
  country VARCHAR(100),
  city VARCHAR(100),
  signup_date DATE NOT NULL,
  account_status ENUM('active', 'inactive', 'suspended', 'churned') DEFAULT 'active',
  customer_tier ENUM('bronze', 'silver', 'gold', 'platinum') DEFAULT 'bronze',
  total_spent DECIMAL(15,2) DEFAULT 0,
  last_purchase_date DATE,
  lifetime_value DECIMAL(15,2) DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_email (email),
  INDEX idx_signup_date (signup_date),
  INDEX idx_account_status (account_status),
  INDEX idx_customer_tier (customer_tier)
);

-- ============================================
-- PRODUCTS TABLE
-- ============================================
CREATE TABLE products (
  product_id INT PRIMARY KEY AUTO_INCREMENT,
  product_name VARCHAR(255) NOT NULL,
  category VARCHAR(100) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  cost DECIMAL(10,2),
  stock_quantity INT DEFAULT 0,
  created_date DATE NOT NULL,
  updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_category (category),
  INDEX idx_price (price)
);

-- ============================================
-- ORDERS TABLE
-- ============================================
CREATE TABLE orders (
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT NOT NULL,
  order_date DATE NOT NULL,
  order_timestamp TIMESTAMP NOT NULL,
  total_amount DECIMAL(15,2) NOT NULL,
  order_status ENUM('pending', 'confirmed', 'shipped', 'delivered', 'cancelled', 'refunded') DEFAULT 'pending',
  payment_method ENUM('credit_card', 'debit_card', 'paypal', 'bank_transfer') DEFAULT 'credit_card',
  discount_amount DECIMAL(10,2) DEFAULT 0,
  shipping_cost DECIMAL(10,2) DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  INDEX idx_customer_id (customer_id),
  INDEX idx_order_date (order_date),
  INDEX idx_order_status (order_status)
);

-- ============================================
-- ORDER ITEMS TABLE
-- ============================================
CREATE TABLE order_items (
  item_id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  total_price DECIMAL(15,2) NOT NULL,
  discount_percent DECIMAL(5,2) DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id),
  INDEX idx_order_id (order_id),
  INDEX idx_product_id (product_id)
);

-- ============================================
-- SUBSCRIPTIONS TABLE
-- ============================================
CREATE TABLE subscriptions (
  subscription_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT NOT NULL,
  plan_type ENUM('basic', 'standard', 'premium') DEFAULT 'basic',
  billing_amount DECIMAL(10,2) NOT NULL,
  billing_frequency ENUM('monthly', 'quarterly', 'annual') DEFAULT 'monthly',
  start_date DATE NOT NULL,
  end_date DATE,
  status ENUM('active', 'paused', 'cancelled', 'expired') DEFAULT 'active',
  auto_renew BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  INDEX idx_customer_id (customer_id),
  INDEX idx_status (status),
  INDEX idx_start_date (start_date)
);

-- ============================================
-- CUSTOMER EVENTS TABLE
-- ============================================
CREATE TABLE customer_events (
  event_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT NOT NULL,
  event_type ENUM(
    'signup', 'login', 'page_view', 'search', 
    'add_to_cart', 'checkout', 'purchase', 
    'return', 'support_ticket', 'email_opened',
    'email_clicked', 'wishlist_add', 'review_posted',
    'subscription_started', 'subscription_cancelled'
  ) NOT NULL,
  event_date DATE NOT NULL,
  event_timestamp TIMESTAMP NOT NULL,
  product_id INT,
  order_id INT,
  event_value DECIMAL(10,2) DEFAULT 0,
  event_description VARCHAR(500),
  device_type ENUM('mobile', 'desktop', 'tablet') DEFAULT 'desktop',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  INDEX idx_customer_id (customer_id),
  INDEX idx_event_date (event_date),
  INDEX idx_event_type (event_type),
  INDEX idx_event_timestamp (event_timestamp)
);

-- ============================================
-- VERIFICATION QUERIES
-- ============================================
-- Run these to verify schema creation was successful:
-- SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'customer_analytics';
-- DESCRIBE customers;
-- DESCRIBE orders;
-- DESCRIBE products;
-- DESCRIBE subscriptions;
-- DESCRIBE customer_events;