-- PostgreSQL Table Creation (Retail DB)
-- Note: Only missing semicolons (;) were fixed in this file.
-- Target database: traindb

-- categories table
CREATE TABLE IF NOT EXISTS categories (
  categoryId SMALLINT,
  categoryDepartmentId SMALLINT,
  categoryName VARCHAR(20)
);

SELECT * FROM categories LIMIT 10;
SELECT COUNT(*) FROM categories;

-- customers table
CREATE TABLE IF NOT EXISTS customers (
  customerId SMALLINT,
  customerFName VARCHAR,
  customerLName VARCHAR,
  customerEmail VARCHAR,
  customerPassword VARCHAR,
  customerStreet VARCHAR,
  customerCity VARCHAR,
  customerState VARCHAR,
  customerZipcode INT
);

SELECT * FROM customers LIMIT 10;
SELECT COUNT(*) FROM customers;

-- departments table
CREATE TABLE IF NOT EXISTS departments (
  departmentId SMALLINT,
  departmentName VARCHAR(20)
);

SELECT * FROM departments LIMIT 10;
SELECT COUNT(*) FROM departments;

-- order_items table
CREATE TABLE IF NOT EXISTS order_items (
  orderItemName INT,
  orderItemOrderId INT,
  orderItemProductId INT,
  orderItemQuantity INT,
  orderItemSubTotal FLOAT8,
  orderItemProductPrice FLOAT8
);

SELECT * FROM order_items LIMIT 10;
SELECT COUNT(*) FROM order_items;

-- orders table
CREATE TABLE IF NOT EXISTS orders (
  orderId INT,
  orderDate TIMESTAMP,
  orderCustomerId INT,
  orderStatus VARCHAR
);

SELECT * FROM orders LIMIT 10;
SELECT COUNT(*) FROM orders;
SELECT * FROM orders ORDER BY orderdate DESC LIMIT 10;

-- products table
CREATE TABLE IF NOT EXISTS products (
  productId INT,
  productCategoryId SMALLINT,
  productName VARCHAR,
  productDescription VARCHAR,
  productPrice FLOAT8,
  productImage VARCHAR
);

SELECT * FROM products LIMIT 10;
SELECT COUNT(*) FROM products;
