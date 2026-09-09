# SQL Queries Documentation

## Query Overview

This project includes 17 production-ready SQL queries covering all major aspects of customer analytics. Each query is optimized for performance and includes business context.

---

## Query List & Business Value

### 1. **Customer Segmentation (RFM Analysis)**
**File**: `queries/01_customer_segmentation.sql`
**Purpose**: Segment customers based on Recency, Frequency, and Monetary value
**Output**: Customer segments (Champions, Loyal, At Risk, Lost, etc.)
**Business Use Cases**:
- Identify VIP customers for retention programs
- Flag at-risk customers for intervention
- Personalize marketing by segment
- Allocate customer success resources

**Key Metrics**:
- RFM Score (0-555)
- Customer Segment
- Days since purchase
- Purchase frequency
- Total spent

---

### 2. **Cohort Retention Analysis**
**File**: `queries/02_cohort_analysis.sql`
**Purpose**: Track customer retention by signup cohort over time
**Output**: Monthly retention rates by acquisition month
**Business Use Cases**:
- Measure product-market fit
- Compare marketing campaign effectiveness
- Forecast lifetime value
- Identify retention trends

**Key Metrics**:
- Cohort size
- Month-over-month retention rates (%)
- Retention curve
- Returning customers count

---

### 3. **Churn Prediction Signals**
**File**: `queries/03_churn_analysis.sql`
**Purpose**: Identify customers at high risk of churning
**Output**: Churn risk scores and categories (CRITICAL, HIGH, MEDIUM, LOW)
**Business Use Cases**:
- Trigger retention campaigns
- Win-back email sequences
- Offer discounts to at-risk customers
- Proactive customer success outreach

**Key Metrics**:
- Churn risk score (0-100)
- Days since last purchase
- Spending trend (30 vs 90 days)
- Risk category

---

### 4. **Customer Lifetime Value (CLV)**
**File**: `queries/04_lifetime_value.sql`
**Purpose**: Calculate historical and projected CLV
**Output**: CLV segments and 2-year projections
**Business Use Cases**:
- Determine customer profitability
- Set marketing acquisition budgets
- Identify expansion opportunities
- Forecast revenue

**Key Metrics**:
- Historical CLV
- Projected 2-year CLV
- Annual value estimate
- CLV segment (Enterprise, VIP, Premium, Standard)
- Average order value
- Purchase cycle

---

### 5. **Revenue Analytics & Trends**
**File**: `queries/05_revenue_analytics.sql`
**Purpose**: Analyze revenue trends, growth, and patterns
**Output**: Monthly revenue metrics with growth calculations
**Business Use Cases**:
- Revenue forecasting
- Growth tracking
- Seasonal pattern identification
- Executive dashboarding

**Key Metrics**:
- Gross revenue
- Net revenue (after discounts)
- Month-over-month growth (%)
- Average order value
- Revenue per customer

---

### 6. **Product Performance Analysis**
**File**: `queries/06_product_analysis.sql`
**Purpose**: Analyze product sales, margins, and performance
**Output**: Product rankings by revenue and profit
**Business Use Cases**:
- Inventory management
- Pricing decisions
- Promotion strategy
- Product discontinuation
- Cross-sell opportunities

**Key Metrics**:
- Total revenue per product
- Profit and profit margin (%)
- Units sold and frequency
- Average revenue per order
- Performance tier (Top Performer, Strong, Moderate, No Sales)

---

### 7. **Temporal & Seasonal Analysis**
**File**: `queries/07_temporal_analysis.sql`
**Purpose**: Identify daily, weekly, and seasonal patterns
**Output**: Daily metrics with seasonal indexes
**Business Use Cases**:
- Demand forecasting
- Marketing timing optimization
- Inventory planning
- Staffing decisions
- Campaign scheduling

**Key Metrics**:
- Daily/weekly/monthly order counts
- Seasonal index (compared to average)
- Day of week performance
- Revenue per customer by period

