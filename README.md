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

## 🚀 Quick Start

### Prerequisites

```
✓ MySQL 5.7+ or PostgreSQL 11+
✓ 1 GB disk space (for sample data)
✓ SQL client (MySQL Workbench, DBeaver, or CLI)
✓ Basic SQL knowledge
```

### 1️⃣ Clone Repository

```bash
git clone https://github.com/Rubi-Kumari/customer-analytics-dashboard.git
cd customer-analytics-dashboard
```

### 2️⃣ Create Database

```bash
mysql -u root -p
CREATE DATABASE customer_analytics;
USE customer_analytics;
EXIT;
```

### 3️⃣ Load Schema

```bash
mysql -u root -p customer_analytics < schema/01_create_tables.sql
mysql -u root -p customer_analytics < schema/02_sample_data.sql
mysql -u root -p customer_analytics < schema/03_indexes.sql
```

### 4️⃣ Verify Setup

```bash
mysql -u root -p customer_analytics -e "SELECT COUNT(*) as customers FROM customers;"
# Expected: ~10000
```

### 5️⃣ Run First Query

```bash
mysql -u root -p customer_analytics < queries/01_customer_segmentation.sql
```

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

## 🎓 Learning Outcomes

By working through this project, you'll master:

### SQL Skills
✅ Advanced SQL (CTEs, window functions, aggregations)  
✅ Complex joins and subqueries  
✅ Query optimization and indexing  
✅ Performance tuning with EXPLAIN  
✅ Date/time calculations and window functions  

### Data Analysis Skills
✅ Cohort analysis and retention metrics  
✅ Customer segmentation and RFM analysis  
✅ Churn prediction and risk scoring  
✅ Lifetime value calculations  
✅ Revenue forecasting and trend analysis  

### Business Analytics Skills
✅ Customer acquisition cost (CAC) analysis  
✅ Return on investment (ROI) calculations  
✅ Product performance evaluation  
✅ Geographic and demographic analysis  
✅ SaaS and subscription metrics  

### Practical Skills
✅ Database design and normalization  
✅ Data quality and validation  
✅ Performance optimization  
✅ Dashboard creation  
✅ Automated reporting  

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

## 🔧 Advanced Usage

### Connect to BI Tools

**Tableau**
```
Server: localhost
Port: 3306
Database: customer_analytics
```

**Power BI**
- Connect to MySQL Database
- Load query results as tables
- Create visualizations and dashboards

**Excel**
- Data → From Database → MySQL
- Export query results to CSV
- Create pivot tables and charts

### Schedule Automated Reports

**Linux/Mac Crontab**
```bash
# Daily at 2 AM
0 2 * * * mysql -u root -p customer_analytics < queries/01_customer_segmentation.sql
```

**Windows Task Scheduler**
1. Create task
2. Trigger: Daily at 2:00 AM
3. Action: Run mysql.exe with query path
4. Save

### Export Results

```bash
# To CSV
mysql -u root -p customer_analytics \
  -e "SELECT * FROM customers;" > customers.csv

# To Excel (then open in Excel)
mysql -u root -p customer_analytics \
  -e "SELECT * FROM orders;" > orders.xlsx
```

---

## 📈 Real-World Applications

### SaaS Company
- 📊 Track MRR and churn by plan
- 📊 Cohort analysis for product improvements
- 📊 CAC payback period analysis
- 📊 Subscription health dashboard

### E-Commerce Business
- 📊 Product performance analysis
- 📊 Customer segmentation for personalization
- 📊 Geographic expansion strategy
- 📊 Seasonal demand forecasting
- 📊 Cross-sell recommendations

### Subscription Box Service
- 📊 Retention by cohort
- 📊 Customer lifetime value optimization
- 📊 Churn prediction and prevention
- 📊 Geographic market sizing

### Mobile App Business
- 📊 Device platform analysis
- 📊 User engagement funnels
- 📊 In-app purchase performance
- 📊 Regional user acquisition

---

## 📋 Verification Checklist

After setup, verify everything works:

