# Setup Guide - Customer Analytics Dashboard

## Prerequisites

- MySQL 5.7+ / PostgreSQL 11+ / SQLite 3
- SQL Client (MySQL Workbench, pgAdmin, DBeaver, or CLI)
- Git (optional, for version control)

## Installation Steps

### Step 1: Create Database

```sql
CREATE DATABASE customer_analytics;
USE customer_analytics;
```

### Step 2: Create Tables

Run the schema creation script:

```bash
# For MySQL
mysql -u root -p customer_analytics < schema/01_create_tables.sql

# For PostgreSQL
psql -U postgres -d customer_analytics -f schema/01_create_tables.sql
```

### Step 3: Load Sample Data

Generate realistic sample data (100,000+ records):

```bash
mysql -u root -p customer_analytics < schema/02_sample_data.sql
```

### Step 4: Add Indexes

Optimize query performance:

```bash
mysql -u root -p customer_analytics < schema/03_indexes.sql
```

### Step 5: Verify Setup

Check if data loaded correctly:

```sql
SELECT COUNT(*) as total_customers FROM customers;
SELECT COUNT(*) as total_orders FROM orders;
SELECT COUNT(*) as total_events FROM customer_events;
```

Expected output:
- **customers**: ~10,000 records
- **orders**: ~50,000 records
- **customer_events**: ~100,000 records
- **products**: ~100 records
- **subscriptions**: ~15,000 records

## Database Schema Overview

### Tables

**customers**
- customer_id (PK)
- email, name, country, city
- signup_date, account_status
- customer_tier

**orders**
- order_id (PK)
- customer_id (FK)
- order_date, total_amount
- order_status

**order_items**
- item_id (PK)
- order_id (FK), product_id (FK)
- quantity, unit_price, total_price

**products**
- product_id (PK)
- product_name, category
- price, cost
- created_date

**customer_events**
- event_id (PK)
- customer_id (FK)
- event_type (page_view, add_to_cart, checkout, etc.)
- event_date, value

**subscriptions**
- subscription_id (PK)
- customer_id (FK)
- plan_type, billing_amount
- start_date, end_date, status

## Running Queries

### Method 1: Command Line

```bash
mysql -u root -p customer_analytics < queries/01_customer_segmentation.sql
```

### Method 2: SQL Client

1. Open your SQL client
2. Connect to `customer_analytics` database
3. Copy-paste query from `queries/` folder
4. Execute and view results

### Method 3: Scheduled Analysis

Create a cron job for daily analytics:

```bash
# Run customer segmentation daily at 2 AM
0 2 * * * mysql -u root -p customer_analytics < queries/01_customer_segmentation.sql > /var/log/customer_analytics.log
```

## Troubleshooting

### Error: "Database does not exist"
```sql
SHOW DATABASES;
-- If customer_analytics is missing, run Step 1 again
```

### Error: "Table already exists"
```sql
DROP DATABASE customer_analytics;
-- Then restart from Step 1
```

### Slow Queries
- Ensure indexes are created (Step 4)
- Check query execution plan: `EXPLAIN` keyword
- See `schema/03_indexes.sql` for optimization tips

### Memory Issues
- Reduce sample data size in `schema/02_sample_data.sql`
- Run queries during off-peak hours
- Use LIMIT clause for testing

## Database Size

After full setup:
- **Total Size**: ~500 MB - 1 GB
- **Customers Table**: ~50 MB
- **Orders Table**: ~150 MB
- **Events Table**: ~250 MB

## Next Steps

1. ✅ Run all schema files
2. ✅ Verify data loaded (see Step 5)
3. ✅ Execute sample queries from `queries/` folder
4. ✅ Review [QUERIES.md](QUERIES.md) for explanations
5. ✅ Modify queries for your use cases
6. ✅ Build visualizations from results

## Support

For issues:
1. Check [QUERIES.md](QUERIES.md) for query-specific help
2. Review [BUSINESS_LOGIC.md](BUSINESS_LOGIC.md) for methodology
3. Consult SQL documentation for syntax help
4. Verify sample data exists before troubleshooting

---

**Setup Complete!** You're ready to run analytics queries. Start with `queries/01_customer_segmentation.sql`.