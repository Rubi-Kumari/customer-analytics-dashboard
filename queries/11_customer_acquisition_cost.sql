-- ============================================
-- QUERY 11: CUSTOMER ACQUISITION COST (CAC) & ROI
-- ============================================
-- Estimate acquisition efficiency and payback period
-- Business Value: Marketing budget optimization

WITH customer_economics AS (
  SELECT 
    c.customer_id,
    c.customer_name,
    c.email,
    c.signup_date,
    DATEDIFF(CURDATE(), c.signup_date) AS customer_age_days,
    -- Total customer spend
    COALESCE(SUM(o.total_amount), 0) AS lifetime_value,
    -- Number of orders
    COUNT(DISTINCT o.order_id) AS total_orders,
    -- Average profit per order (assuming 30% margin)
    ROUND(COALESCE(AVG(o.total_amount), 0) * 0.3, 2) AS avg_profit_per_order
  FROM customers c
  LEFT JOIN orders o ON c.customer_id = o.customer_id 
    AND o.order_status NOT IN ('cancelled', 'refunded')
  GROUP BY c.customer_id, c.customer_name, c.email, c.signup_date
),
cohort_stats AS (
  SELECT 
    DATE_FORMAT(signup_date, '%Y-%m') AS signup_month,
    COUNT(*) AS cohort_size,
    ROUND(AVG(lifetime_value), 2) AS avg_ltv,
    ROUND(AVG(total_orders), 2) AS avg_orders,
    ROUND(AVG(customer_age_days), 0) AS avg_customer_age_days
  FROM customer_economics
  GROUP BY DATE_FORMAT(signup_date, '%Y-%m')
)
SELECT 
  ce.customer_id,
  ce.customer_name,
  ce.email,
  ce.signup_date,
  ce.customer_age_days,
  ce.lifetime_value,
  ce.total_orders,
  -- Estimated CAC (assuming $50 acquisition cost - adjust based on actual spend)
  50 AS estimated_cac,
  -- Payback period (days to recover CAC)
  CASE 
    WHEN ce.avg_profit_per_order * ce.total_orders > 0 
      THEN ROUND(50 / NULLIF(ce.avg_profit_per_order, 0))
    ELSE NULL
  END AS cac_payback_days,
  -- ROI
  ROUND(((ce.lifetime_value - 50) / 50) * 100, 2) AS estimated_roi_percent,
  -- Efficiency rating
  CASE 
    WHEN ce.lifetime_value / 50 >= 10 THEN 'Excellent'
    WHEN ce.lifetime_value / 50 >= 5 THEN 'Good'
    WHEN ce.lifetime_value / 50 >= 2 THEN 'Fair'
    ELSE 'Poor'
  END AS cac_efficiency_rating
FROM customer_economics ce
WHERE ce.lifetime_value > 0
ORDER BY ce.lifetime_value DESC, ce.total_orders DESC
LIMIT 500;