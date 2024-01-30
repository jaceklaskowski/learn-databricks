-- Databricks notebook source
-- MAGIC %md # Materialization

-- COMMAND ----------

-- MAGIC %md ## Review Me
-- MAGIC
-- MAGIC 1. https://www.databricks.com/glossary/materialized-views
-- MAGIC 1. https://docs.databricks.com/en/sql/user/materialized-views.html
-- MAGIC 1. https://www.google.com/search?q=databricks+materialized+view

-- COMMAND ----------

-- MAGIC %md ## CREATE TABLE
-- MAGIC
-- MAGIC [CREATE TABLE](https://docs.databricks.com/en/sql/language-manual/sql-ref-syntax-ddl-create-table-using.html)
-- MAGIC
-- MAGIC ```sql
-- MAGIC { { [CREATE OR] REPLACE TABLE | CREATE [EXTERNAL] TABLE [ IF NOT EXISTS ] }
-- MAGIC   table_name
-- MAGIC   [ table_specification ]
-- MAGIC   [ USING data_source ]
-- MAGIC   [ table_clauses ]
-- MAGIC   [ AS query ] }
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md ## AS query
-- MAGIC
-- MAGIC > This optional clause populates the table using the data from query. When you specify a query you must not also specify a table_specification. The table schema is derived from the query.
-- MAGIC
-- MAGIC > Note that Databricks overwrites the underlying data source with the data of the input query, to make sure the table gets created contains exactly the same data as the input query.
-- MAGIC
-- MAGIC

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS demo_table
AS SELECT * FROM VALUES 1,2,3,4

-- COMMAND ----------

DESCRIBE EXTENDED demo_table

-- COMMAND ----------

-- MAGIC %md ## Materialized Views
-- MAGIC
-- MAGIC [Materialized Views](https://www.databricks.com/glossary/materialized-views):
-- MAGIC
-- MAGIC > A materialized view is a database object that stores the results of a query as a physical table. Unlike regular database views, which are virtual and derive their data from the underlying tables, materialized views contain precomputed data that is incrementally updated on a schedule or on demand.

-- COMMAND ----------


