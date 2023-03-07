-- Databricks notebook source
-- MAGIC %md
-- MAGIC 
-- MAGIC # Building Data Pipelines with Delta Live Tables using SQL
-- MAGIC 
-- MAGIC [Meetup](https://www.meetup.com/warsaw-data-engineering/events/291905799/)
-- MAGIC 
-- MAGIC Delta Live Tables extends functionality of Apache Spark's Structured Streaming and allows you to write just a few lines of declarative Python or SQL to deploy a production-quality data pipeline (from [Tutorial: ingesting data with Databricks Auto Loader](https://docs.databricks.com/ingestion/auto-loader/index.html#tutorial-ingesting-data-with-databricks-auto-loader)).
-- MAGIC 
-- MAGIC Learn more in [Delta Live Tables SQL language reference](https://docs.databricks.com/workflows/delta-live-tables/delta-live-tables-sql-ref.html)

-- COMMAND ----------

-- MAGIC %md ## Introduction
-- MAGIC 
-- MAGIC * Delta Live Tables supports only SQL and Python (You cannot use JVM libraries in a DLT pipeline)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ## CREATE LIVE TABLE
-- MAGIC 
-- MAGIC * `CREATE OR REFRESH [TEMPORARY] { STREAMING LIVE TABLE | LIVE TABLE } table_name`
-- MAGIC * This Delta Live Tables query is syntactically valid, but you must create a pipeline in order to define and populate your table.

-- COMMAND ----------

-- MAGIC %md ## CREATE TEMPORARY LIVE VIEW
-- MAGIC 
-- MAGIC * `CREATE TEMPORARY [STREAMING] LIVE VIEW view_name`

-- COMMAND ----------

-- MAGIC %md ## TEMPORARY
-- MAGIC 
-- MAGIC [SQL properties](https://docs.databricks.com/workflows/delta-live-tables/delta-live-tables-sql-ref.html#sql-properties-1):
-- MAGIC 
-- MAGIC * `TEMPORARY` creates a temporary table or view. No metadata is persisted for this table.
-- MAGIC * Use TEMPORARY marker to prevent publishing of intermediate tables that are not intended for external consumption (discussed later in this notebook)

-- COMMAND ----------

-- MAGIC %md ## STREAMING
-- MAGIC 
-- MAGIC * Creates a table or view that reads an input dataset as a stream
-- MAGIC * Input dataset must be a streaming data source, e.g. [Auto Loader](https://docs.databricks.com/ingestion/auto-loader/index.html) (discussed lated in this notebook) or a `STREAMING LIVE` table or view.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ## Identity Columns
-- MAGIC 
-- MAGIC `CREATE LIVE TABLE` supports `GENERATED ALWAYS AS` clause (see [CREATE TABLE SQL reference](https://docs.databricks.com/sql/language-manual/sql-ref-syntax-ddl-create-table-using.html)).
-- MAGIC 
-- MAGIC `GENERATED ALWAYS AS IDENTITY` clause can only be used for columns with BIGINT data type.

-- COMMAND ----------

-- MAGIC %md ## Table properties
-- MAGIC 
-- MAGIC [Table properties](https://docs.databricks.com/workflows/delta-live-tables/delta-live-tables-sql-ref.html#tbl-properties)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ## Publish data from Delta Live Tables pipelines
-- MAGIC 
-- MAGIC [Publish data from Delta Live Tables pipelines](https://docs.databricks.com/workflows/delta-live-tables/delta-live-tables-publish.html):
-- MAGIC 
-- MAGIC 1. make the output data of your pipeline discoverable and available to query by publishing datasets to the Databricks metastore.
-- MAGIC 1. enter a database name in the Target field when you create a pipeline
-- MAGIC 1. No support for publishing tables to Unity Catalog. Delta Live Tables supports publishing tables only to the workspace-level Hive metastore.
-- MAGIC 1. only tables and associated metadata are published. Views are not published to the metastore (because they are temporary by definition).
-- MAGIC 1. Use `TEMPORARY` marker to prevent publishing of intermediate tables that are not intended for external consumption
-- MAGIC     ```sql
-- MAGIC     CREATE TEMPORARY LIVE TABLE temp_table
-- MAGIC     AS SELECT ... ;
-- MAGIC     ```

-- COMMAND ----------

--- Pipeline settings > Destination > Target schema
SHOW TABLES IN jaceklaskowski_dlts;

-- COMMAND ----------

select * from jaceklaskowski_dlts.dlt_one;

-- COMMAND ----------

DESCRIBE EXTENDED jaceklaskowski_dlts.dlt_one;

-- COMMAND ----------

describe history jaceklaskowski_dlts.dlt_one;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ## The End

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ## Pipeline updates
-- MAGIC 
-- MAGIC [Pipeline updates](https://docs.databricks.com/workflows/delta-live-tables/delta-live-tables-concepts.html#dlt-concepts-updates)
-- MAGIC 
-- MAGIC An **update** does the following:
-- MAGIC 
-- MAGIC 1. Starts a cluster with the correct configuration.
-- MAGIC 1. Discovers all the tables and views defined, and checks for any analysis errors such as invalid column names, missing dependencies, and syntax errors.
-- MAGIC 1. Creates or updates tables and views with the most recent data available.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ## Delta Live Tables FAQ
-- MAGIC 
-- MAGIC [Delta Live Tables frequently asked questions](https://docs.databricks.com/workflows/delta-live-tables/delta-live-tables-faqs-issues.html)
