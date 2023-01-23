-- Databricks notebook source
-- MAGIC %md
-- MAGIC 
-- MAGIC # Delta Live Tables

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ## Introduction
-- MAGIC 
-- MAGIC **Delta Live Tables** (DLTs in short) is _"a framework for building and managing batch and streaming data pipelines on the Databricks Lakehouse Platform. DLT helps data engineering teams simplify ETL development and management with declarative pipeline development, automatic data testing, and deep visibility for monitoring and recovery."_
-- MAGIC 
-- MAGIC Main points:
-- MAGIC 
-- MAGIC * A framework
-- MAGIC * Batch and Streaming Data Pipelines
-- MAGIC * For Data Engineers
-- MAGIC * ETL development and management
-- MAGIC * Declarative
-- MAGIC * Data Expectations
-- MAGIC * Uses Databricks notebooks
-- MAGIC 
-- MAGIC From [Delta Live Tables introduction](https://docs.databricks.com/workflows/delta-live-tables/index.html):
-- MAGIC 
-- MAGIC > **Delta Live Tables** is a framework for building (reliable, maintainable, and testable) data processing pipelines. You define the transformations to perform on your data, and Delta Live Tables manages task orchestration, cluster management, monitoring, data quality, and error handling.
-- MAGIC 
-- MAGIC In summary, Delta Live Tables is a framework for building data processing pipelines:
-- MAGIC 
-- MAGIC * You define transformations of your data
-- MAGIC * Delta Live Tables takes care of task orchestration, cluster management, monitoring, data quality, and error handling

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ## DLT Features and Pricing
-- MAGIC 
-- MAGIC From [Delta Live Tables introduction](https://learn.microsoft.com/en-us/azure/databricks/workflows/delta-live-tables/):
-- MAGIC 
-- MAGIC > DLT is available only in the Premium tier.
-- MAGIC 
-- MAGIC From [Azure Databricks pricing](https://azure.microsoft.com/en-us/pricing/details/databricks/):
-- MAGIC 
-- MAGIC * Basic Capabilities
-- MAGIC * Change Data Capture
-- MAGIC * Data Quality

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ### Basic Capabilities
-- MAGIC 
-- MAGIC Described as **DLT Core** in [Azure Databricks pricing](https://azure.microsoft.com/en-us/pricing/details/databricks/).

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ### Change Data Capture
-- MAGIC 
-- MAGIC Described as **DLT Pro** in [Azure Databricks pricing](https://azure.microsoft.com/en-us/pricing/details/databricks/).

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ### WIP Data Quality / Expectations
-- MAGIC 
-- MAGIC Described as **DLT Advanced** in [Azure Databricks pricing](https://azure.microsoft.com/en-us/pricing/details/databricks/).
-- MAGIC 
-- MAGIC Enforce data quality with expectations.

-- COMMAND ----------

-- MAGIC %md ## Quickstart
-- MAGIC 
-- MAGIC In [Delta Live Tables quickstart](https://docs.databricks.com/workflows/delta-live-tables/delta-live-tables-quickstart.html), you:
-- MAGIC 
-- MAGIC * Create a new notebook and add the code to implement the pipeline.
-- MAGIC * Create a new pipeline job using the notebook.
-- MAGIC * Start an update of the pipeline job.
-- MAGIC * View results of the pipeline job.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ## How to create DLT pipeline
-- MAGIC 
-- MAGIC Define end-to-end data pipelines in SQL or Python:
-- MAGIC 
-- MAGIC * `CREATE [OR REFRESH] LIVE TABLE` in SQL
-- MAGIC * `@dlt.table` in Python
-- MAGIC 
-- MAGIC One or more notebooks that implement a pipeline
-- MAGIC 
-- MAGIC Specify the data source, the transformation logic, and the destination state of the data
-- MAGIC 
-- MAGIC Automatically maintain all data dependencies across pipelines and reuse ETL pipelines with environment-independent data management.

-- COMMAND ----------

-- MAGIC %md ## Supported Commands
-- MAGIC 
-- MAGIC Found in an exception today
-- MAGIC 
-- MAGIC DLT currently only accepts:
-- MAGIC 
-- MAGIC * `CREATE TEMPORARY LIVE VIEW`
-- MAGIC * `CREATE OR REFRESH LIVE TABLE`
-- MAGIC * `APPLY CHANGES INTO`
-- MAGIC * `SET`

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ## Tematy do rozpoznania
-- MAGIC 
-- MAGIC 1. Demo CDF
-- MAGIC 2. STREAMING clause
-- MAGIC 3. Continuous execution pipeline mode
-- MAGIC 3. 

-- COMMAND ----------

-- MAGIC %md ## CREATE LIVE TABLE
-- MAGIC 
-- MAGIC Similar to SQL `WITH` clause ([Common Table Expression (CTE)](https://spark.apache.org/docs/latest/sql-ref-syntax-qry-select-cte.html) in Spark SQL) that [dbt](https://www.getdbt.com/) is based on.

-- COMMAND ----------

-- MAGIC %md ## Settings
-- MAGIC 
-- MAGIC [Delta Live Tables settings](https://docs.databricks.com/workflows/delta-live-tables/delta-live-tables-configuration.html)

-- COMMAND ----------

-- MAGIC %md ## Expectations
-- MAGIC 
-- MAGIC Prevent bad data from flowing into tables through validation and integrity checks and avoid data quality errors with predefined error policies (fail, drop, alert or quarantine data).
-- MAGIC 
-- MAGIC Enforce data quality with Delta Live Tables expectations:
-- MAGIC 
-- MAGIC * define expected data quality
-- MAGIC * specify how to handle records that fail those expectations.
-- MAGIC 
-- MAGIC Learn more in [Manage data quality with Delta Live Tables](https://learn.microsoft.com/en-us/azure/databricks/workflows/delta-live-tables/delta-live-tables-expectations).

-- COMMAND ----------

-- MAGIC %md ## Enhanced Autoscaling
-- MAGIC 
-- MAGIC Designed for streaming workloads
-- MAGIC 
-- MAGIC Optimizes cluster utilization by only scaling up to the necessary number of nodes while maintaining end-to-end SLAs, and gracefully shuts down nodes when utilization is low to avoid unnecessary spend.

-- COMMAND ----------

-- MAGIC %md ## How to Run
-- MAGIC 
-- MAGIC Run in batch or streaming mode and specify incremental or complete computation for each table.

-- COMMAND ----------

-- MAGIC %md ## Monitoring

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ## Links
-- MAGIC 
-- MAGIC * [Product Page](https://www.databricks.com/product/delta-live-tables)
-- MAGIC * [Official documentation](https://docs.databricks.com/workflows/delta-live-tables/index.html)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC # Data Engineering with Databricks Course
-- MAGIC 
-- MAGIC [Data Engineering with Databricks](https://github.com/databricks-academy/data-engineering-with-databricks-english) (DEWD) course in [08 - Delta Live Tables](https://github.com/databricks-academy/data-engineering-with-databricks-english/tree/published/08%20-%20Delta%20Live%20Tables) notebook sets presents Delta Live Tables.
-- MAGIC 
-- MAGIC We're going to use it. Open up your Databricks Workspace and import the notebooks. "08 - Delta Live Tables" cell is [here](https://training-partners.cloud.databricks.com/#notebook/244818595657835/command/244818595657935).

-- COMMAND ----------


