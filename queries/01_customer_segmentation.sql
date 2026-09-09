-- ============================================
-- QUERY 1: RFM CUSTOMER SEGMENTATION
-- ============================================
-- RFM = Recency, Frequency, Monetary
-- Segments customers based on purchase behavior
-- Business Value: Identify high-value customers and churn risk

WITH customer_rfm AS (
  SELECT 
    c.customer_id,
    c.customer_name,
    c.email,
    c.customer_tier,
    -- Recency: Days since last purchase
    DATEDIFF(CURDATE(), COALESCE(c.last_purchase_date, c.signup_date)) AS days_since_purchase,
    -- Frequency: Total number of orders
    COUNT(DISTINCT o.order_id) AS purchase_frequency,
    -- Monetary: Total amount spent
    COALESCE(SUM(o.total_amount), 0) AS total_monetary_value,
    -- Average order value
    COALESCE(AVG(o.total_amount), 0) AS avg_order_value,
    c.account_status
  FROM customers c
  LEFT JOIN orders o ON c.customer_id = o.customer_id 
    AND o.order_status NOT IN ('cancelled', 'refunded')
  GROUP BY c.customer_id, c.customer_name, c.email, c.customer_tier, c.last_purchase_date, c.signup_date, c.account_status
),
rfm_ranked AS (
  SELECT 
    *,
    -- R Score: 1-5 (5 = most recent)
    NTILE(5) OVER (ORDER BY days_since_purchase ASC) AS r_score,
    -- F Score: 1-5 (5 = most frequent)
    NTILE(5) OVER (ORDER BY purchase_frequency DESC) AS f_score,
    -- M Score: 1-5 (5 = highest spending)
    NTILE(5) OVER (ORDER BY total_monetary_value DESC) AS m_score
  FROM customer_rfm
)
SELECT 
  customer_id,
  customer_name,
  email,
  days_since_purchase,
  purchase_frequency,
  total_monetary_value,
  avg_order_value,
  account_status,
  r_score,
  f_score,
  m_score,
  CONCAT(r_score, f_score, m_score) AS rfm_score,
  -- Customer segment based on RFM
  CASE 
    WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champions'
    WHEN r_score >= 3 AND f_score >= 3 AND m_score >= 3 THEN 'Loyal Customers'
    WHEN r_score >= 4 AND (f_score <= 2 OR m_score <= 2) THEN 'At Risk'
    WHEN r_score <= 2 AND f_score >= 4 THEN 'Cant Lose Them'
    WHEN r_score <= 2 AND f_score <= 2 THEN 'Lost'
    ELSE 'Potential'
  END AS customer_segment
FROM rfm_ranked
ORDER BY total_monetary_value DESC, purchase_frequency DESC
LIMIT 1000;