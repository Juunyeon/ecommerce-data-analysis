/*商品品类基础数据*/
SELECT COALESCE(product_category_name_english,products.product_category_name) AS category,
    SUM(price)AS total_sales,COUNT(order_item_id)AS item_count,
    COUNT(DISTINCT orders.order_id)AS order_count
FROM products
JOIN order_items ON products.product_id=order_items.product_id
JOIN orders ON order_items.order_id=orders.order_id
LEFT JOIN translation ON products.product_category_name=translation.product_category_name
WHERE order_status='delivered' AND products.product_category_name IS NOT NULL
GROUP BY COALESCE(product_category_name_english,products.product_category_name)
ORDER BY total_sales DESC;

/*商品品类月度数据*/
SELECT DATE_FORMAT(order_purchase_timestamp,'%Y-%m') as months,
    COALESCE(product_category_name_english,products.product_category_name,'unknown') AS category,
    SUM(price)AS total_sales,COUNT(order_item_id)AS item_count,
    COUNT(DISTINCT orders.order_id)AS order_count
FROM products
JOIN order_items ON products.product_id=order_items.product_id
JOIN orders ON order_items.order_id=orders.order_id
LEFT JOIN translation ON products.product_category_name=translation.product_category_name
WHERE order_status='delivered' 
GROUP BY months,category
ORDER BY months;