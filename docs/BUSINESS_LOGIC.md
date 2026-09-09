# Business Logic & Analytics Methodology

## Overview

This document explains the business logic, formulas, and methodology behind each analytics query.

---

## 1. RFM (Recency, Frequency, Monetary) Segmentation

### Methodology

**Recency (R)**
- Measures: Days since last purchase
- Formula: `DATEDIFF(CURDATE(), last_purchase_date)`
- Scoring: Ranked 1-5 (5 = most recent)
- Logic: Customers who purchased recently are more likely to engage

**Frequency (F)**
- Measures: Number of orders placed
- Formula: `COUNT(DISTINCT order_id)`
- Scoring: Ranked 1-5 (5 = most frequent)
- Logic: Loyal customers purchase more frequently

**Monetary (M)**
- Measures: Total amount spent
- Formula: `SUM(total_amount)`
- Scoring: Ranked 1-5 (5 = highest spender)
- Logic: High-value customers generate more revenue

### Customer Segments

| Segment | RFM Range | Characteristics | Action |
|---------|-----------|-----------------|--------|
| **Champions** | 4-5 All | Recent, frequent, high spend | Reward, VIP treatment |
| **Loyal Customers** | 3+ All | Consistent behavior | Upsell, premium offers |
| **At Risk** | 4+ R, Low F/M | Good recency, low engagement | Reactivation campaigns |
| **Cant Lose Them** | Low R, 4+ F | High value, inactive | Win-back offers |
| **Lost** | Low R/F/M | Inactive, low spend | Restart campaigns |
| **Potential** | Medium All | Average across metrics | Development campaigns |

---

## 2. Cohort Analysis

### Methodology

**Cohort Definition**
- Customers grouped by signup month: `YEAR-MONTH`
- Example: `2024-01` = all customers signed up in January 2024

**Retention Calculation**
```
Retention Rate (%) = (Returning Customers / Cohort Size) × 100
```

**Months Since Signup**
- Calculates period elapsed: 0 = signup month, 1 = 1 month later, etc.
- Maximum tracked: 12 months

### Example
**2024-01 Cohort**
- Cohort Size: 1,000 customers (signed up in Jan 2024)
- Month 0 (Jan): 1,000 retained (100%)
- Month 1 (Feb): 850 retained (85%)
- Month 3 (Apr): 650 retained (65%)
- Month 12 (Dec): 400 retained (40%)

### Business Interpretation
- **Good retention**: 60%+ at 6 months
- **Average retention**: 40-60% at 6 months
- **Poor retention**: <40% at 6 months
- **Declining retention curve**: Product-market fit issues

---

## 3. Churn Risk Scoring

### Methodology

**Churn Risk Score (0-100)**
```
IF days_since_purchase > 60 → Score = 100 (CRITICAL)
IF days_since_purchase > 30 → Score = 75 (HIGH)
IF recent_spend < (90-day_avg / 3) → Score = 60 (MEDIUM)
IF spending declining → Score = 40 (MEDIUM)
ELSE → Score = 20 (LOW)
```

**Risk Categories**
- **CRITICAL (100)**: 60+ days inactive | Action: Urgent outreach
- **HIGH (75)**: 30-60 days inactive | Action: Retention offer
- **MEDIUM (60)**: Declining activity | Action: Engagement campaign
- **LOW (20)**: Stable activity | Action: Monitor

**Indicators**
1. **Recency**: Days since last purchase
2. **Spending Trend**: Compare last 30 days vs 90 days
3. **Activity Decline**: Orders dropping month-over-month
4. **Account Status**: Active vs inactive

---

## 4. Customer Lifetime Value (CLV)

### Formulas

**Historical CLV**
```
Historical CLV = Total Amount Spent (All Time)
```

**Purchase Frequency**
```
Average Days Between Orders = (Last Order Date - First Order Date) / (Number of Orders - 1)
```

**Annual Value Estimate**
```
Annual Value = Average Order Value × (365 / Days Between Orders)
```

**Projected 2-Year CLV**
```
Projected CLV (2 Years) = Average Order Value × (365 / Days Between Orders) × 2
```

### CLV Segments

