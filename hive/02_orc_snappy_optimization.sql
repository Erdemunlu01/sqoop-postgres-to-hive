-- Hive ORC + SNAPPY Optimized Tables
-- Target database: test1
-- Source tables: test1.*         (TEXT/managed tables created by Sqoop)
-- Target tables: test1.*_orc     (ORC + SNAPPY optimized tables)

-- Recommended session settings
SET hive.exec.compress.output=true;
SET hive.exec.orc.compress=SNAPPY;

------------------------------------------------------------
-- 1) CATEGORIES -> categories_orc
------------------------------------------------------------
DROP TABLE IF EXISTS test1.categories_orc;

CREATE TABLE test1.categories_orc (
  categoryid INT,
  categorydepartmentid INT,
  categoryname STRING
)
STORED AS ORC
TBLPROPERTIES ("orc.compress"="SNAPPY");

INSERT OVERWRITE TABLE test1.categories_orc
SELECT
  categoryid,
  categorydepartmentid,
  categoryname
FROM test1.categories;

SELECT COUNT(*) AS cnt_categories_orc FROM test1.categories_orc;

-- Optional cleanup:
-- DROP TABLE test1.categories;

------------------------------------------------------------
-- 2) CUSTOMERS -> customers_orc
------------------------------------------------------------
DROP TABLE IF EXISTS test1.customers_orc;

CREATE TABLE test1.customers_orc (
  customerid INT,
  customerfname STRING,
  customerlname STRING,
  customeremail STRING,
  customerpassword STRING,
  customerstreet STRING,
  customercity STRING,
  customerstate STRING,
  customerzipcode INT
)
STORED AS ORC
TBLPROPERTIES ("orc.compress"="SNAPPY");

INSERT OVERWRITE TABLE test1.customers_orc
SELECT
  customerid,
  customerfname,
  customerlname,
  customeremail,
  customerpassword,
  customerstreet,
  customercity,
  customerstate,
  customerzipcode
FROM test1.customers;

SELECT COUNT(*) AS cnt_customers_orc FROM test1.customers_orc;

-- Optional cleanup:
-- DROP TABLE test1.customers;

------------------------------------------------------------
-- 3) DEPARTMENTS -> departments_orc
------------------------------------------------------------
DROP TABLE IF EXISTS test1.departments_orc;

CREATE TABLE test1.departments_orc (
  departmentid INT,
  departmentname STRING
)
STORED AS ORC
TBLPROPERTIES ("orc.compress"="SNAPPY");

INSERT OVERWRITE TABLE test1.departments_orc
SELECT
  departmentid,
  departmentname
FROM test1.departments;

SELECT COUNT(*) AS cnt_departments_orc FROM test1.departments_orc;

-- Optional cleanup:
-- DROP TABLE test1.departments;

------------------------------------------------------------
-- 4) ORDER_ITEMS -> order_items_orc
------------------------------------------------------------
DROP TABLE IF EXISTS test1.order_items_orc;

CREATE TABLE test1.order_items_orc (
  orderitemname INT,
  orderitemorderid INT,
  orderitemproductid INT,
  orderitemquantity INT,
  orderitemsubtotal DOUBLE,
  orderitemproductprice DOUBLE
)
STORED AS ORC
TBLPROPERTIES ("orc.compress"="SNAPPY");

INSERT OVERWRITE TABLE test1.order_items_orc
SELECT
  orderitemname,
  orderitemorderid,
  orderitemproductid,
  orderitemquantity,
  orderitemsubtotal,
  orderitemproductprice
FROM test1.order_items;

SELECT COUNT(*) AS cnt_order_items_orc FROM test1.order_items_orc;

-- Optional cleanup:
-- DROP TABLE test1.order_items;

------------------------------------------------------------
-- 5) ORDERS -> orders_orc
------------------------------------------------------------
DROP TABLE IF EXISTS test1.orders_orc;

CREATE TABLE test1.orders_orc (
  orderid INT,
  orderdate STRING,
  ordercustomerid INT,
  orderstatus STRING
)
STORED AS ORC
TBLPROPERTIES ("orc.compress"="SNAPPY");

INSERT OVERWRITE TABLE test1.orders_orc
SELECT
  orderid,
  orderdate,
  ordercustomerid,
  orderstatus
FROM test1.orders;

SELECT COUNT(*) AS cnt_orders_orc FROM test1.orders_orc;

-- Optional cleanup:
-- DROP TABLE test1.orders;

------------------------------------------------------------
-- 6) PRODUCTS -> products_orc
------------------------------------------------------------
DROP TABLE IF EXISTS test1.products_orc;

CREATE TABLE test1.products_orc (
  productid INT,
  productcategoryid INT,
  productname STRING,
  productdescription STRING,
  productprice DOUBLE,
  productimage STRING
)
STORED AS ORC
TBLPROPERTIES ("orc.compress"="SNAPPY");

INSERT OVERWRITE TABLE test1.products_orc
SELECT
  productid,
  productcategoryid,
  productname,
  productdescription,
  productprice,
  productimage
FROM test1.products;

SELECT COUNT(*) AS cnt_products_orc FROM test1.products_orc;

-- Optional cleanup:
-- DROP TABLE test1.products;
