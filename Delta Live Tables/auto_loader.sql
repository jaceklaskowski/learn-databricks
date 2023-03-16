-- Databricks notebook source
-- MAGIC %md # auto_loader DLT Table

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ## Why SQL Considered Superior (over Python)
-- MAGIC 
-- MAGIC Unlike in Python, [Delta Live Tables SQL](https://docs.databricks.com/workflows/delta-live-tables/delta-live-tables-sql-ref.html) allow for:
-- MAGIC 
-- MAGIC 1. Executing DLT notebooks for syntax analysis (using `Run all`)
-- MAGIC 1. Markdown 😍
-- MAGIC 
-- MAGIC You can still use SQL notebooks with Python notebooks in a single DLT pipeline.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC When executing the notebook in a DLT pipeline you will get this WARN message:
-- MAGIC 
-- MAGIC ```
-- MAGIC Magic commands (e.g. %py, %sql and %run) are not supported with the exception of
-- MAGIC %pip within a Python notebook. Cells containing magic commands are ignored.
-- MAGIC Unsupported magic commands were found in the following notebooks
-- MAGIC 
-- MAGIC /Repos/jacek@japila.pl/learn-databricks/Delta Live Tables/auto_loader: %fs
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC Let's start with an example non-DLT query with `cloud_files` TVF (Auto Loader).
-- MAGIC 
-- MAGIC It won't work.
-- MAGIC 
-- MAGIC `cloud_files` creates a streaming table while CTAS does not define one.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC The following won't work as is in a DLT notebook.
-- MAGIC 
-- MAGIC ```
-- MAGIC Unable to process top-level query. DLT currently only accepts 'CREATE TEMPORARY LIVE VIEW', 'CREATE OR REFRESH LIVE TABLE', 'APPLY CHANGES INTO', and 'SET' statements.
-- MAGIC ```
-- MAGIC 
-- MAGIC Don't forget to comment it out before executing the notebook in a DLT pipeline.

-- COMMAND ----------

-- SELECT * FROM cloud_files("/databricks-datasets/retail-org/customers/", "csv")

-- COMMAND ----------

CREATE OR REFRESH STREAMING LIVE TABLE customers
AS SELECT * FROM cloud_files("/databricks-datasets/retail-org/customers/", "csv")

-- COMMAND ----------

-- MAGIC %md Make sure that `dbfs:/jaceklaskowski/my_streaming_table` is available before executing a DLT pipeline

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC Execute the following in separate cells or using `databricks` CLI.
-- MAGIC 
-- MAGIC ```
-- MAGIC %fs mkdirs dbfs:/jaceklaskowski/my_streaming_table
-- MAGIC %fs ls dbfs:/jaceklaskowski/my_streaming_table
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC Copy files for schema inference.
-- MAGIC 
-- MAGIC ```console
-- MAGIC $ databricks fs cp 1.csv dbfs:/jaceklaskowski/my_streaming_table
-- MAGIC $ databricks fs ls dbfs:/jaceklaskowski/my_streaming_table
-- MAGIC 1.csv
-- MAGIC ```

-- COMMAND ----------

CREATE OR REFRESH STREAMING LIVE TABLE my_streaming_table
AS SELECT * FROM cloud_files("/tmp/my_streaming_table", "csv")
