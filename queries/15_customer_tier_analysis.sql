-- ============================================
-- QUERY 15: CUSTOMER TIER PERFORMANCE
-- ============================================
-- Analyze performance by customer tier
-- Business Value: VIP management and tier optimization

WITH tier_metrics AS (
  SELECT 
    c.customer_tier,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    SUM(CASE WHEN c.account_status = 'active' THEN 1 ELSE 0 END) AS active_customers,
    SUM(CASE WHEN c.account_status = 'churned' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(c.total_spent), 2) AS total_tier_revenue,
    ROUND(AVG(c.total_spent), 2) AS avg_customer_value,
    ROUND(AVG(c.lifetime_value), 2) AS avg_lifetime_value,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value
  FROM customers c
  LEFT JOIN orders o ON c.customer_id = o.customer_id 
    AND o.order_status NOT IN ('cancelled', 'refunded')
  GROUP BY c.customer_tier
)
SELECT 
  customer_tier,
  total_customers,
  active_customers,
  churned_customers,
  ROUND((churned_customers / total_customers) * 100, 2) AS churn_rate_percent,
  total_tier_revenue,
  avg_customer_value,
  avg_lifetime_value,
  total_orders,
  avg_order_value,
  -- Tier contribution
  ROUND((total_tier_revenue / SUM(total_tier_revenue) OVER ()) * 100, 2) AS revenue_contribution_percent,
  -- Tier health
  CASE 
    WHEN (active_customers / total_customers) >= 0.9 THEN 'Excellent'
    WHEN (active_customers / total_customers) >= 0.7 THEN 'Good'
    WHEN (active_customers / total_customers) >= 0.5 THEN 'Fair'
    ELSE 'Poor'
  END AS tier_health_status
FROM tier_metrics
ORDER BY total_tier_revenue DESC;