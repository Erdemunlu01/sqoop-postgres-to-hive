# Troubleshooting – Common Issues and Solutions

This document describes **common issues** that may occur during the
PostgreSQL → Sqoop → Hive data transfer process and provides
their **possible causes and solutions**.

---

## 1) Sqoop PostgreSQL Connection Error

### Issue
- Sqoop fails to connect to PostgreSQL.
- JDBC connection error occurs.

### Possible Causes
- PostgreSQL service is not running.
- JDBC connection URL is incorrect.
- Username or password is incorrect.
- PostgreSQL JDBC driver is missing.

### Solution
- Verify that the PostgreSQL service is running.
- Check the JDBC URL format.
- Ensure the `--password-file` exists and is readable.
- Confirm that the PostgreSQL JDBC driver exists under `/usr/share/java/`.

---

## 2) Permission Error During Sqoop Import

### Issue
- HDFS permission error during Sqoop import.

### Possible Causes
- Target HDFS directory is not writable.
- User does not have sufficient HDFS permissions.

### Solution
```bash
hdfs dfs -mkdir -p /tmp/retailer_db
hdfs dfs -chmod -R 777 /tmp/retailer_db
```

---

## 3) Hive Table Not Created

### Issue
- Hive table is not created after Sqoop import.

### Possible Causes
- `--hive-import` parameter was not used.
- HiveServer2 or Hive Metastore is not running.

### Solution
- Ensure `--hive-import` and `--create-hive-table` are included in the Sqoop command.
- Verify that Hive services are running.

```bash
jps
```

---

## 4) Unable to Connect to Hive Using Beeline

### Issue
- Beeline connection returns "connection refused".

### Possible Causes
- HiveServer2 service is not running.
- Incorrect host or port configuration.

### Solution
```bash
beeline -u jdbc:hive2://localhost:10000
```

- Restart HiveServer2 if necessary.

---

## 5) Data Not Loaded Into ORC Table

### Issue
- `INSERT OVERWRITE` executes successfully but ORC table remains empty.

### Possible Causes
- Column order mismatch between source and target tables.
- Source table contains no data.

### Solution
- Verify that the source table contains data.
- Ensure the SELECT column order matches the ORC table schema.

---

## 6) Split-by Column Errors

### Issue
- Sqoop fails due to split-by column issues.

### Possible Causes
- `--split-by` column is not numeric.
- Column contains NULL values.

### Solution
- Choose a numeric and NOT NULL column for `--split-by`.
- If needed, use `--num-mappers 1`.

---

## 7) General Checklist

If issues persist, verify the following:

- PostgreSQL, Hadoop, Hive, and Sqoop services are running
- User permissions are correct
- HDFS directory permissions are properly set
- Hive tables are created in the correct database
- ORC tables contain data

---

## Summary

This document covers the most common problems encountered during
the data transfer process along with practical solutions.

Most issues can be resolved by checking services,
permissions, and configuration settings carefully.
