/*总销售数据*/
SELECT total_sales,order_count,customer_count,
total_sales/order_count AS avg_order_value
FROM(
    SELECT
    (
        SELECT SUM(price) 
        FROM order_items
        JOIN orders ON order_items.order_id=orders.order_id
        WHERE order_status='delivered'
        )AS total_sales,
	(
        SELECT COUNT(order_id) 
		FROM orders
        WHERE order_status='delivered'
        )AS order_count,
	(
        SELECT COUNT(DISTINCT customer_unique_id) 
        FROM customer
        JOIN orders ON customer.customer_id=orders.customer_id
        WHERE order_status='delivered'
	    )AS customer_count
)t;

/*临时修改时间格式*/
SELECT order_purchase_timestamp,
DATE_FORMAT(order_purchase_timestamp,'%Y-%m') as months
FROM orders;

/*正式开始按月份统计销售数据*/
SELECT DATE_FORMAT(order_purchase_timestamp,'%Y-%m') as months,
SUM(price) AS m_total_sales,COUNT(DISTINCT orders.order_id) AS m_order_count,
COUNT(DISTINCT customer_unique_id) AS m_customer_count,
SUM(price)/COUNT(DISTINCT orders.order_id) AS m_avg_order_value
FROM orders
JOIN order_items ON orders.order_id=order_items.order_id
JOIN customer ON orders.customer_id=customer.customer_id
WHERE order_status='delivered'
GROUP BY months
ORDER BY months;