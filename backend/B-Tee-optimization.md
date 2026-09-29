# Database Performance & B-Tree Index Optimization Guide

This document outlines the standard procedures for identifying slow database queries and implementing B-Tree indexes on PostgreSQL to fulfill **Part A - Point 5** of the project requirements.

## 1. Objective

Ensure that high-traffic tables, foreign keys, filtering columns, and sorting attributes are properly indexed using PostgreSQL's default **B-Tree** index type to prevent full table scans and maintain high query performance as data volume grows.

---

## 2. Identifying Slow Queries

### Method A: Using `pg_stat_statements` (Recommended)

1. Ensure the extension is enabled in your PostgreSQL configuration (`postgresql.conf`):
   ```text
   shared_preload_libraries = 'pg_stat_statements'
   ```
2. Create the extension inside your target database:

```SQL
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;
```

3. Run the following diagnostic query to find the top 10 most time-consuming queries:

```SQL
SELECT
    round(total_exec_time::numeric, 2) AS total_exec_time_ms,
    calls,
    round(mean_exec_time::numeric, 2) AS mean_exec_time_ms,
    query
FROM pg_stat_statements
ORDER BY total_exec_time DESC
LIMIT 10;
```

### Method B: Using EXPLAIN ANALYZE

Before creating an index, test the query execution plan to confirm if a Sequential Scan (`Seq Scan`) is occurring:

```SQL
EXPLAIN ANALYZE
SELECT * FROM orders
WHERE user_id = 12345 AND status = 'completed';
```

If the output shows `Seq Scan` on large tables instead of `Index Scan`, a B-Tree index is required.

## 3. Implementing B-Tree Indexes

Create standard B-Tree indexes on frequently filtered, joined, or sorted columns.

Syntax Example:

```SQL
-- Indexing Foreign Keys and frequent filter columns
CREATE INDEX CONCURRENTLY idx_orders_user_id ON orders (user_id);
CREATE INDEX CONCURRENTLY idx_orders_status ON orders (status);

-- Composite B-Tree Index for multi-column filtering and sorting
CREATE INDEX CONCURRENTLY idx_orders_user_date ON orders (user_id, created_at DESC);
```

(Note: Using `CONCURRENTLY` is recommended for production databases to avoid locking table writes during index creation).

## 4. Verification

After creating the indexes, re-run `EXPLAIN ANALYZE` on the targeted queries to ensure the execution plan shifts from a costly `Seq Scan` to an efficient `Index Scan` or `Bitmap Index Scan`.
