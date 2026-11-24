CREATE DATABASE ecommerce_dw;

USE ecommerce_dw;
CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE products (
    product_id VARCHAR(20) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL
);

CREATE TABLE orders (
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    product_id VARCHAR(20) NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(30) NOT NULL,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

CREATE TABLE sales (
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    product_id VARCHAR(20) NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    sales_amount DECIMAL(12,2) NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(30) NOT NULL
);
SHOW TABLES;
DESC customers;
DESC products;
DESC orders;
DESC sales;

USE ecommerce_dw;

SELECT COUNT(*) FROM customers;

SELECT COUNT(*) FROM products;

SELECT COUNT(*) FROM orders;

SELECT COUNT(*) FROM sales;
SELECT * FROM sales;

#step25
USE ecommerce_dw;

SELECT
    order_id,
    customer_name,
    product_name,
    quantity,
    price,
    sales_amount
FROM sales
ORDER BY order_id;