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
-- MAGIC * Delta Live Tables supports only SQL and Python (You cannot use JVM libraries in a pipeline)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ## CREATE LIVE TABLE
-- MAGIC 
-- MAGIC * `CREATE OR REFRESH [TEMPORARY] { STREAMING LIVE TABLE | LIVE TABLE } table_name`
-- MAGIC * This Delta Live Tables query is syntactically valid, but you must create a pipeline in order to define and populate your table.

-- COMMAND ----------

-- MAGIC %md ## CREATE LIVE VIEW
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
-- MAGIC * Creates a table that reads an input dataset as a stream
-- MAGIC * Input dataset must be a streaming data source, e.g. [Auto Loader](https://docs.databricks.com/ingestion/auto-loader/index.html) (discussed lated in this notebook) or a `STREAMING LIVE` table.

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
-- MAGIC 1. only tables and associated metadata are published. Views are not published to the metastore.
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

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ## Ingest data into Delta Live Tables
-- MAGIC 
-- MAGIC [Ingest data into Delta Live Tables](https://docs.databricks.com/workflows/delta-live-tables/delta-live-tables-data-sources.html):
-- MAGIC 
-- MAGIC * Databricks recommends using Auto Loader for pipelines that read data from supported file formats, particularly for streaming live tables that operate on continually arriving data. Auto Loader is scalable, efficient, and supports schema inference.
-- MAGIC * SQL datasets can use Delta Live Tables file sources to read data in a batch operation from file formats not supported by Auto Loader (see [Spark SQL file sources](https://docs.databricks.com/workflows/delta-live-tables/delta-live-tables-data-sources.html#spark-sql-file-sources)).

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ```sql
-- MAGIC CREATE OR REFRESH LIVE TABLE customers
-- MAGIC AS SELECT * FROM parquet.`/databricks-datasets/samples/lending_club/parquet/`
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md ## Databricks Auto Loader

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC [Auto Loader](https://docs.databricks.com/ingestion/auto-loader/index.html)
-- MAGIC 
-- MAGIC * Auto Loader incrementally and efficiently processes new data files as they arrive in cloud storage
-- MAGIC * Auto Loader can load data files from AWS S3 (s3://), Azure Data Lake Storage Gen2 (ADLS Gen2, abfss://), Google Cloud Storage (GCS, gs://), Azure Blob Storage (wasbs://), ADLS Gen1 (adl://), and Databricks File System (DBFS, dbfs:/)
-- MAGIC * Auto Loader can ingest JSON, CSV, PARQUET, AVRO, ORC, TEXT, and BINARYFILE file formats.
-- MAGIC * Auto Loader provides a Structured Streaming source called `cloudFiles`
-- MAGIC * Given an input directory path on the cloud file storage, the `cloudFiles` source automatically processes new files as they arrive, with the option of also processing existing files in that directory.
-- MAGIC * Auto Loader has support for both Python and SQL in Delta Live Tables.
-- MAGIC * Databricks recommends Auto Loader in Delta Live Tables for incremental data ingestion from cloud object storage
-- MAGIC * APIs are available in Python and Scala.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC [Using Auto Loader in Delta Live Tables](https://docs.databricks.com/ingestion/auto-loader/dlt.html)
-- MAGIC 
-- MAGIC * No need to provide a schema or checkpoint location because Delta Live Tables automatically manages these settings for your pipelines.
-- MAGIC * Delta Live Tables provides slightly modified Python syntax for Auto Loader, and adds SQL support for Auto Loader.
-- MAGIC * Delta Live Tables automatically configures and manages the schema and checkpoint directories when using Auto Loader to read files.
-- MAGIC * Databricks recommends using the automatically configured directories to avoid unexpected side effects during processing.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ```sql
-- MAGIC CREATE OR REFRESH STREAMING LIVE TABLE customers
-- MAGIC AS SELECT * FROM cloud_files("/databricks-datasets/retail-org/customers/", "csv")
-- MAGIC ```
-- MAGIC 
-- MAGIC ```sql
-- MAGIC CREATE OR REFRESH STREAMING LIVE TABLE sales_orders_raw
-- MAGIC AS SELECT * FROM cloud_files("/databricks-datasets/retail-org/sales_orders/", "json")
-- MAGIC ```
-- MAGIC 
-- MAGIC ```sql
-- MAGIC CREATE OR REFRESH STREAMING LIVE TABLE customers
-- MAGIC AS SELECT * FROM cloud_files("/databricks-datasets/retail-org/customers/", "csv", map("delimiter", "\t", "header", "true"))
-- MAGIC ```
