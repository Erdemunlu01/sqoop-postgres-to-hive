# Prerequisites – Environment and Requirements

This document lists all **environment requirements and prerequisites**
needed to successfully run the **PostgreSQL to Apache Hive data transfer**
case study using **Apache Sqoop**.

---

## 1) Operating System and Environment

This case study is prepared with the following environment assumptions:

- Linux-based operating system (CentOS / Rocky / Ubuntu)
- Hadoop ecosystem installed and running
- Single-node or multi-node setup (both are supported)
- User: `train`

---

## 2) Required Components

The following components must be installed on the system:

- PostgreSQL
- Apache Hadoop (HDFS + YARN)
- Apache Hive
- Apache Sqoop
- Java (JDK 8 or compatible version)

All components must be **running properly** before starting the case study.

---

## 3) Service Checks

Before starting the case study, ensure that the required services
are up and running.

### Hadoop Services

```bash
jps
```

Expected processes:

- NameNode
- DataNode
- ResourceManager
- NodeManager

### Hive Services

The following Hive services must be running:

- Hive Metastore
- HiveServer2

Check using:

```bash
jps
```

---

## 4) PostgreSQL Prerequisites

On the PostgreSQL side, the following conditions must be met:

- Database name: `traindb`
- PostgreSQL service must be running
- User `train` must have permission to create tables and load data

Example path for CSV files:

```text
/home/train/datasets/retail_db/
```

---

## 5) Sqoop PostgreSQL JDBC Driver

To allow Sqoop to connect to PostgreSQL, the **PostgreSQL JDBC driver**
must be available on the system.

It is typically located at:

```text
/usr/share/java/postgresql-*.jar
```

---

## 6) Sqoop Password File

To avoid exposing the password directly in command-line arguments,
the Sqoop `--password-file` mechanism is used.

### Creating the password file

```bash
echo -n "POSTGRES_PASSWORD" > /home/train/.sqoop.password
chmod 400 /home/train/.sqoop.password
```

> Note: The file must be readable only by its owner.

---

## 7) Hive Environment

On the Hive side:

- HiveServer2 must be running
- Connection via Beeline must be possible

Connection test:

```bash
beeline -u jdbc:hive2://localhost:10000
```

---

## 8) HDFS Permissions and Directories

Sqoop imports use temporary HDFS directories during execution.

The following directory must be writable:

```text
/tmp/retailer_db/
```

If necessary, create the directory and assign permissions:

```bash
hdfs dfs -mkdir -p /tmp/retailer_db
hdfs dfs -chmod -R 777 /tmp/retailer_db
```

---

## 9) Hive Database

The Hive database used as the target during Sqoop imports:

- Hive database: `test1`

If it does not exist:

```sql
CREATE DATABASE test1;
```

---

## 10) Summary

In this document:

- Required software components are listed
- Service checks are explained
- PostgreSQL, Sqoop, and Hive prerequisites are defined
- Secure password-file usage is documented
- HDFS and Hive environment requirements are described

Once all prerequisites are satisfied,
the data transfer process can be safely started.
