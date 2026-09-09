-- ============================================
-- QUERY 2: COHORT RETENTION ANALYSIS
-- ============================================
-- Analyze customer retention by signup cohort
-- Business Value: Understand long-term customer value by acquisition period

WITH cohort_data AS (
  SELECT 
    c.customer_id,
    DATE_FORMAT(c.signup_date, '%Y-%m') AS signup_cohort,
    DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
    o.order_id,
    o.total_amount
  FROM customers c
  LEFT JOIN orders o ON c.customer_id = o.customer_id 
    AND o.order_status NOT IN ('cancelled', 'refunded')
),
cohort_size AS (
  SELECT 
    signup_cohort,
    COUNT(DISTINCT customer_id) AS cohort_size
  FROM cohort_data
  WHERE order_month IS NOT NULL
  GROUP BY signup_cohort
),
retention_table AS (
  SELECT 
    c.signup_cohort,
    DATEDIFF(
      STR_TO_DATE(CONCAT(c.order_month, '-01'), '%Y-%m-%d'),
      STR_TO_DATE(CONCAT(c.signup_cohort, '-01'), '%Y-%m-%d')
    ) / 30 AS months_since_signup,
    COUNT(DISTINCT c.customer_id) AS returning_customers
  FROM cohort_data c
  WHERE c.order_month IS NOT NULL
  GROUP BY c.signup_cohort, months_since_signup
)
SELECT 
  r.signup_cohort,
  cs.cohort_size,
  r.months_since_signup,
  r.returning_customers,
  ROUND((r.returning_customers / cs.cohort_size) * 100, 2) AS retention_rate_percent
FROM retention_table r
JOIN cohort_size cs ON r.signup_cohort = cs.signup_cohort
WHERE r.months_since_signup BETWEEN 0 AND 12
ORDER BY r.signup_cohort DESC, r.months_since_signup ASC;