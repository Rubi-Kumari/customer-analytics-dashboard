-- ============================================
-- QUERY 13: GEOGRAPHIC MARKET ANALYSIS
-- ============================================
-- Analyze customer base and sales by location
-- Business Value: Regional expansion and localization strategy

WITH geo_metrics AS (
  SELECT 
    c.country,
    c.city,
    COUNT(DISTINCT c.customer_id) AS customer_count,
    COUNT(DISTINCT o.order_id) AS order_count,
    ROUND(SUM(o.total_amount), 2) AS total_revenue,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value,
    ROUND(SUM(o.total_amount) / COUNT(DISTINCT c.customer_id), 2) AS revenue_per_customer,
    ROUND(COUNT(DISTINCT o.order_id) / COUNT(DISTINCT c.customer_id), 2) AS orders_per_customer,
    MAX(o.order_date) AS last_order_date
  FROM customers c
  LEFT JOIN orders o ON c.customer_id = o.customer_id 
    AND o.order_status NOT IN ('cancelled', 'refunded')
  GROUP BY c.country, c.city
)
SELECT 
  country,
  city,
  customer_count,
  order_count,
  total_revenue,
  avg_order_value,
  revenue_per_customer,
  orders_per_customer,
  last_order_date,
  -- Market size tier
  CASE 
    WHEN customer_count >= 500 THEN 'Tier 1 (Large)'
    WHEN customer_count >= 100 THEN 'Tier 2 (Medium)'
    WHEN customer_count >= 20 THEN 'Tier 3 (Small)'
    ELSE 'Tier 4 (Emerging)'
  END AS market_tier,
  -- Growth potential
  CASE 
    WHEN revenue_per_customer >= (SELECT AVG(revenue_per_customer) FROM geo_metrics) 
      AND customer_count < 1000 THEN 'High Growth Potential'
    WHEN revenue_per_customer < (SELECT AVG(revenue_per_customer) FROM geo_metrics) 
      AND customer_count >= 500 THEN 'Scale Opportunity'
    ELSE 'Maintain'
  END AS strategic_focus
FROM geo_metrics
ORDER BY total_revenue DESC, customer_count DESC;