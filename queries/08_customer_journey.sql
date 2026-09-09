-- ============================================
-- QUERY 8: CUSTOMER JOURNEY & ENGAGEMENT
-- ============================================
-- Track customer interaction patterns across touchpoints
-- Business Value: Understand conversion funnel and engagement

WITH customer_journey AS (
  SELECT 
    ce.customer_id,
    ce.event_type,
    COUNT(ce.event_id) AS event_count,
    COUNT(DISTINCT DATE(ce.event_timestamp)) AS days_with_event,
    MAX(ce.event_timestamp) AS last_event_time
  FROM customer_events ce
  GROUP BY ce.customer_id, ce.event_type
),
funnel_progression AS (
  SELECT 
    c.customer_id,
    c.customer_name,
    c.email,
    c.signup_date,
    MAX(CASE WHEN cj.event_type = 'login' THEN 1 ELSE 0 END) AS engaged_flag,
    MAX(CASE WHEN cj.event_type = 'page_view' THEN cj.event_count ELSE 0 END) AS page_views,
    MAX(CASE WHEN cj.event_type = 'search' THEN cj.event_count ELSE 0 END) AS searches,
    MAX(CASE WHEN cj.event_type = 'add_to_cart' THEN cj.event_count ELSE 0 END) AS add_to_cart_events,
    MAX(CASE WHEN cj.event_type = 'checkout' THEN cj.event_count ELSE 0 END) AS checkout_events,
    MAX(CASE WHEN cj.event_type = 'purchase' THEN cj.event_count ELSE 0 END) AS purchase_events,
    COUNT(DISTINCT o.order_id) AS actual_purchases,
    COALESCE(SUM(o.total_amount), 0) AS total_spent
  FROM customers c
  LEFT JOIN customer_journey cj ON c.customer_id = cj.customer_id
  LEFT JOIN orders o ON c.customer_id = o.customer_id 
    AND o.order_status NOT IN ('cancelled', 'refunded')
  GROUP BY c.customer_id, c.customer_name, c.email, c.signup_date
)
SELECT 
  customer_id,
  customer_name,
  email,
  signup_date,
  CASE 
    WHEN engaged_flag = 1 THEN 'Engaged'
    ELSE 'Not Engaged'
  END AS engagement_status,
  page_views,
  searches,
  add_to_cart_events,
  checkout_events,
  purchase_events,
  actual_purchases,
  total_spent,
  -- Conversion rate from page view to purchase
  ROUND((actual_purchases / NULLIF(page_views, 0)) * 100, 2) AS pv_to_purchase_rate,
  -- Conversion rate from add to cart to purchase
  ROUND((actual_purchases / NULLIF(add_to_cart_events, 0)) * 100, 2) AS atc_to_purchase_rate,
  -- Journey stage
  CASE 
    WHEN actual_purchases > 0 THEN 'Customer'
    WHEN add_to_cart_events > 0 THEN 'Cart Abandoner'
    WHEN search_events > 0 THEN 'Searcher'
    WHEN page_views > 0 THEN 'Browser'
    WHEN engaged_flag = 1 THEN 'Visitor'
    ELSE 'Prospect'
  END AS journey_stage
FROM funnel_progression
ORDER BY total_spent DESC, actual_purchases DESC
LIMIT 500;