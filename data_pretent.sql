USE encommerce_analysis;

/*将CSV数据导入mysql环境中*/
CREATE TABLE customer(
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix VARCHAR(20),
    customer_city VARCHAR(50),
    customer_state VARCHAR(10))CHARSET=utf8mb4;
LOAD DATA INFILE'C:/Users/23697/Desktop/olist_analysis/olist_customers_dataset.csv'
INTO TABLE customer
FIELDS TERMINATED BY','
ENCLOSED BY""
LINES TERMINATED BY'\n'
IGNORE 1 ROWS;
CREATE TABLE orders(
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(50),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME)CHARSET=utf8mb4;
LOAD DATA INFILE'C:/Users/23697/Desktop/olist_analysis/olist_orders_dataset.csv'
INTO TABLE orders
FIELDS TERMINATED BY','
ENCLOSED BY""
LINES TERMINATED BY'\r\n'
IGNORE 1 ROWS
(order_id,customer_id,order_status,@order_purchase_timestamp,@order_approved_at,@order_delivered_carrier_date,@order_delivered_customer_date,@order_estimated_delivery_date)
SET order_purchase_timestamp=NULLIF(@order_purchase_timestamp,''),
    order_approved_at=NULLIF(@order_approved_at,''),
    order_delivered_carrier_date=NULLIF(@order_delivered_carrier_date,''),
    order_delivered_customer_date=NULLIF(@order_delivered_customer_date,''),
    order_estimated_delivery_date=NULLIF(@order_estimated_delivery_date,'');
CREATE TABLE order_items(
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date DATETIME,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2),
    PRIMARY KEY(order_id,order_item_id));
LOAD DATA INFILE'C:/Users/23697/Desktop/olist_analysis/olist_order_items_dataset.csv'
INTO TABLE order_items
FIELDS TERMINATED BY','
ENCLOSED BY""
LINES TERMINATED BY'\n'
IGNORE 1 ROWS;
CREATE TABLE products(
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(50),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT)CHARSET=utf8mb4;
LOAD DATA INFILE'C:/Users/23697/Desktop/olist_analysis/olist_products_dataset.csv'
INTO TABLE products
FIELDS TERMINATED BY','
ENCLOSED BY""
LINES TERMINATED BY'\n'
IGNORE 1 ROWS
(product_id,@product_category_name,@product_name_lenght,@product_description_lenght,@product_photos_qty,@product_weight_g,@product_length_cm,@product_height_cm,@product_width_cm)
SET product_category_name=NULLIF(@product_category_name,''),
    product_name_lenght=NULLIF(@product_name_lenght,''),
    product_description_lenght=NULLIF(@product_description_lenght,''),
    product_photos_qty=NULLIF(@product_photos_qty,''),
    product_weight_g=NULLIF(@product_weight_g,''),
    product_length_cm=NULLIF(@product_length_cm,''),
    product_height_cm=NULLIF(@product_height_cm,''),
    product_width_cm=NULLIF(@product_width_cm,'');
CREATE TABLE order_payments(
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(30),
    payment_installments INT,
    payment_value DECIMAL(10,2),
    PRIMARY KEY(order_id,payment_sequential))CHARSET=utf8mb4;
LOAD DATA INFILE'C:/Users/23697/Desktop/olist_analysis/olist_order_payments_dataset.csv'
INTO TABLE order_payments
FIELDS TERMINATED BY','
ENCLOSED BY""
LINES TERMINATED BY'\n'
IGNORE 1 ROWS;
CREATE TABLE translation(
    product_category_name VARCHAR(50) PRIMARY KEY,
    product_category_name_english VARCHAR(50))CHARSET=utf8mb4;
LOAD DATA INFILE'C:/Users/23697/Desktop/olist_analysis/product_category_name_translation.csv'
INTO TABLE translation
FIELDS TERMINATED BY','
ENCLOSED BY""
LINES TERMINATED BY'\n'
IGNORE 1 ROWS;

/*清洗纠正表格中错误的数据*/
SET SQL_SAFE_UPDATES=0;
UPDATE customer
SET customer_id=REPLACE(customer_id, '"', '')
WHERE customer_id LIKE '%"%';
UPDATE order_items
SET order_id=REPLACE(order_id, '"', '')
WHERE order_id LIKE '%"%';
UPDATE products
SET product_id=REPLACE(product_id, '"', '')
WHERE product_id LIKE '%"%';
UPDATE order_payments
SET order_id=REPLACE(order_id, '"', '')
WHERE order_id LIKE '%"%';
SET SQL_SAFE_UPDATES=1;