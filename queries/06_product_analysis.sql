-- ============================================
-- QUERY 6: PRODUCT PERFORMANCE ANALYSIS
-- ============================================
-- Analyze product sales, margins, and trends
-- Business Value: Inventory management and promotion strategy

WITH product_sales AS (
  SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    p.cost,
    p.stock_quantity,
    COUNT(DISTINCT oi.order_id) AS times_sold,
    SUM(oi.quantity) AS total_units_sold,
    ROUND(SUM(oi.total_price), 2) AS total_revenue,
    ROUND(SUM(oi.quantity * p.cost), 2) AS total_cost,
    ROUND(SUM(oi.total_price) - SUM(oi.quantity * p.cost), 2) AS total_profit,
    ROUND(AVG(oi.quantity), 2) AS avg_units_per_order,
    ROUND(AVG(oi.total_price), 2) AS avg_revenue_per_order,
    MAX(o.order_date) AS last_sold_date,
    COUNT(DISTINCT o.customer_id) AS unique_customers
  FROM products p
  LEFT JOIN order_items oi ON p.product_id = oi.product_id
  LEFT JOIN orders o ON oi.order_id = o.order_id 
    AND o.order_status NOT IN ('cancelled', 'refunded')
  GROUP BY p.product_id, p.product_name, p.category, p.price, p.cost, p.stock_quantity
)
SELECT 
  product_id,
  product_name,
  category,
  price,
  cost,
  stock_quantity,
  times_sold,
  total_units_sold,
  total_revenue,
  total_cost,
  total_profit,
  ROUND((total_profit / NULLIF(total_revenue, 0)) * 100, 2) AS profit_margin_percent,
  avg_units_per_order,
  avg_revenue_per_order,
  unique_customers,
  last_sold_date,
  DATEDIFF(CURDATE(), last_sold_date) AS days_since_last_sale,
  -- Product performance tier
  CASE 
    WHEN total_revenue >= (SELECT MAX(total_revenue) * 0.5 FROM product_sales) THEN 'Top Performer'
    WHEN total_revenue >= (SELECT MAX(total_revenue) * 0.25 FROM product_sales) THEN 'Strong'
    WHEN times_sold > 0 THEN 'Moderate'
    ELSE 'No Sales'
  END AS performance_tier
FROM product_sales
ORDER BY total_revenue DESC, total_profit DESC
LIMIT 200;