-- ============================================
-- QUERY 4: CUSTOMER LIFETIME VALUE (CLV) ANALYSIS
-- ============================================
-- Calculate historical and projected CLV
-- Business Value: Determine customer profitability and acquisition budget

WITH customer_metrics AS (
  SELECT 
    c.customer_id,
    c.customer_name,
    c.email,
    c.customer_tier,
    c.signup_date,
    DATEDIFF(CURDATE(), c.signup_date) AS customer_age_days,
    -- Total spend
    COALESCE(SUM(o.total_amount), 0) AS total_spend,
    -- Order count
    COUNT(DISTINCT o.order_id) AS total_orders,
    -- Average order value
    COALESCE(AVG(o.total_amount), 0) AS avg_order_value,
    -- Days between orders (purchase cycle)
    COALESCE(
      DATEDIFF(
        MAX(o.order_date),
        MIN(o.order_date)
      ) / NULLIF(COUNT(DISTINCT o.order_id) - 1, 0),
      0
    ) AS avg_days_between_orders,
    -- Last purchase date
    MAX(o.order_date) AS last_purchase_date
  FROM customers c
  LEFT JOIN orders o ON c.customer_id = o.customer_id 
    AND o.order_status NOT IN ('cancelled', 'refunded')
  GROUP BY c.customer_id, c.customer_name, c.email, c.customer_tier, c.signup_date
)
SELECT 
  customer_id,
  customer_name,
  email,
  customer_tier,
  signup_date,
  customer_age_days,
  total_orders,
  total_spend AS historical_clv,
  avg_order_value,
  avg_days_between_orders,
  last_purchase_date,
  -- Projected CLV (based on average order value and purchase frequency)
  ROUND(
    avg_order_value * (365 / NULLIF(GREATEST(avg_days_between_orders, 1), 0)) * 2,
    2
  ) AS projected_clv_2yr,
  -- CLV segment
  CASE 
    WHEN total_spend >= 5000 THEN 'Enterprise'
    WHEN total_spend >= 2000 THEN 'VIP'
    WHEN total_spend >= 500 THEN 'Premium'
    WHEN total_spend > 0 THEN 'Standard'
    ELSE 'Inactive'
  END AS clv_segment,
  -- Annual value estimate
  ROUND(avg_order_value * (365 / NULLIF(GREATEST(avg_days_between_orders, 1), 0)), 2) AS estimated_annual_value
FROM customer_metrics
WHERE total_spend > 0
ORDER BY total_spend DESC, total_orders DESC
LIMIT 1000;