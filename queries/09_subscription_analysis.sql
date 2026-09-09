-- ============================================
-- QUERY 9: SUBSCRIPTION METRICS & MRR
-- ============================================
-- Analyze subscription performance and recurring revenue
-- Business Value: SaaS metrics and predictable revenue

WITH subscription_metrics AS (
  SELECT 
    s.subscription_id,
    s.customer_id,
    c.customer_name,
    c.email,
    s.plan_type,
    s.billing_frequency,
    s.billing_amount,
    s.start_date,
    s.end_date,
    s.status,
    s.auto_renew,
    -- Calculate subscription duration
    CASE 
      WHEN s.status = 'active' THEN DATEDIFF(CURDATE(), s.start_date)
      ELSE DATEDIFF(s.end_date, s.start_date)
    END AS subscription_duration_days,
    -- Calculate MRR contribution
    CASE 
      WHEN s.billing_frequency = 'monthly' THEN s.billing_amount
      WHEN s.billing_frequency = 'quarterly' THEN s.billing_amount / 3
      WHEN s.billing_frequency = 'annual' THEN s.billing_amount / 12
      ELSE 0
    END AS monthly_recurring_revenue
  FROM subscriptions s
  JOIN customers c ON s.customer_id = c.customer_id
)
SELECT 
  subscription_id,
  customer_id,
  customer_name,
  email,
  plan_type,
  billing_frequency,
  billing_amount,
  start_date,
  end_date,
  status,
  auto_renew,
  subscription_duration_days,
  ROUND(monthly_recurring_revenue, 2) AS monthly_recurring_revenue,
  -- Lifetime revenue from this subscription
  ROUND(
    CASE 
      WHEN subscription_duration_days > 0 THEN monthly_recurring_revenue * (subscription_duration_days / 30)
      ELSE 0
    END,
    2
  ) AS lifetime_subscription_value,
  -- Risk assessment
  CASE 
    WHEN status = 'active' AND auto_renew = 1 THEN 'Secure'
    WHEN status = 'active' AND auto_renew = 0 THEN 'At Risk'
    WHEN status = 'paused' THEN 'Paused'
    WHEN status = 'cancelled' THEN 'Cancelled'
    ELSE 'Expired'
  END AS subscription_health
FROM subscription_metrics
WHERE status IN ('active', 'paused', 'cancelled')
ORDER BY monthly_recurring_revenue DESC, subscription_duration_days DESC
LIMIT 1000;

-- Total MRR Summary
SELECT 
  'Monthly Recurring Revenue' AS metric,
  ROUND(SUM(
    CASE 
      WHEN s.billing_frequency = 'monthly' THEN s.billing_amount
      WHEN s.billing_frequency = 'quarterly' THEN s.billing_amount / 3
      WHEN s.billing_frequency = 'annual' THEN s.billing_amount / 12
      ELSE 0
    END
  ), 2) AS value
FROM subscriptions s
WHERE s.status = 'active';