--Number of orders in each order status
SELECT order_status,
	   COUNT(*) AS number_of_orders 
FROM olist_orders
GROUP BY order_status;

--Order volume in every month
SELECT TO_CHAR(order_purchase_timestamp, 'YYYY-MM') AS year_month,
		COUNT(*) AS monthly_order_count
FROM olist_orders 
GROUP BY TO_CHAR(order_purchase_timestamp, 'YYYY-MM')
ORDER BY year_month;

--Monthly revenue for delivered orders
SELECT TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM') AS year_month,
		SUM(oi.price) AS monthly_revenue
FROM olist_order_items oi
JOIN olist_orders o
	ON oi.order_id=o.order_id
WHERE o.order_status = 'delivered'
GROUP BY TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM')
ORDER BY year_month;

-- Delivered item revenue by product category
SELECT COALESCE(
        opc.product_category_name_english,
        p.product_category_name,
        'Uncategorized'
    ) AS product_category,
	   SUM(oi.price) AS total_revenue
FROM olist_orders o
JOIN olist_order_items oi
	ON o.order_id = oi.order_id
JOIN olist_products p 
	ON oi.product_id = p.product_id
LEFT JOIN olist_product_categories opc
	ON p.product_category_name = opc.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY COALESCE(
        opc.product_category_name_english,
        p.product_category_name,
        'Uncategorized'
    )
ORDER BY total_revenue DESC;

--Top 10 sellers
SELECT oi.seller_id,
		SUM(oi.price) AS total_revenue
FROM olist_orders o
JOIN olist_order_items oi
	ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY oi.seller_id
ORDER BY total_revenue DESC
LIMIT 10;

--Delivery reliablity
SELECT SUM(CASE
			WHEN order_delivered_customer_date::date = order_estimated_delivery_date::date
				THEN 1 
				ELSE 0
			END) AS delivered_on_exact_date,
		SUM(CASE
			WHEN order_delivered_customer_date::date < order_estimated_delivery_date::date
				THEN 1 
				ELSE 0
			END) AS early_delivery,
			SUM(CASE
			WHEN order_delivered_customer_date::date > order_estimated_delivery_date::date
				THEN 1 
				ELSE 0
			END) AS late_delivery
FROM olist_orders
WHERE order_delivered_customer_date IS NOT NULL 
	   AND order_estimated_delivery_date IS NOT NULL
	   AND order_status = 'delivered';

--Analyzing payment behaviour
SELECT op.payment_type, 
 	   COUNT (DISTINCT(op.order_id)) AS number_of_orders,
	   SUM(op.payment_value) AS total_payment_value
FROM olist_orders o
JOIN olist_order_payments op
	ON o.order_id = op.order_id
WHERE o.order_status ='delivered'
GROUP BY op.payment_type;

--Analyzing review scores
WITH orders_delivered_on_or_before_date AS(
SELECT AVG(review_score) AS orders_delivered_on_or_before_date_avg_review_score
FROM olist_orders o
JOIN olist_order_reviews ore
	ON o.order_id = ore.order_id
WHERE o.order_status = 'delivered' 
	AND order_delivered_customer_date::date <= order_estimated_delivery_date::date
),
orders_delivered_after_date AS(
SELECT AVG(review_score) AS orders_delivered_after_date_avg_review_score
FROM olist_orders o
JOIN olist_order_reviews ore
	ON o.order_id = ore.order_id
WHERE o.order_status = 'delivered' 
	AND order_delivered_customer_date::date > order_estimated_delivery_date::date
)

SELECT orders_delivered_on_or_before_date_avg_review_score, orders_delivered_after_date_avg_review_score
FROM orders_delivered_on_or_before_date
CROSS JOIN orders_delivered_after_date;

--Ranking sellers based on their revenue 
WITH seller_revenue AS(
SELECT oi.seller_id,
		SUM(oi.price) AS total_revenue
FROM olist_orders o
JOIN olist_order_items oi
	ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY oi.seller_id
)
SELECT *,
	   DENSE_RANK()OVER(ORDER BY total_revenue DESC) AS ranking 
FROM seller_revenue
ORDER BY ranking;








