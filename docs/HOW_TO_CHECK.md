# How to Check/Verify Your Project Setup

Complete step-by-step guide to verify everything is working correctly.

---

## ✅ Step 1: Verify Repository Creation

### Check on GitHub
1. Go to: https://github.com/Rubi-Kumari/customer-analytics-dashboard
2. Verify you see:
   - ✅ README.md file
   - ✅ `schema/` folder with 3 SQL files
   - ✅ `queries/` folder with 17 SQL files
   - ✅ `docs/` folder with documentation
   - ✅ Latest commits showing files added

### Clone to Your Computer
```bash
git clone https://github.com/Rubi-Kumari/customer-analytics-dashboard.git
cd customer-analytics-dashboard
ls -la  # View all files
```

---

## ✅ Step 2: Verify Database Setup

### Step 2a: Create Database
```bash
mysql -u root -p
```

```sql
CREATE DATABASE customer_analytics;
USE customer_analytics;
SHOW DATABASES;  -- Verify customer_analytics appears
```

### Step 2b: Create Tables
```bash
mysql -u root -p customer_analytics < schema/01_create_tables.sql
```

### Verify Tables Created
```sql
USE customer_analytics;
SHOW TABLES;
```

**Expected Output:**
```
+--------------------------------+
| Tables_in_customer_analytics   |
+--------------------------------+
| customers                      |
| customer_events                |
| order_items                    |
| orders                         |
| products                       |
| subscriptions                  |
+--------------------------------+
```

### Check Table Structure
```sql
DESCRIBE customers;
DESCRIBE orders;
DESCRIBE products;
```

---

## ✅ Step 3: Load Sample Data

### Load Data
```bash
mysql -u root -p customer_analytics < schema/02_sample_data.sql
```

### Verify Data Loaded
```sql
USE customer_analytics;

-- Check customer count
SELECT COUNT(*) as customer_count FROM customers;
-- Expected: ~10,000

-- Check product count
SELECT COUNT(*) as product_count FROM products;
-- Expected: ~100

-- Check orders count
SELECT COUNT(*) as order_count FROM orders;
-- Expected: ~50,000

-- Check order items
SELECT COUNT(*) as items_count FROM order_items;
-- Expected: ~40,000-50,000

-- Check events
SELECT COUNT(*) as events_count FROM customer_events;
-- Expected: ~100,000

-- Check subscriptions
SELECT COUNT(*) as subscription_count FROM subscriptions;
-- Expected: ~15,000
```

### Sample Data Check (View a Few Rows)
```sql
-- View sample customers
SELECT * FROM customers LIMIT 5;

-- View sample orders
SELECT * FROM orders LIMIT 5;

-- View sample events
SELECT * FROM customer_events LIMIT 5;
```

---

## ✅ Step 4: Create Indexes

### Create Indexes
```bash
mysql -u root -p customer_analytics < schema/03_indexes.sql
```

### Verify Indexes Created
```sql
SHOW INDEXES FROM customers;
SHOW INDEXES FROM orders;
SHOW INDEXES FROM customer_events;
```

**You should see multiple indexes listed for each table**

---

## ✅ Step 5: Test Individual Queries

### Query 1: Customer Segmentation
```bash
mysql -u root -p customer_analytics < queries/01_customer_segmentation.sql
```

**Expected Result:**
- 100-1000 rows of customer data
- Columns: customer_id, name, email, RFM scores, segment
- Segments: Champions, Loyal Customers, At Risk, etc.

### Query 2: Cohort Retention
```bash
mysql -u root -p customer_analytics < queries/02_cohort_analysis.sql
```

**Expected Result:**
- Multiple rows by signup cohort (2024-01, 2024-02, etc.)
- Columns: signup_cohort, cohort_size, retention_rate_percent
- Retention rates should be 50-100%

### Query 3: Churn Analysis
```bash
mysql -u root -p customer_analytics < queries/03_churn_analysis.sql
```

**Expected Result:**
- Customers sorted by churn risk score
- Columns: customer_id, churn_risk_score, churn_risk_category
- Categories: CRITICAL, HIGH, MEDIUM, LOW

### Query 4: Lifetime Value
```bash
mysql -u root -p customer_analytics < queries/04_lifetime_value.sql
```

**Expected Result:**
- Top customers by CLV
- Columns: customer_id, historical_clv, projected_clv_2yr, clv_segment
- Segments: Enterprise, VIP, Premium, Standard

### Quick Test All Queries
```bash
# Run all queries one by one
for i in {1..17}; do
  echo "Running Query $i..."
  mysql -u root -p customer_analytics < queries/$(printf "%02d" $i)_*.sql
  echo "Query $i completed"
done
```

---

## ✅ Step 6: Export Results to CSV

### Export Query Results
```bash
# Method 1: Using INTO OUTFILE
mysql -u root -p customer_analytics -e \
"SELECT * FROM customers INTO OUTFILE '/tmp/customers_export.csv' 
CHARACTER SET utf8mb4 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '\"' 
LINES TERMINATED BY '\n';"
```

### Method 2: Save Query Result to CSV
```bash
mysql -u root -p customer_analytics \
  -e "SELECT * FROM customers;" > customers.csv
```

### Method 3: From SQL Client (MySQL Workbench)
1. Run query
2. Right-click results
3. Select "Export Result Set"
4. Choose CSV format
5. Save file

---

## ✅ Step 7: Verify Query Performance

