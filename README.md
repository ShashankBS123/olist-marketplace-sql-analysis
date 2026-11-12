# Marketplace Operations and Customer Experience Analysis

## Business question
How do order volume, delivery performance, payment behavior, and customer reviews vary over time and across products and sellers?

## Tools
PostgreSQL and SQL

## Data source
Olist’s [Brazilian E-Commerce dataset on Kaggle] (https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

**License:** CC BY-NC-SA 4.0

The raw CSV files are not included in this repository. Download them from the linked Kaggle source.

## Data overview
This project analyzes about 100,000 anonymized orders from 2016–2018 using eight related CSV tables. The geolocation table was excluded to keep the analysis focused.

## How to run
1. Download the dataset from [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) and extract the eight CSV files listed below into a local `data/raw/` folder. The CSV files are not included in this repository.
2. In PostgreSQL, create a database named `olist_ecommerce` and connect to it in pgAdmin.
3. Open and run `sql/01_create_tables.sql` in pgAdmin’s Query Tool.
4. Import each CSV into its matching table using pgAdmin’s Import/Export Data tool. Use CSV format, enable **Header**, set the delimiter to a comma, and select UTF8 encoding.
5. Run `sql/02_relationship_checks.sql` to check table relationships, then run `sql/03_business_analysis.sql` to view the analysis.

| CSV file | PostgreSQL table |
|---|---|
| `olist_orders_dataset.csv` | `olist_orders` |
| `olist_customers_dataset.csv` | `olist_customers` |
| `olist_order_items_dataset.csv` | `olist_order_items` |
| `olist_order_payments_dataset.csv` | `olist_order_payments` |
| `olist_order_reviews_dataset.csv` | `olist_order_reviews` |
| `olist_products_dataset.csv` | `olist_products` |
| `olist_sellers_dataset.csv` | `olist_sellers` |
| `product_category_name_translation.csv` | `olist_product_categories` |

## SQL topics
Joins, CTEs, subqueries, aggregations, window functions, and date analysis

## Key findings
- 96,478 of 99,441 orders were delivered—about 97%.
- Delivered item revenue peaked in November 2017 at 987,765.37, excluding freight.
- `health_beauty` had the highest delivered item revenue: 1,233,131.72.
- Average review scores were 4.29 for delivered orders arriving on or before the estimate and 2.27 for late deliveries. This is an association, not proof that lateness caused lower scores.

## Data limitations
- Some product categories have no English translation; products with no category value appear as Uncategorized.
- The dataset has incomplete first and last months, so those months aren’t directly comparable with full months.
- Review-score averages are per review row, and some orders have multiple review rows.

## Project status
Completed