---

### 8. **Customer Journey & Engagement**
**File**: `queries/08_customer_journey.sql`
**Purpose**: Track customer interactions across touchpoints
**Output**: Journey stage and conversion metrics
**Business Use Cases**:
- Conversion funnel optimization
- Engagement tracking
- Cart abandonment recovery
- User segmentation
- Email targeting

**Key Metrics**:
- Page views, searches, cart additions
- Conversion rates (page view → purchase, cart → purchase)
- Journey stage (Customer, Cart Abandoner, Searcher, Browser, Visitor)
- Engagement status

---

### 9. **Subscription & MRR Analysis**
**File**: `queries/09_subscription_analysis.sql`
**Purpose**: Analyze subscription performance and recurring revenue
**Output**: Subscription metrics and Monthly Recurring Revenue
**Business Use Cases**:
- SaaS metrics tracking
- Revenue predictability
- Subscription health monitoring
- Churn prevention
- Upgrade/downgrade analysis

**Key Metrics**:
- Monthly Recurring Revenue (MRR)
- Lifetime Subscription Value
- Subscription duration
- Subscription health status
- Renewal rate

---

### 10. **Device & Platform Engagement**
**File**: `queries/10_device_platform_analysis.sql`
**Purpose**: Analyze engagement by device type
**Output**: Device-specific metrics and engagement
**Business Use Cases**:
- Mobile vs desktop optimization
- App vs web strategy
- Device-specific campaigns
- Conversion optimization

**Key Metrics**:
- Events per device type
- Conversion rates by device
- Purchase value by device
- User distribution (%)

---

### 11. **Customer Acquisition Cost (CAC) & ROI**
**File**: `queries/11_customer_acquisition_cost.sql`
**Purpose**: Calculate acquisition efficiency and payback period
**Output**: CAC metrics and ROI for each customer
**Business Use Cases**:
- Marketing budget optimization
- Channel ROI analysis
- Payback period tracking
- Acquisition strategy evaluation

**Key Metrics**:
- Estimated CAC payback period (days)
- ROI (%) calculation
- CAC efficiency rating
- Lifetime value to CAC ratio

---

### 12. **Cross-Sell & Up-Sell Opportunities**
**File**: `queries/12_cross_sell_opportunity.sql`
**Purpose**: Identify products frequently bought together
**Output**: Product pairs with co-purchase rates
**Business Use Cases**:
- Product bundling
- Recommendation engine
- Upsell campaigns
- Product placement strategy

**Key Metrics**:
- Co-purchase frequency
- Co-purchase rate (%)
- Recommendation type (Up-sell vs Cross-sell)

---

### 13. **Geographic Market Analysis**
**File**: `queries/13_geographic_analysis.sql`
**Purpose**: Analyze customer base and sales by location
**Output**: Regional performance and strategic recommendations
**Business Use Cases**:
- Regional expansion strategy
- Localization decisions
- Market sizing
- Regional marketing budgets

**Key Metrics**:
- Revenue by region/city
- Customer concentration
- Revenue per customer by region
- Market tier classification

---

### 14. **Payment Method & Fraud Analysis**
**File**: `queries/14_payment_method_analysis.sql`
**Purpose**: Analyze payment patterns and transaction health
**Output**: Payment method performance and failure rates
**Business Use Cases**:
- Payment method optimization
- Fraud detection
- Payment processor selection
- Checkout optimization

**Key Metrics**:
- Transaction count by payment method
- Failure/refund rates
- Average transaction value
- Customer preference distribution

---

### 15. **Customer Tier Performance**
**File**: `queries/15_customer_tier_analysis.sql`
**Purpose**: Analyze performance by customer tier
**Output**: Tier-specific metrics and health status
**Business Use Cases**:
- VIP program management
- Tier promotion strategy
- Customer success allocation
- Service level decisions

**Key Metrics**:
- Tier size and revenue contribution (%)
- Average customer value per tier
- Tier health status
- Churn rate by tier

