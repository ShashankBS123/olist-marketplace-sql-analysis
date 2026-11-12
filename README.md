# Marketplace Operations and Customer Experience Analysis

## Business question
How do order volume, delivery performance, payment behavior, and customer reviews vary over time and across products and sellers?

## Tools
PostgreSQL and SQL

## Data source
Olist’s [Brazilian E-Commerce dataset on Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
**License:** CC BY-NC-SA 4.0
The raw CSV files are not included in this repository. Download them from the linked Kaggle source.

## Data overview
An anonymized marketplace dataset with about 100,000 orders from 2016–2018 and related CSV tables. We’ll use the core tables and skip the large geolocation file to keep the project moving.

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