```
✅ Database created (customer_analytics)
✅ All 6 tables created
✅ ~10,000 customers loaded
✅ ~50,000 orders loaded
✅ ~100,000 events loaded
✅ Query 1 returns customer segments
✅ Query 5 shows revenue trends
✅ Query 15 shows tier analysis
✅ Can export results to CSV
✅ Performance acceptable (<10 sec/query)
```

👉 **Detailed checklist in [HOW_TO_CHECK.md](docs/HOW_TO_CHECK.md)**

---

## 🎯 Use Cases & Industries

✅ **SaaS Platforms** - Subscription tracking, churn analysis, MRR forecasting  
✅ **E-Commerce** - Product performance, customer segmentation, seasonal trends  
✅ **Digital Marketing** - CAC analysis, ROI calculation, channel optimization  
✅ **Retail** - Inventory management, geographic expansion, customer tiers  
✅ **Fintech** - Customer lifecycle, profitability analysis, risk scoring  
✅ **Healthcare SaaS** - Patient cohort analysis, retention curves, LTV  
✅ **EdTech** - Enrollment trends, student retention, course performance  
✅ **Gaming** - Player segmentation, retention funnels, revenue trends  

---

## 📈 Expected Data Volumes

After full setup:

| Table | Records | Size |
|-------|---------|------|
| customers | 10,000 | 50 MB |
| orders | 50,000 | 150 MB |
| order_items | 40,000 | 120 MB |
| products | 100 | <1 MB |
| customer_events | 100,000 | 250 MB |
| subscriptions | 15,000 | 50 MB |
| **TOTAL** | **215,100** | **~620 MB** |

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

## 🤝 Contributing

This project is open for contributions:

- ✏️ Suggest new queries
- 🐛 Report issues
- 📝 Improve documentation
- 🎨 Add visualizations
- 🚀 Performance optimizations

---

## 📞 Support & Help

### Getting Help

1. **Setup Issues**: Check [SETUP.md](docs/SETUP.md)
2. **Verification Problems**: Follow [HOW_TO_CHECK.md](docs/HOW_TO_CHECK.md)
3. **Query Questions**: Review [QUERIES.md](docs/QUERIES.md)
4. **Business Logic**: See [BUSINESS_LOGIC.md](docs/BUSINESS_LOGIC.md)

### Common Issues

**Q: Data won't load?**
- Verify database exists: `SHOW DATABASES;`
- Check permissions: `SHOW GRANTS FOR 'root'@'localhost';`

**Q: Queries run slow?**
- Ensure indexes are created: `SHOW INDEXES FROM orders;`
- Add date filters for large date ranges
- Run `ANALYZE TABLE` to update statistics

**Q: Can't connect to database?**
- Verify MySQL service is running
- Check credentials (user, password, host)
- Ensure database exists

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

## 📜 License

This project is open source and available under the MIT License. See [LICENSE](LICENSE) file for details.

---

## 🎉 Getting Started Now

```bash
# 1. Clone
git clone https://github.com/Rubi-Kumari/customer-analytics-dashboard.git

# 2. Setup (see SETUP.md)
cd customer-analytics-dashboard

# 3. Load data
mysql -u root -p customer_analytics < schema/01_create_tables.sql
mysql -u root -p customer_analytics < schema/02_sample_data.sql

# 4. Run queries
mysql -u root -p customer_analytics < queries/01_customer_segmentation.sql

# 5. Celebrate! 🎉
```

---

## 📞 Questions?

- 📖 Read the [docs/](docs/) folder
- 🔍 Check [HOW_TO_CHECK.md](docs/HOW_TO_CHECK.md) for verification
- 💬 Review query examples in [QUERIES.md](docs/QUERIES.md)
- 📚 Understand methodology in [BUSINESS_LOGIC.md](docs/BUSINESS_LOGIC.md)

---

## 🌟 Star This Project!

If you find this project useful for learning or your business, please ⭐ it on GitHub!

---

**Last Updated**: September 9, 2026  
**Status**: ✅ Production Ready  
**Maintainer**: [Rubi-Kumari](https://github.com/Rubi-Kumari)

---

<div align="center">

### 🚀 Ready to analyze customer data like a pro?

**[Start with SETUP.md →](docs/SETUP.md)**

</div>