---

### 16. **Inventory Turnover & Stock Health**
**File**: `queries/16_inventory_performance.sql`
**Purpose**: Track inventory performance and stock movements
**Output**: Stock status and turnover rates
**Business Use Cases**:
- Inventory optimization
- Reorder decisions
- Dead stock identification
- Supply chain planning

**Key Metrics**:
- Annual turnover rate
- Stock quantity and status
- Days since last sale
- Reorder recommendations

---

### 17. **Advanced Cohort Revenue Analysis**
**File**: `queries/17_advanced_cohort_revenue.sql`
**Purpose**: Revenue progression by signup cohort
**Output**: Cumulative revenue by cohort and month
**Business Use Cases**:
- Cohort profitability analysis
- Growth pattern identification
- Lifetime value projection
- Marketing effectiveness

**Key Metrics**:
- Monthly revenue by cohort
- Cumulative revenue progression
- Cohort-to-cohort comparison

---

## How to Run Queries

### Option 1: Command Line
```bash
mysql -u root -p customer_analytics < queries/01_customer_segmentation.sql
```

### Option 2: SQL Client (MySQL Workbench, DBeaver, pgAdmin)
1. Connect to `customer_analytics` database
2. Open query file
3. Execute (Ctrl+Enter or Command+Enter)

### Option 3: Scheduled Execution
```bash
# Add to crontab for daily execution at 2 AM
0 2 * * * mysql -u root -p customer_analytics < queries/01_customer_segmentation.sql > /logs/query_output.log
```

---

## Expected Results & Sample Output

### Query 1 - RFM Segmentation (Sample Row)
```
customer_id: 1234
customer_name: John Doe
email: john@example.com
days_since_purchase: 15
purchase_frequency: 8
total_monetary_value: 2500.00
avg_order_value: 312.50
r_score: 5 (Most Recent)
f_score: 4 (Frequent)
m_score: 5 (High Spender)
rfm_score: 545
customer_segment: Champions
```

### Query 2 - Cohort Retention (Sample Row)
```
signup_cohort: 2024-01
cohort_size: 500
months_since_signup: 3
returning_customers: 325
retention_rate_percent: 65.00
```

---

## Performance Tips

1. **Use LIMIT for testing**: Start with `LIMIT 100` to test queries
2. **Check indexes**: Ensure `schema/03_indexes.sql` is executed
3. **Time-based filtering**: Add date filters for large date ranges
4. **Export results**: Use `INTO OUTFILE` for large datasets
5. **Schedule during off-peak**: Run heavy queries at night

---

## Troubleshooting

### Query Runs Slow
- Check indexes: `SHOW INDEXES FROM [table_name];`
- Add time filters: `WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 90 DAY)`
- Run `ANALYZE TABLE` to update statistics

### No Results
- Verify data exists: `SELECT COUNT(*) FROM orders;`
- Check date ranges in WHERE clause
- Ensure joins are correct

### Memory Issues
- Reduce data range
- Add LIMIT clause
- Run one query at a time

---

## Integration with BI Tools

### Tableau
```
Server: localhost
Port: 3306
Database: customer_analytics
Username: [your_user]
Password: [your_password]
Query: SELECT * FROM [query_result_table]
```

### Power BI
1. Get Data → MySQL Database
2. Connect to `customer_analytics`
3. Load query results
4. Create visualizations

### Excel
```
1. Data → From Database → MySQL
2. Connect & authenticate
3. Select query output table
4. Create pivot tables & charts
```

---

## Next Steps

1. ✅ Run all schema files (SETUP.md)
2. ✅ Execute one query to verify setup
3. ✅ Modify WHERE clauses for your date range
4. ✅ Export results to CSV
5. ✅ Visualize in BI tool
6. ✅ Create dashboards
7. ✅ Schedule automated reports

---

**Last Updated**: 2026-09-09
**Status**: Production Ready