| Segment | CLV Range | Strategy |
|---------|-----------|----------|
| **Enterprise** | $5,000+ | Premium support, dedicated account management |
| **VIP** | $2,000-4,999 | Loyalty programs, exclusive access |
| **Premium** | $500-1,999 | Regular offers, personalized marketing |
| **Standard** | $1-499 | Retention campaigns, upsell opportunities |
| **Inactive** | $0 | Win-back campaigns, survey feedback |

---

## 5. Revenue Analytics

### Metrics

**Gross Revenue**
```
Gross Revenue = SUM(total_amount)
```

**Net Revenue** (After Discounts)
```
Net Revenue = Gross Revenue - Discounts
```

**Month-over-Month Growth**
```
MoM Growth (%) = ((Current Month - Previous Month) / Previous Month) × 100
```

**Revenue Per Customer**
```
Revenue Per Customer = Total Revenue / Unique Customers
```

### Business Interpretation
- **Growth > 20% MoM**: Excellent growth trajectory
- **Growth 10-20% MoM**: Healthy growth
- **Growth 0-10% MoM**: Plateauing or maturing market
- **Growth < 0% MoM**: Decline - investigate cause

---

## 6. Product Performance

### Metrics

**Profit Margin**
```
Profit Margin (%) = ((Revenue - Cost) / Revenue) × 100
```

**Performance Tier**
```
Tier Classification = Revenue / MAX(Revenue) × 100
- Top 50%: Top Performer
- 25-50%: Strong
- <25%: Moderate/No Sales
```

**Inventory Efficiency**
```
Times Sold = COUNT(orders selling this product)
Avg Qty Per Order = AVG(quantity per order)
```

---

## 7. Temporal/Seasonal Analysis

### Seasonal Index

```
Seasonal Index = (Daily Revenue / Average Daily Revenue)
```

**Interpretation**
- **Index = 1.0**: Average day
- **Index > 1.0**: Above average (e.g., 1.5 = 50% above average)
- **Index < 1.0**: Below average (e.g., 0.7 = 30% below average)

**Seasonal Patterns**
- **High-Index Days**: Promotion/sale days, holidays, paydays
- **Low-Index Days**: Weekends (if B2B), quiet periods

---

## 8. Customer Journey

### Funnel Stages

```
Prospect → Visitor → Browser → Searcher → Cart Abandoner → Customer
```

**Conversion Rates**
```
Page View → Purchase = (Purchases / Page Views) × 100
Add to Cart → Purchase = (Purchases / Cart Adds) × 100
```

**Journey Stage Logic**
```
IF actual_purchases > 0 → "Customer"
ELSE IF add_to_cart > 0 → "Cart Abandoner"
ELSE IF search > 0 → "Searcher"
ELSE IF page_views > 0 → "Browser"
ELSE IF engaged → "Visitor"
ELSE → "Prospect"
```

---

## 9. Subscription Metrics

### Monthly Recurring Revenue (MRR)

```
MRR = SUM(billing_amount) for monthly plans
      + SUM(billing_amount / 3) for quarterly plans
      + SUM(billing_amount / 12) for annual plans
```

**Example Calculation**
- 100 monthly plans @ $50 = $5,000
- 50 annual plans @ $600 = $2,500 (÷12 = $208.33/month)
- **Total MRR** = $7,208.33

### Subscription Health
- **Secure**: Active + Auto-Renew = True
- **At Risk**: Active + Auto-Renew = False
- **Paused**: Status = Paused
- **Cancelled**: Status = Cancelled
- **Expired**: Status = Expired

---

## 10. Device Analysis

### Device Performance

```
Conversion by Device = (Purchases / Events) × 100
Revenue per Device = SUM(revenue) / COUNT(users)
```

**Strategy Implications**
- If mobile revenue > 50%: Invest in mobile experience
- If desktop conversion > mobile: Optimize mobile checkout

---

## 11. Customer Acquisition Cost (CAC)

### CAC Payback

```
CAC = $50 (estimated - adjust based on actual spend)
Profit per Order = Order Value × Profit Margin (assumed 30%)
Payback Period (Days) = CAC / (Profit per Order × Orders per Year / 365)
```

