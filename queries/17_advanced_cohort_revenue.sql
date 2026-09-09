-- ============================================
-- QUERY 17: ADVANCED COHORT REVENUE ANALYSIS
-- ============================================
-- Revenue progression by signup cohort
-- Business Value: Cohort profitability and growth patterns

WITH cohort_revenue AS (
  SELECT 
    DATE_FORMAT(c.signup_date, '%Y-%m') AS signup_cohort,
    EXTRACT(YEAR_MONTH FROM o.order_date) - EXTRACT(YEAR_MONTH FROM c.signup_date) AS months_since_signup,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(SUM(o.total_amount), 2) AS revenue
  FROM customers c
  LEFT JOIN orders o ON c.customer_id = o.customer_id 
    AND o.order_status NOT IN ('cancelled', 'refunded')
  WHERE DATE_FORMAT(c.signup_date, '%Y-%m') >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 12 MONTH), '%Y-%m')
  GROUP BY DATE_FORMAT(c.signup_date, '%Y-%m'), EXTRACT(YEAR_MONTH FROM o.order_date) - EXTRACT(YEAR_MONTH FROM c.signup_date)
)
SELECT 
  signup_cohort,
  months_since_signup,
  orders,
  revenue,
  SUM(revenue) OVER (PARTITION BY signup_cohort ORDER BY months_since_signup) AS cumulative_revenue
FROM cohort_revenue
WHERE months_since_signup BETWEEN 0 AND 11
ORDER BY signup_cohort DESC, months_since_signup ASC;