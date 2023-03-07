-- Databricks notebook source
-- DOES NOT WORK
-- cloud_files (Auto Loader) creates a streaming table
-- while CTAS does not define one
-- CREATE OR REFRESH LIVE TABLE customers
-- AS SELECT * FROM cloud_files("/databricks-datasets/retail-org/customers/", "csv")

-- COMMAND ----------

-- it's not supported in DLT pipelines (unless it's a live table)
-- SELECT * FROM cloud_files("/databricks-datasets/retail-org/customers/", "csv")

-- COMMAND ----------

CREATE OR REFRESH STREAMING LIVE TABLE customers
AS SELECT * FROM cloud_files("/databricks-datasets/retail-org/customers/", "csv")

-- COMMAND ----------

-- make sure that dbfs:/tmp/my_streaming_table is available before executing a DLT pipeline
-- databricks fs mkdirs dbfs:/tmp/my_streaming_table
-- databricks fs ls dbfs:/tmp/my_streaming_table

-- COMMAND ----------

-- Copy a file for schema inference
-- $ databricks fs cp 1.csv dbfs:/tmp/my_streaming_table
-- $ databricks fs ls dbfs:/tmp/my_streaming_table
-- 1.csv

-- COMMAND ----------

CREATE OR REFRESH STREAMING LIVE TABLE my_streaming_table
AS SELECT * FROM cloud_files("/tmp/my_streaming_table", "csv")
