--Creating orders table
CREATE TABLE olist_orders(
order_id TEXT PRIMARY KEY,
customer_id TEXT,
order_status TEXT,
order_purchase_timestamp TIMESTAMP,
order_approved_at TIMESTAMP,
order_delivered_carrier_date TIMESTAMP,
order_delivered_customer_date TIMESTAMP,
order_estimated_delivery_date TIMESTAMP);
SELECT COUNT(*) FROM olist_orders;

--Creating customers table
CREATE TABLE olist_customers(
customer_id TEXT PRIMARY KEY,
customer_unique_id TEXT,
customer_zip_code_prefix TEXT,
customer_city TEXT,
customer_state TEXT
);
SELECT COUNT(*) FROM olist_customers;

--Creating order items table
CREATE TABLE olist_order_items(
order_id TEXT,
order_item_id INT,
product_id TEXT,
seller_id TEXT,
shipping_limit_date TIMESTAMP,
price NUMERIC,
freight_value NUMERIC,
PRIMARY KEY (order_id, order_item_id)
);
SELECT COUNT(*) FROM olist_order_items;

--Creating order payments table
CREATE TABLE olist_order_payments(
order_id TEXT,
payment_sequential INT,
payment_type TEXT,
payment_installments INT,
payment_value NUMERIC,
PRIMARY KEY (order_id,payment_sequential)
);
SELECT COUNT(*) FROM olist_order_payments;

--Creating order reviews table 
CREATE TABLE olist_order_reviews(
review_id TEXT,
order_id TEXT,
review_score INT,
review_comment_title TEXT,
review_comment_message TEXT,
review_creation_date TIMESTAMP,
review_answer_timestamp TIMESTAMP,
PRIMARY KEY(review_id,order_id)
);
SELECT COUNT(*) FROM olist_order_reviews;

--Creating products table
CREATE TABLE olist_products(
product_id TEXT PRIMARY KEY,
product_category_name TEXT,
product_name_lenght INT,
product_description_lenght INT,
product_photos_qty INT,
product_weight_g NUMERIC,
product_length_cm NUMERIC,
product_height_cm NUMERIC,
product_width_cm NUMERIC
);
SELECT COUNT(*) FROM olist_products;

--Creating sellers table 
CREATE TABLE olist_sellers(
seller_id TEXT PRIMARY KEY,
seller_zip_code_prefix TEXT,
seller_city TEXT,
seller_state TEXT
);
SELECT COUNT(*) FROM olist_sellers;

--Creating product category translation table 
CREATE TABLE olist_product_categories(
product_category_name TEXT PRIMARY KEY,
product_category_name_english TEXT
);
SELECT COUNT(*) FROM olist_product_categories;