-- Check for order items with no matching order
SELECT *
FROM olist_order_items oi
WHERE NOT EXISTS (SELECT 1
				   FROM olist_orders o
				   	WHERE o.order_id = oi.order_id);
					   
-- Check for order payments with no matching order
SELECT *
FROM olist_order_payments op
WHERE NOT EXISTS (SELECT 1
				   FROM olist_orders o
				   	WHERE o.order_id = op.order_id);

--Check for order reviews with no matching order
SELECT *
FROM olist_order_reviews ore
WHERE NOT EXISTS (SELECT 1
				   FROM olist_orders o
				   	WHERE o.order_id = ore.order_id);

--Checking for order items with no matching product
SELECT *
FROM olist_order_items oi
WHERE NOT EXISTS (SELECT 1
				  FROM olist_products op
				  WHERE op.product_id = oi.product_id);

--Checking for order items with no matching seller
SELECT *
FROM olist_order_items oi
WHERE NOT EXISTS (SELECT 1 
				  FROM olist_sellers os
				  WHERE os.seller_id = oi.seller_id);

--Checking products list with no english match in product category 
SELECT *
FROM olist_products op
WHERE op.product_category_name IS NOT NULL AND NOT EXISTS (SELECT 1 
				  FROM olist_product_categories opc
				  WHERE opc.product_category_name = op.product_category_name);
--Check found 13 products across two untranslated categories.

--Checking for customer lists with no matching customers 
SELECT *
FROM olist_orders o
WHERE NOT EXISTS (SELECT 1
				  FROM olist_customers c
				  WHERE c.customer_id = o.customer_id);