### Check Query Execution Time
```sql
-- Enable query timing
SET SESSION sql_mode='STRICT_TRANS_TABLES';
SET profiling = 1;

-- Run a query
SELECT * FROM customers LIMIT 10;

-- Check execution time
SHOW PROFILES;
```

### Expected Performance
- **Simple queries**: < 1 second
- **Aggregation queries**: 1-5 seconds
- **Complex joins**: 5-15 seconds
- **MRR calculation**: < 5 seconds

### Explain Query Performance
```sql
EXPLAIN SELECT * FROM orders WHERE customer_id = 1;
-- Should show index usage
```

---

## ✅ Step 8: Connect to BI Tool

### MySQL Workbench
1. Open MySQL Workbench
2. Connection → New Connection
3. Configure:
   - Hostname: localhost
   - Port: 3306
   - Username: root
   - Password: [your password]
4. Test Connection ✓
5. Open SQL Editor
6. Paste query from `queries/` folder
7. Execute (⚡ icon)
8. View results

### DBeaver
1. File → New → Database Connection
2. Select MySQL
3. Enter connection details
4. Test connection
5. Browse database
6. Right-click → New → SQL Script
7. Paste query
8. Execute

### Tableau
1. Connect to Data → MySQL
2. Server: localhost
3. Database: customer_analytics
4. Create New Sheet
5. Drag fields to Rows/Columns
6. Create visualization

---

## ✅ Step 9: Create Your First Dashboard

### Manual Dashboard (Excel/Sheets)
1. Export results from Queries 1, 5, 6, 15
2. Create pivot tables
3. Add charts:
   - Customer Segments Pie Chart (Query 1)
   - Revenue Trend Line Chart (Query 5)
   - Product Performance Bar Chart (Query 6)
   - Tier Performance Table (Query 15)

### Automated Dashboard (Tableau/Power BI)
1. Create data source connection
2. Import query results as tables
3. Create calculations for KPIs
4. Build visualizations
5. Combine into dashboard
6. Set up auto-refresh (daily/weekly)

---

## ✅ Step 10: Schedule Automated Reports

### Linux/Mac - Crontab
```bash
# Edit cron jobs
crontab -e

# Add this line to run daily at 2 AM
0 2 * * * mysql -u root -p[password] customer_analytics < /path/to/queries/01_customer_segmentation.sql > /var/log/analytics_report_01.log 2>&1

# Run weekly on Monday at 9 AM
0 9 * * 1 mysql -u root -p[password] customer_analytics < /path/to/queries/05_revenue_analytics.sql > /var/log/analytics_report_05.log 2>&1
```

### Windows - Task Scheduler
1. Open Task Scheduler
2. Create Basic Task
3. Name: "Daily Analytics Report"
4. Trigger: Daily at 2:00 AM
5. Action: Start Program
6. Program: `mysql.exe`
7. Arguments: `-u root -p[password] customer_analytics < C:\path\queries\01_customer_segmentation.sql`

---

## ✅ Troubleshooting Checklist

### Data Not Loading?
```sql
-- Check database exists
SHOW DATABASES;

-- Check if tables exist
USE customer_analytics;
SHOW TABLES;

-- Check row counts
SELECT COUNT(*) FROM customers;
```

### Query Returns No Results?
```sql
-- Check if data exists in date range
SELECT COUNT(*) FROM orders WHERE order_date >= '2024-01-01';

-- Check NULL values
SELECT * FROM customers WHERE last_purchase_date IS NULL;
```

### Query Runs Slow?
```sql
-- Check if indexes exist
SHOW INDEXES FROM orders;

-- Analyze table
ANALYZE TABLE orders;

-- Add date filter to limit data
-- WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 90 DAY)
```

### Permission Denied Error?
```bash
# Check user permissions
mysql -u root -p
SHOW GRANTS FOR 'root'@'localhost';

# Grant all permissions if needed
GRANT ALL PRIVILEGES ON customer_analytics.* TO 'root'@'localhost';
FLUSH PRIVILEGES;
```

---

## ✅ Verification Checklist

```
[ ] Repository created on GitHub
[ ] All files visible in repository
[ ] Database created successfully
[ ] All 6 tables created
[ ] Sample data loaded (10k customers, 50k orders)
[ ] Indexes created
[ ] Query 1 returns results (100+)
[ ] Query 5 shows revenue trends
[ ] Query 15 shows tier analysis
[ ] Can export results to CSV
[ ] Can connect to MySQL Workbench
[ ] Performance acceptable (queries < 10 sec)
[ ] Created first dashboard/visualization
[ ] Scheduled automated reports
```

---

## Next Steps

1. ✅ Verify all setup steps above
2. ✅ Run all 17 queries at least once
3. ✅ Export results to CSV for analysis
4. ✅ Create visualizations in Excel or Tableau
5. ✅ Set up scheduled reports
6. ✅ Share dashboard with stakeholders
7. ✅ Use insights for business decisions
8. ✅ Customize queries for your specific metrics
9. ✅ Add new queries for additional insights
10. ✅ Integrate with BI tool for real-time monitoring

---

## Getting Help

- **SQL Syntax Issues**: [MySQL Documentation](https://dev.mysql.com/doc/)
- **Query Optimization**: Check `EXPLAIN` output
- **Data Questions**: Review [BUSINESS_LOGIC.md](BUSINESS_LOGIC.md)
- **Setup Issues**: Review [SETUP.md](SETUP.md)

---

**Status**: ✅ Setup Complete
**Last Updated**: 2026-09-09