### ROI Calculation

```
ROI (%) = ((Lifetime Value - CAC) / CAC) × 100
```

**Interpretation**
- **ROI > 300%**: Excellent acquisition
- **ROI 200-300%**: Good acquisition
- **ROI 100-200%**: Acceptable
- **ROI < 100%**: Poor ROI - reduce spending

---

## 12. Cross-Sell Analysis

### Co-Purchase Rate

```
Co-Purchase Rate (%) = (Orders with Product A AND Product B) / Total Orders × 100
```

**Minimum Threshold**: Minimum 5 co-purchases to include in recommendations

**Recommendation Type**
- **Up-sell**: Same category (electronics + electronics)
- **Cross-sell**: Different categories (electronics + accessories)

---

## 13. Geographic Analysis

### Market Tier Classification

```
Tier 1 (Large): 500+ customers
Tier 2 (Medium): 100-499 customers
Tier 3 (Small): 20-99 customers
Tier 4 (Emerging): <20 customers
```

### Strategic Focus

```
IF revenue_per_customer > AVG AND customer_count < 1000
  → "High Growth Potential"
ELSE IF revenue_per_customer < AVG AND customer_count >= 500
  → "Scale Opportunity"
ELSE
  → "Maintain"
```

---

## 14. Payment Analysis

### Failure Rate

```
Failure Rate (%) = (Cancelled + Refunded Orders) / Total Orders × 100
```

**Risk Levels**
- < 2%: Normal fraud/returns
- 2-5%: Monitor for issues
- > 5%: Investigate payment method issues

---

## 15. Customer Tier Performance

### Tier Health Status

```
Active Customers / Total Customers >= 90% → "Excellent"
Active Customers / Total Customers >= 70% → "Good"
Active Customers / Total Customers >= 50% → "Fair"
Active Customers / Total Customers < 50% → "Poor"
```

---

## 16. Inventory Turnover

### Turnover Rate

```
Annual Turnover = (Units Sold / Average Stock) × (365 / Days Since Last Sale)
```

### Stock Status

```
Out of Stock: Quantity = 0
Low Stock - Reorder: Quantity < 50 AND sold > 0
Dead Stock: No sales > 180 days
Slow Moving: No sales > 90 days
Fast Moving: 20+ times sold
Normal: Everything else
```

---

## 17. Advanced Cohort Revenue

### Cumulative Revenue

```
Cumulative Revenue (Month N) = SUM(Revenue) from Month 0 to Month N
```

**Example**
- 2024-01 Cohort Month 0: $50,000
- 2024-01 Cohort Month 1: $45,000
- 2024-01 Cohort Cumulative (Month 1): $95,000

---

## Key Formulas Reference

| Metric | Formula |
|--------|----------|
| **Retention Rate** | (Returning / Cohort Size) × 100 |
| **Churn Rate** | (Churned / Total) × 100 |
| **CLV** | Total Spend or Projected Annual × 2 |
| **Revenue Growth** | ((Current - Previous) / Previous) × 100 |
| **Profit Margin** | ((Revenue - Cost) / Revenue) × 100 |
| **Conversion Rate** | (Conversions / Visitors) × 100 |
| **CAC** | Total Marketing Spend / New Customers |
| **ROI** | ((Revenue - Cost) / Cost) × 100 |
| **MRR** | Sum of monthly recurring subscriptions |
| **LTV:CAC Ratio** | Lifetime Value / Customer Acquisition Cost |

---

## Industry Benchmarks

### SaaS Industry
- **Retention (Year 1)**: 80-90%
- **Churn Rate**: 5-10% monthly
- **CAC Payback**: 6-12 months
- **Magic Number**: (Revenue Month N - Revenue Month N-1) / CAC Spend = 0.75+
- **LTV:CAC Ratio**: 3:1 or higher

### E-commerce
- **Repeat Purchase Rate**: 20-40%
- **Customer Acquisition Cost**: $10-100
- **Average Order Value**: $50-200
- **Profit Margin**: 20-40%
- **Revenue per Customer**: $100-500

---

**Last Updated**: 2026-09-09