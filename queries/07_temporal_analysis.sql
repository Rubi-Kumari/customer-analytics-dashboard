-- ============================================
-- QUERY 7: TEMPORAL & SEASONAL ANALYSIS
-- ============================================
-- Identify daily, weekly, and seasonal patterns
-- Business Value: Demand forecasting and marketing timing

WITH daily_metrics AS (
  SELECT 
    o.order_date,
    DAYNAME(o.order_date) AS day_of_week,
    WEEK(o.order_date) AS week_number,
    MONTH(o.order_date) AS month_number,
    QUARTER(o.order_date) AS quarter,
    YEAR(o.order_date) AS year,
    COUNT(DISTINCT o.order_id) AS orders,
    COUNT(DISTINCT o.customer_id) AS customers,
    ROUND(SUM(o.total_amount), 2) AS revenue,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value
  FROM orders o
  WHERE o.order_status NOT IN ('cancelled', 'refunded')
  GROUP BY o.order_date, DAYNAME(o.order_date), WEEK(o.order_date), 
           MONTH(o.order_date), QUARTER(o.order_date), YEAR(o.order_date)
)
SELECT 
  order_date,
  day_of_week,
  week_number,
  month_number,
  CASE month_number
    WHEN 1 THEN 'January'
    WHEN 2 THEN 'February'
    WHEN 3 THEN 'March'
    WHEN 4 THEN 'April'
    WHEN 5 THEN 'May'
    WHEN 6 THEN 'June'
    WHEN 7 THEN 'July'
    WHEN 8 THEN 'August'
    WHEN 9 THEN 'September'
    WHEN 10 THEN 'October'
    WHEN 11 THEN 'November'
    WHEN 12 THEN 'December'
  END AS month_name,
  quarter,
  year,
  orders,
  customers,
  revenue,
  avg_order_value,
  ROUND(revenue / customers, 2) AS revenue_per_customer,
  -- Seasonal index (compared to average)
  ROUND(revenue / (SELECT AVG(revenue) FROM daily_metrics), 2) AS seasonal_index
FROM daily_metrics
ORDER BY year DESC, month_number DESC, order_date DESC;