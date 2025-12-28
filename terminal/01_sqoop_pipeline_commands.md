# Terminal Commands – Sqoop Data Transfer from PostgreSQL → Hive
# Note: This file contains the terminal commands used during the case study.
# Environment assumptions:
# - PostgreSQL DB: traindb
# - Hive DB: test1
# - User: train
# - Sqoop password file: /home/train/.sqoop.password
# - HDFS target dirs: /tmp/retailer_db/*_stg
#
# Tip: Run commands one by one. After each import, validate with a beeline COUNT check.

############################################################
# 1) CSV → PostgreSQL (psql \copy)
############################################################

psql -d traindb -c "\copy categories from '/home/train/datasets/retail_db/categories.csv' DELIMITERS ',' CSV HEADER;"
psql -d traindb -c "\copy customers from '/home/train/datasets/retail_db/customers.csv' DELIMITERS ',' CSV HEADER;"
psql -d traindb -c "\copy departments from '/home/train/datasets/retail_db/departments.csv' DELIMITERS ',' CSV HEADER;"
psql -d traindb -c "\copy order_items from '/home/train/datasets/retail_db/order_items.csv' DELIMITERS ',' CSV HEADER;"
psql -d traindb -c "\copy orders from '/home/train/datasets/retail_db/orders.csv' DELIMITERS ',' CSV HEADER;"
psql -d traindb -c "\copy products from '/home/train/datasets/retail_db/products.csv' DELIMITERS ',' CSV HEADER;"

############################################################
# 2) PostgreSQL → Hive (Sqoop Import + Hive Table Create)
############################################################

# categories
sqoop import --connect jdbc:postgresql://localhost:5432/traindb --driver org.postgresql.Driver --username train --password-file file:///home/train/.sqoop.password --table categories --split-by categoryid --hive-import --create-hive-table --hive-table test1.categories --target-dir /tmp/retailer_db/categories_stg
beeline -u jdbc:hive2://localhost:10000 -e "select count(*) from test1.categories;"

# customers
sqoop import --connect jdbc:postgresql://localhost:5432/traindb --driver org.postgresql.Driver --username train --password-file file:///home/train/.sqoop.password --table customers --split-by customerid --hive-import --create-hive-table --hive-table test1.customers --target-dir /tmp/retailer_db/customers_stg
beeline -u jdbc:hive2://localhost:10000 -e "select count(*) from test1.customers;"

# departments
sqoop import --connect jdbc:postgresql://localhost:5432/traindb --driver org.postgresql.Driver --username train --password-file file:///home/train/.sqoop.password --table departments --split-by departmentid --hive-import --create-hive-table --hive-table test1.departments --target-dir /tmp/retailer_db/departments_stg
beeline -u jdbc:hive2://localhost:10000 -e "select count(*) from test1.departments;"

# order_items
sqoop import --connect jdbc:postgresql://localhost:5432/traindb --driver org.postgresql.Driver --username train --password-file file:///home/train/.sqoop.password --table order_items --split-by orderitemproductid --hive-import --create-hive-table --hive-table test1.order_items --target-dir /tmp/retailer_db/order_items_stg
beeline -u jdbc:hive2://localhost:10000 -e "select count(*) from test1.order_items;"

# orders
sqoop import --connect jdbc:postgresql://localhost:5432/traindb --driver org.postgresql.Driver --username train --password-file file:///home/train/.sqoop.password --table orders --split-by orderid --hive-import --create-hive-table --hive-table test1.orders --target-dir /tmp/retailer_db/orders_stg
beeline -u jdbc:hive2://localhost:10000 -e "select count(*) from test1.orders;"

# products
sqoop import --connect jdbc:postgresql://localhost:5432/traindb --driver org.postgresql.Driver --username train --password-file file:///home/train/.sqoop.password --table products --split-by productid --hive-import --create-hive-table --hive-table test1.products --target-dir /tmp/retailer_db/products_stg
beeline -u jdbc:hive2://localhost:10000 -e "select count(*) from test1.products;"

############################################################
# 3) Notes
############################################################
# - The --split-by column must be numeric and ideally contain no NULLs.
# - If you get permission errors: check HDFS permissions for /tmp/retailer_db.
# - If HiveServer2 is not running, beeline cannot connect.
