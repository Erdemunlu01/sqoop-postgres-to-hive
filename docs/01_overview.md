# Overview – Data Transfer from PostgreSQL to Apache Hive (Sqoop)

This document provides a **high-level overview** of the data transfer process
from **PostgreSQL to Apache Hive** using **Apache Sqoop**, as implemented in
this case study.

The main focus of this study is to demonstrate how data can be moved:
- from a relational database (PostgreSQL),
- into the Hadoop ecosystem,
- and finally into Apache Hive,
using Sqoop as the integration tool.

---

## 1) Why Sqoop?

Apache Sqoop is a tool specifically designed for
**high-volume data transfers** between relational databases
and the Hadoop ecosystem.

Sqoop is used in this case study because it provides:

- Direct data transfer from PostgreSQL to Hive
- Parallel data ingestion using `--split-by`
- Automatic Hive table creation (`--hive-import`)
- Continued relevance in enterprise and legacy data platforms

---

## 2) Overall Data Flow

The data flow followed in this case study is:

1) Raw CSV files are loaded into the PostgreSQL database  
2) PostgreSQL tables are imported into Hive using Sqoop  
3) Text/managed Hive tables are validated  
4) Hive tables are optimized using **ORC format with SNAPPY compression**

Visual summary of the flow:

**CSV → PostgreSQL → Sqoop → Hive (TEXT) → Hive (ORC + SNAPPY)**

---

## 3) Source and Target Systems

### Source System
- PostgreSQL
- Database: `traindb`
- Data type: Retail transaction data

### Target System
- Apache Hive
- Database: `test1`
- File format: ORC
- Compression: SNAPPY

---

## 4) Scope of the Case Study

Within the scope of this study, the following steps are covered:

- Creating tables in PostgreSQL
- Loading CSV data into PostgreSQL (`\copy`)
- Importing data into Hive using Sqoop
- Validating Hive tables (`count(*)`)
- Optimizing Hive tables using ORC + SNAPPY

---

## 5) Purpose of This Document

The purpose of this document is to:

- Explain the **big picture** of the data transfer process,
- Avoid low-level technical details,
- Help readers quickly understand the overall structure of the pipeline.

For detailed, step-by-step commands, refer to:
- `docs/03_runbook_step_by_step.md`

---

## 6) Target Audience

This case study is especially useful for:

- Data Engineer candidates
- Engineers working with Big Data and Hadoop ecosystems
- Anyone who wants to understand Sqoop–Hive integration through a real example
