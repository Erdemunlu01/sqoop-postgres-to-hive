# Runbook – Step-by-Step PostgreSQL → Sqoop → Hive → ORC

This document is the main execution guide that explains,
step by step, how data stored in PostgreSQL is transferred
into Apache Hive using Apache Sqoop and then optimized
using ORC format with SNAPPY compression.

This runbook is fully aligned with the command and SQL files
provided in this repository.

---

## Step 1: Create PostgreSQL Tables

First, connect to the PostgreSQL database and create the required tables.

```bash
psql -d traindb
```

Tables are created using the following file:

```text
postgres/01_create_tables.sql
```

Purpose:
- Prepare schemas for loading CSV data

---

## Step 2: Load CSV Data into PostgreSQL

Retail dataset CSV files are loaded into PostgreSQL tables
using the `\copy` command.

Example:

```bash
\copy categories from '/home/train/datasets/retail_db/categories.csv' DELIMITERS ',' CSV HEADER;
\copy customers from '/home/train/datasets/retail_db/customers.csv' DELIMITERS ',' CSV HEADER;
```

Purpose:
- Prepare PostgreSQL tables for Sqoop import

---

## Step 3: Import Data from PostgreSQL to Hive Using Sqoop

PostgreSQL tables are imported into Hive using Sqoop.
During this process, Hive tables are created automatically.

Example import command:

```bash
sqoop import --connect jdbc:postgresql://localhost:5432/traindb --username train --password-file file:///home/train/.sqoop.password --table categories --split-by categoryid --hive-import --create-hive-table --hive-table test1.categories --target-dir /tmp/retailer_db/categories_stg
```

Purpose:
- Transfer PostgreSQL tables into Hive through HDFS

This step is repeated for the following tables:
- categories
- customers
- departments
- order_items
- orders
- products

All commands are available in:

```text
terminal/01_sqoop_pipeline_commands.txt
```

---

## Step 4: Validate Hive Tables

After Sqoop import, validate that Hive tables
are created correctly and contain data.

```bash
beeline -u jdbc:hive2://localhost:10000 -e "SELECT count(*) FROM test1.categories;"
```

Purpose:
- Ensure data has been transferred without loss

---

## Step 5: Create ORC + SNAPPY Optimized Tables

Text-format Hive tables are converted into ORC format
for better performance.

```sql
CREATE TABLE test1.categories_orc (
  categoryid INT,
  categorydepartmentid INT,
  categoryname STRING
)
STORED AS ORC
TBLPROPERTIES ("orc.compress"="SNAPPY");
```

Purpose:
- Reduce storage usage
- Improve query performance

---

## Step 6: Load Data from Text Tables into ORC Tables

```sql
INSERT OVERWRITE TABLE test1.categories_orc
SELECT * FROM test1.categories;
```

This process is applied to all imported tables.

Used script:

```text
hive/02_orc_snappy_optimization.sql
```

---

## Step 7: Clean Up Old Text Tables

After ORC tables are validated,
temporary text tables are removed.

```sql
DROP TABLE test1.categories;
```

Purpose:
- Clean up storage
- Continue working only with optimized tables

---

## Summary Flow

```text
CSV
 ↓
PostgreSQL
 ↓
Sqoop Import
 ↓
Hive (TEXT Tables)
 ↓
Hive (ORC + SNAPPY Tables)
```

Once these steps are completed,
the Hive environment becomes ready for
efficient and scalable analytical queries.
