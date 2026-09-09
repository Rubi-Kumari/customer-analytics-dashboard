-- ============================================
-- QUERY 14: PAYMENT METHOD & FRAUD ANALYSIS
-- ============================================
-- Analyze payment patterns and transaction health
-- Business Value: Payment optimization and risk management

WITH payment_analysis AS (
  SELECT 
    o.payment_method,
    o.order_status,
    COUNT(o.order_id) AS order_count,
    ROUND(SUM(o.total_amount), 2) AS total_value,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value,
    COUNT(DISTINCT o.customer_id) AS unique_customers,
    -- Failure rate
    SUM(CASE WHEN o.order_status IN ('cancelled', 'refunded') THEN 1 ELSE 0 END) AS failed_orders,
    ROUND(
      (SUM(CASE WHEN o.order_status IN ('cancelled', 'refunded') THEN 1 ELSE 0 END) / COUNT(o.order_id)) * 100,
      2
    ) AS failure_rate_percent
  FROM orders o
  GROUP BY o.payment_method, o.order_status
)
SELECT 
  payment_method,
  order_status,
  order_count,
  total_value,
  avg_order_value,
  unique_customers,
  failed_orders,
  failure_rate_percent,
  -- Payment method preference
  ROUND((order_count / SUM(order_count) OVER (PARTITION BY payment_method)) * 100, 2) AS percent_of_method
FROM payment_analysis
ORDER BY total_value DESC, order_count DESC;