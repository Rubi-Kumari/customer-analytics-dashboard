-- ============================================
-- QUERY 3: CHURN PREDICTION SIGNALS
-- ============================================
-- Identify at-risk customers likely to churn
-- Business Value: Proactive retention campaigns and winback strategies

WITH last_30_days AS (
  SELECT 
    c.customer_id,
    c.customer_name,
    c.email,
    c.signup_date,
    c.account_status,
    MAX(o.order_date) AS last_order_date,
    COUNT(o.order_id) AS orders_last_30_days,
    COALESCE(SUM(o.total_amount), 0) AS spent_last_30_days
  FROM customers c
  LEFT JOIN orders o ON c.customer_id = o.customer_id 
    AND o.order_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
    AND o.order_status NOT IN ('cancelled', 'refunded')
  GROUP BY c.customer_id, c.customer_name, c.email, c.signup_date, c.account_status
),
last_90_days_total AS (
  SELECT 
    c.customer_id,
    COUNT(o.order_id) AS orders_last_90_days,
    COALESCE(SUM(o.total_amount), 0) AS spent_last_90_days
  FROM customers c
  LEFT JOIN orders o ON c.customer_id = o.customer_id 
    AND o.order_date >= DATE_SUB(CURDATE(), INTERVAL 90 DAY)
    AND o.order_status NOT IN ('cancelled', 'refunded')
  GROUP BY c.customer_id
)
SELECT 
  l30.customer_id,
  l30.customer_name,
  l30.email,
  l30.account_status,
  l30.signup_date,
  l30.last_order_date,
  DATEDIFF(CURDATE(), l30.last_order_date) AS days_since_last_purchase,
  l30.orders_last_30_days,
  l30.spent_last_30_days,
  l90.orders_last_90_days,
  l90.spent_last_90_days,
  -- Churn risk score (0-100)
  CASE 
    WHEN DATEDIFF(CURDATE(), l30.last_order_date) > 60 THEN 100
    WHEN DATEDIFF(CURDATE(), l30.last_order_date) > 30 THEN 75
    WHEN l30.orders_last_30_days = 0 AND l90.orders_last_90_days > 0 THEN 60
    WHEN l30.spent_last_30_days < (l90.spent_last_90_days / 3) THEN 40
    ELSE 20
  END AS churn_risk_score,
  -- Risk category
  CASE 
    WHEN DATEDIFF(CURDATE(), l30.last_order_date) > 60 THEN 'CRITICAL'
    WHEN DATEDIFF(CURDATE(), l30.last_order_date) > 30 THEN 'HIGH'
    WHEN l30.orders_last_30_days = 0 THEN 'MEDIUM'
    ELSE 'LOW'
  END AS churn_risk_category
FROM last_30_days l30
JOIN last_90_days_total l90 ON l30.customer_id = l90.customer_id
WHERE l30.account_status = 'active' 
  AND l30.last_order_date IS NOT NULL
  AND DATEDIFF(CURDATE(), l30.last_order_date) > 14
ORDER BY churn_risk_score DESC, days_since_last_purchase DESC
LIMIT 500;