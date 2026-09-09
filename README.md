# 📊 Customer Analytics Dashboard

> **An industry-level SQL-based customer analytics platform** designed for data scientists and business analysts to extract actionable insights from customer data. Complete with production-ready queries, sample data, and comprehensive documentation.

![Status](https://img.shields.io/badge/status-active-brightgreen)
![License](https://img.shields.io/badge/license-MIT-blue)
![SQL](https://img.shields.io/badge/language-SQL-orange)
![Database](https://img.shields.io/badge/database-MySQL-blue)

---

## 🎯 Project Overview

This project provides a **complete, turnkey customer analytics solution** that you can deploy in any business environment. It demonstrates enterprise-level SQL skills and data science fundamentals with real-world applications.

### Why This Project?

✅ **Production-Ready** - Optimized queries, indexed tables, sample data  
✅ **Comprehensive** - 17 analytics queries covering all major business metrics  
✅ **Well-Documented** - Complete setup, query, and business logic documentation  
✅ **Scalable** - Designed to handle millions of records  
✅ **Portfolio-Ready** - Impressive for interviews and job applications  
✅ **Business-Focused** - Directly addresses real business problems  

---

## 📈 Business Value

### Key Metrics & Insights You'll Get

| Metric | Business Impact | Use Case |
|--------|-----------------|----------|
| **Customer Segmentation (RFM)** | Identify high-value customers | VIP programs, targeted marketing |
| **Churn Prediction** | Reduce customer loss | Retention campaigns, win-back offers |
| **Customer Lifetime Value** | Understand profitability | CAC budgets, expansion opportunities |
| **Cohort Retention** | Measure product-market fit | Track acquisition cohort health |
| **Revenue Trends** | Forecast growth | Executive dashboards, planning |
| **Product Performance** | Optimize inventory | Pricing, promotion, discontinuation |
| **CAC & ROI** | Marketing efficiency | Channel optimization, budget allocation |
| **Geographic Analysis** | Regional strategy | Market expansion, localization |
| **Subscription Metrics** | Recurring revenue | SaaS forecasting, growth tracking |
| **Device Analysis** | Platform optimization | Mobile vs web investment |

---

## 🗂️ Project Structure

```
customer-analytics-dashboard/
│
├── 📄 README.md                      # This file
├── 📄 LICENSE                        # Project license
│
├── 📁 schema/                        # Database schema & data generation
│   ├── 01_create_tables.sql         # Create 6 production tables
│   ├── 02_sample_data.sql           # Generate 100,000+ realistic records
│   └── 03_indexes.sql               # Optimize query performance
│
├── 📁 queries/                       # 17 production-ready SQL queries
│   ├── 01_customer_segmentation.sql
│   ├── 02_cohort_analysis.sql
│   ├── 03_churn_analysis.sql
│   ├── 04_lifetime_value.sql
│   ├── 05_revenue_analytics.sql
│   ├── 06_product_analysis.sql
│   ├── 07_temporal_analysis.sql
│   ├── 08_customer_journey.sql
│   ├── 09_subscription_analysis.sql
│   ├── 10_device_platform_analysis.sql
│   ├── 11_customer_acquisition_cost.sql
│   ├── 12_cross_sell_opportunity.sql
│   ├── 13_geographic_analysis.sql
│   ├── 14_payment_method_analysis.sql
│   ├── 15_customer_tier_analysis.sql
│   ├── 16_inventory_performance.sql
│   └── 17_advanced_cohort_revenue.sql
│
└── 📁 docs/                          # Comprehensive documentation
    ├── SETUP.md                     # Installation & setup guide
    ├── QUERIES.md                   # Query documentation (17 queries)
    ├── BUSINESS_LOGIC.md            # Formulas, methodology, benchmarks
    └── HOW_TO_CHECK.md              # Verification & testing guide
```

---

## 💾 Database Schema

### 6 Core Tables

**customers** (10,000 records)
- Customer demographics and acquisition data
- Account status and tier classification
- Lifetime value metrics

**orders** (50,000 records)
- Purchase transactions with totals
- Order status and payment methods
- Discount and shipping information

**order_items** (40,000+ records)
- Line items for each order
- Product-quantity-price details
- Item-level discounts

**products** (100 records)
- Product catalog with pricing
- Category classification
- Stock quantity tracking

**customer_events** (100,000+ records)
- Behavioral tracking (page views, clicks, purchases)
- Device and platform information
- Event values and timestamps

**subscriptions** (15,000 records)
- Recurring revenue tracking
- Plan types and billing frequency
- Subscription health status

### Data Relationships

```
customers
    ├── orders (1:Many)
    │   └── order_items (1:Many)
    │       └── products (Many:1)
    ├── subscriptions (1:Many)
    └── customer_events (1:Many)
        └── products (Many:1)
```

---

## 🔍 17 Production-Ready Queries

### 1️⃣ **Customer Segmentation (RFM Analysis)**
Segment customers into Champions, Loyal, At Risk, Lost, etc.
- **Metrics**: Recency, Frequency, Monetary value
- **Output**: Customer segments with actionable recommendations
- **Business Use**: Marketing segmentation, VIP programs

### 2️⃣ **Cohort Retention Analysis**
Track customer retention by acquisition cohort over time
- **Metrics**: Monthly retention rates, cohort size
- **Output**: Retention curves by signup month
- **Business Use**: Product-market fit measurement

### 3️⃣ **Churn Prediction Signals**
Identify customers at high risk of churning
- **Metrics**: Churn risk score (0-100), risk categories
- **Output**: At-risk customers with intervention triggers
- **Business Use**: Retention campaigns, win-back offers

### 4️⃣ **Customer Lifetime Value (CLV)**
Calculate historical and projected CLV
- **Metrics**: Historical CLV, 2-year projection, annual value
- **Output**: Customer segments by profitability
- **Business Use**: Acquisition budget, expansion strategy

### 5️⃣ **Revenue Analytics & Trends**
Analyze revenue trends and growth patterns
- **Metrics**: MoM growth, revenue per customer, AOV
- **Output**: Monthly revenue with growth calculations
- **Business Use**: Revenue forecasting, growth tracking

### 6️⃣ **Product Performance Analysis**
Evaluate product sales, margins, and performance
- **Metrics**: Revenue, profit margin, turnover rate
- **Output**: Product rankings by profitability
- **Business Use**: Pricing, inventory, promotions

### 7️⃣ **Temporal & Seasonal Analysis**
Identify daily, weekly, and seasonal patterns
- **Metrics**: Seasonal index, day-of-week performance
- **Output**: Seasonal trends with comparative analysis
- **Business Use**: Demand forecasting, campaign timing

### 8️⃣ **Customer Journey & Engagement**
Track interactions across the customer journey
- **Metrics**: Conversion rates, journey stages, funnel metrics
- **Output**: Customer funnel with stage classification
- **Business Use**: Funnel optimization, email targeting

### 9️⃣ **Subscription & MRR Analysis**
Track subscription performance and recurring revenue
- **Metrics**: MRR, subscription lifetime value, churn
- **Output**: Subscription health by plan type
- **Business Use**: SaaS metrics, revenue forecasting

### 🔟 **Device & Platform Engagement**
Analyze engagement by device type (mobile, desktop, tablet)
- **Metrics**: Conversion by device, revenue by platform
- **Output**: Device-specific performance metrics
- **Business Use**: Platform optimization, investment decisions

### 1️⃣1️⃣ **Customer Acquisition Cost (CAC) & ROI**
Calculate acquisition efficiency and payback period
- **Metrics**: CAC, payback period, ROI
- **Output**: ROI by customer with efficiency ratings
- **Business Use**: Marketing optimization, channel ROI

### 1️⃣2️⃣ **Cross-Sell & Up-Sell Opportunities**
Identify products frequently bought together
- **Metrics**: Co-purchase rate, product affinity
- **Output**: Product pairs with recommendation type
- **Business Use**: Bundling strategy, recommendations

### 1️⃣3️⃣ **Geographic Market Analysis**
Analyze customer base and sales by location
- **Metrics**: Revenue by region, market tier, growth potential
- **Output**: Regional performance with strategic focus
- **Business Use**: Market expansion, localization

### 1️⃣4️⃣ **Payment Method & Fraud Analysis**
Analyze payment patterns and transaction health
- **Metrics**: Failure rates by payment method
- **Output**: Payment method performance, fraud signals
- **Business Use**: Payment optimization, fraud detection

### 1️⃣5️⃣ **Customer Tier Performance**
Analyze performance by customer tier (Bronze, Silver, Gold, Platinum)
- **Metrics**: Tier revenue, health status, churn rate
- **Output**: Tier-specific KPIs and recommendations
- **Business Use**: VIP management, tier strategy

### 1️⃣6️⃣ **Inventory Turnover & Stock Health**
Track inventory performance and stock movements
- **Metrics**: Turnover rate, stock status
- **Output**: Stock health classification, reorder signals
- **Business Use**: Inventory optimization, supply chain

### 1️⃣7️⃣ **Advanced Cohort Revenue Analysis**
Revenue progression by signup cohort
- **Metrics**: Monthly revenue, cumulative revenue
- **Output**: Cohort revenue trends over time
- **Business Use**: Lifetime value projection, growth tracking

---

## 📚 Documentation Guide

| Document | Purpose | Who Needs It |
|----------|---------|-------------|
| **[SETUP.md](docs/SETUP.md)** | Installation & database setup | Everyone (START HERE) |
| **[QUERIES.md](docs/QUERIES.md)** | Query documentation & use cases | Data analysts, business users |
| **[BUSINESS_LOGIC.md](docs/BUSINESS_LOGIC.md)** | Formulas, methodologies, benchmarks | Data scientists, analysts |
| **[HOW_TO_CHECK.md](docs/HOW_TO_CHECK.md)** | Step-by-step verification guide | Everyone (after setup) |

### Recommended Reading Order

1. Start with: **[SETUP.md](docs/SETUP.md)** - Get everything running
2. Then read: **[HOW_TO_CHECK.md](docs/HOW_TO_CHECK.md)** - Verify everything works
3. Deep dive: **[QUERIES.md](docs/QUERIES.md)** - Understand each query
4. Advanced: **[BUSINESS_LOGIC.md](docs/BUSINESS_LOGIC.md)** - Learn the methodology

---

## 📊 Sample Insights You'll Generate

### Customer Segmentation
```
Champions: 500 customers | $2.5M revenue | High value targets
Loyal: 1,200 customers | $1.8M revenue | Upsell opportunities
At Risk: 800 customers | $600K revenue | Retention priority
Lost: 2,000 customers | $200K revenue | Win-back campaigns
```

### Cohort Retention
```
2024-01 Cohort: 1000 customers
- Month 0: 100% retained
- Month 3: 65% retained
- Month 6: 45% retained
- Year 1: 30% retained
```

### Revenue Trends
```
Monthly Revenue (MoM Growth)
Jan 2024: $250,000
Feb 2024: $287,500 (+15.0%)
Mar 2024: $345,000 (+20.0%)
Apr 2024: $380,000 (+10.1%)
```

### Product Performance
```
Top 5 Products by Revenue:
1. Wireless Earbuds: $125,000 (38% margin)
2. Mechanical Keyboard: $98,000 (42% margin)
3. Monitor Light Bar: $87,000 (45% margin)
4. Laptop Stand: $76,000 (40% margin)
5. USB-C Cable: $65,000 (52% margin)
```

---

## 🛠️ Technology Stack

| Component | Technology | Version |
|-----------|-----------|---------|
| **Database** | MySQL | 5.7+ or 8.0+ |
| **Alternative** | PostgreSQL | 11+ |
| **Language** | SQL | ANSI-2016 |
| **Client** | MySQL CLI | Any version |
| **BI Tools** | Tableau, Power BI, Looker | Any recent version |
| **Export** | CSV, Excel | Standard formats |

---

## 📊 Portfolio Highlights

This project demonstrates:

✅ **Advanced SQL** - CTEs, window functions, complex joins  
✅ **Database Design** - Normalized schema, proper relationships  
✅ **Data Modeling** - 6-table relational model with 100k+ records  
✅ **Query Optimization** - Indexed queries, EXPLAIN analysis  
✅ **Business Acumen** - Real metrics used by Fortune 500 companies  
✅ **Documentation** - Professional-grade docs  
✅ **Scalability** - Designed to handle millions of records  

**Perfect for:** Data scientist interviews, portfolio projects, skill demonstration

---

**Last Updated**: September 9, 2026  
**Status**: ✅ Production Ready  
**Maintainer**: [Rubi-Kumari](https://github.com/Rubi-Kumari)