-- ============================================
-- QUERY 5: REVENUE ANALYTICS & TRENDS
-- ============================================
-- Analyze revenue trends, growth, and patterns
-- Business Value: Revenue forecasting and growth tracking

WITH monthly_revenue AS (
  SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS unique_customers,
    ROUND(SUM(o.total_amount), 2) AS gross_revenue,
    ROUND(SUM(o.discount_amount), 2) AS total_discounts,
    ROUND(SUM(o.shipping_cost), 2) AS total_shipping,
    ROUND(SUM(o.total_amount) - SUM(o.discount_amount), 2) AS net_revenue,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value
  FROM orders o
  WHERE o.order_status NOT IN ('cancelled', 'refunded')
  GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
)
SELECT 
  order_month,
  total_orders,
  unique_customers,
  gross_revenue,
  total_discounts,
  total_shipping,
  net_revenue,
  avg_order_value,
  -- Growth metrics
  LAG(gross_revenue) OVER (ORDER BY order_month) AS prev_month_revenue,
  ROUND(
    ((gross_revenue - LAG(gross_revenue) OVER (ORDER BY order_month)) / LAG(gross_revenue) OVER (ORDER BY order_month)) * 100,
    2
  ) AS mom_growth_percent,
  -- Customer metrics
  ROUND(gross_revenue / unique_customers, 2) AS revenue_per_customer,
  ROUND(total_orders / unique_customers, 2) AS orders_per_customer
FROM monthly_revenue
ORDER BY order_month DESC;