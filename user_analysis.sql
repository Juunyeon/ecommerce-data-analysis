/*提取用户消费行为数据*/
SELECT customer_unique_id,SUM(price)AS total_spend,
    COUNT(DISTINCT orders.order_id)AS order_count,
    SUM(price)/COUNT(DISTINCT orders.order_id) AS avg_order_value,
    MIN(order_purchase_timestamp) AS first_purchase,
    MAX(order_purchase_timestamp) AS last_purchase
FROM customer
JOIN orders ON customer.customer_id=orders.customer_id
JOIN order_items ON orders.order_id=order_items.order_id
WHERE order_status='delivered'
GROUP BY customer_unique_id;

/*挑选2017-01到2018-08的数据用作python分析*/
SELECT customer_unique_id,SUM(price) AS total_spend,
    COUNT(DISTINCT orders.order_id) AS order_count,
    SUM(price)/COUNT(DISTINCT orders.order_id) AS avg_order_value,
    MIN(order_purchase_timestamp) AS first_purchase,
    MAX(order_purchase_timestamp) AS last_purchase
FROM customer
JOIN orders ON customer.customer_id = orders.customer_id
JOIN order_items ON orders.order_id = order_items.order_id
WHERE order_status = 'delivered'
    AND order_purchase_timestamp >= '2017-01-01'
    AND order_purchase_timestamp < '2018-09-01'
GROUP BY customer_unique_id;

/*复购分析数据*/
SELECT order_count,COUNT(customer_unique_id)AS user_count
FROM(
    SELECT customer_unique_id,SUM(price)AS total_spend,
        COUNT(DISTINCT orders.order_id)AS order_count,
        SUM(price)/COUNT(DISTINCT orders.order_id) AS avg_order_value,
        MIN(order_purchase_timestamp) AS first_purchase,
        MAX(order_purchase_timestamp) AS last_purchase
    FROM customer
    JOIN orders ON customer.customer_id=orders.customer_id
    JOIN order_items ON orders.order_id=order_items.order_id
    WHERE order_status='delivered'
    GROUP BY customer_unique_id)AS user_behavior
    GROUP BY order_count
    ORDER BY order_count;
    
    /*求解用户复购率*/
    SELECT COUNT(customer_unique_id) AS total_users,
        SUM(CASE WHEN order_count>=2 THEN 1 ELSE 0 END)AS repeat_users,
		SUM(CASE WHEN order_count>=2 THEN 1 ELSE 0 END)/COUNT(customer_unique_id) AS repeat_rate
	FROM(
        SELECT customer_unique_id,SUM(price)AS total_spend,
            COUNT(DISTINCT orders.order_id)AS order_count,
			SUM(price)/COUNT(DISTINCT orders.order_id) AS avg_order_value,
            MIN(order_purchase_timestamp) AS first_purchase,
            MAX(order_purchase_timestamp) AS last_purchase
    FROM customer
    JOIN orders ON customer.customer_id=orders.customer_id
    JOIN order_items ON orders.order_id=order_items.order_id
    WHERE order_status='delivered'
    GROUP BY customer_unique_id)AS user_behavior;