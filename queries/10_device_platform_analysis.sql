-- ============================================
-- QUERY 10: DEVICE & PLATFORM ENGAGEMENT
-- ============================================
-- Analyze customer engagement by device type
-- Business Value: Mobile optimization and platform strategy

WITH device_engagement AS (
  SELECT 
    ce.device_type,
    COUNT(ce.event_id) AS total_events,
    COUNT(DISTINCT ce.customer_id) AS unique_users,
    COUNT(DISTINCT DATE(ce.event_timestamp)) AS active_days,
    -- Events by type
    SUM(CASE WHEN ce.event_type = 'page_view' THEN 1 ELSE 0 END) AS page_views,
    SUM(CASE WHEN ce.event_type = 'add_to_cart' THEN 1 ELSE 0 END) AS cart_additions,
    SUM(CASE WHEN ce.event_type = 'purchase' THEN 1 ELSE 0 END) AS purchases,
    SUM(CASE WHEN ce.event_type = 'purchase' THEN ce.event_value ELSE 0 END) AS purchase_value
  FROM customer_events ce
  GROUP BY ce.device_type
)
SELECT 
  device_type,
  total_events,
  unique_users,
  active_days,
  page_views,
  cart_additions,
  purchases,
  ROUND(purchase_value, 2) AS purchase_value,
  -- Engagement metrics
  ROUND(total_events / unique_users, 2) AS events_per_user,
  ROUND(purchases / NULLIF(cart_additions, 0), 3) AS cart_to_purchase_rate,
  ROUND(purchase_value / NULLIF(purchases, 0), 2) AS avg_purchase_value,
  -- Device preference
  ROUND((unique_users / SUM(unique_users) OVER ()) * 100, 2) AS percent_of_users
FROM device_engagement
ORDER BY purchase_value DESC;