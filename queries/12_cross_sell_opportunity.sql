-- ============================================
-- QUERY 12: CROSS-SELL & UP-SELL OPPORTUNITIES
-- ============================================
-- Identify products frequently bought together
-- Business Value: Product bundling and recommendation strategy

WITH product_pairs AS (
  SELECT 
    p1.product_id AS product_1_id,
    p1.product_name AS product_1_name,
    p1.category AS product_1_category,
    p2.product_id AS product_2_id,
    p2.product_name AS product_2_name,
    p2.category AS product_2_category,
    COUNT(DISTINCT o.order_id) AS times_bought_together,
    ROUND(COUNT(DISTINCT o.order_id) / (SELECT COUNT(DISTINCT order_id) FROM orders), 4) * 100 AS co_purchase_rate
  FROM order_items oi1
  JOIN order_items oi2 ON oi1.order_id = oi2.order_id AND oi1.product_id < oi2.product_id
  JOIN products p1 ON oi1.product_id = p1.product_id
  JOIN products p2 ON oi2.product_id = p2.product_id
  JOIN orders o ON oi1.order_id = o.order_id AND o.order_status NOT IN ('cancelled', 'refunded')
  GROUP BY p1.product_id, p1.product_name, p1.category, p2.product_id, p2.product_name, p2.category
  HAVING COUNT(DISTINCT o.order_id) >= 5
)
SELECT 
  product_1_id,
  product_1_name,
  product_1_category,
  product_2_id,
  product_2_name,
  product_2_category,
  times_bought_together,
  ROUND(co_purchase_rate, 2) AS co_purchase_rate_percent,
  -- Recommendation type
  CASE 
    WHEN product_1_category = product_2_category THEN 'Up-sell (Same Category)'
    ELSE 'Cross-sell (Different Category)'
  END AS recommendation_type
FROM product_pairs
ORDER BY times_bought_together DESC, co_purchase_rate DESC
LIMIT 100;