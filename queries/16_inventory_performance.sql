-- ============================================
-- QUERY 16: INVENTORY TURNOVER & STOCK HEALTH
-- ============================================
-- Track inventory performance and stock movements
-- Business Value: Inventory optimization and supply chain

WITH inventory_metrics AS (
  SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    p.stock_quantity,
    SUM(oi.quantity) AS total_units_sold,
    COUNT(DISTINCT oi.order_id) AS times_sold,
    DATEDIFF(CURDATE(), MAX(o.order_date)) AS days_since_last_sale
  FROM products p
  LEFT JOIN order_items oi ON p.product_id = oi.product_id
  LEFT JOIN orders o ON oi.order_id = o.order_id 
    AND o.order_status NOT IN ('cancelled', 'refunded')
  GROUP BY p.product_id, p.product_name, p.category, p.price, p.stock_quantity
)
SELECT 
  product_id,
  product_name,
  category,
  price,
  stock_quantity,
  total_units_sold,
  times_sold,
  days_since_last_sale,
  -- Turnover rate (times per year)
  ROUND(total_units_sold / NULLIF(p.stock_quantity, 1) * (365 / GREATEST(days_since_last_sale, 1)), 2) AS annual_turnover_rate,
  -- Stock health
  CASE 
    WHEN p.stock_quantity = 0 THEN 'Out of Stock'
    WHEN p.stock_quantity < 50 AND total_units_sold > 0 THEN 'Low Stock - Reorder'
    WHEN days_since_last_sale > 180 THEN 'Dead Stock'
    WHEN days_since_last_sale > 90 THEN 'Slow Moving'
    WHEN times_sold >= 20 THEN 'Fast Moving'
    ELSE 'Normal'
  END AS stock_status
FROM inventory_metrics p
ORDER BY total_units_sold DESC, times_sold DESC;