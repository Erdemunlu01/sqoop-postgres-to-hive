# Sqoop Case Study: PostgreSQL → Apache Hive (Retail DB)

This repository presents an end-to-end **case study** that demonstrates how retail data stored in **PostgreSQL** is transferred into **Apache Hive** using **Apache Sqoop**.

In this study:
- CSV files are loaded into PostgreSQL,
- PostgreSQL tables are imported into Hive using Sqoop (Hive tables are created automatically),
- Hive tables are optimized by converting them into **ORC format with SNAPPY compression**.

> Goal: To document a real-world data pipeline from **source database → data transfer → Hive → performance optimization**.

---

## 🚀 Architecture Flow

The overall data flow is as follows:

**CSV Files → PostgreSQL (traindb) → Sqoop Import → Hive (test1.\*) → ORC + SNAPPY (test1.\*_orc)**

This repository contains terminal commands, PostgreSQL DDL scripts, and Hive optimization SQL files that support this flow.

---

## 📦 Tables Used

The following tables are transferred as part of this case study:

- `categories`
- `customers`
- `departments`
- `order_items`
- `orders`
- `products`

---

## 📁 Repository Structure

```text
sqoop-postgres-to-hive/
├─ README.md
│
├─ docs/
│  ├─ 01_overview.md
│  ├─ 02_prerequisites.md
│  ├─ 03_runbook_step_by_step.md
│  └─ troubleshooting.md
│
├─ postgres/
│  └─ 01_create_tables.sql
│
├─ terminal/
│  └─ 01_sqoop_pipeline_commands.txt
│
├─ hive/
│  └─ 02_orc_snappy_optimization.sql
│
└─ diagrams/
   └─ architecture.png
