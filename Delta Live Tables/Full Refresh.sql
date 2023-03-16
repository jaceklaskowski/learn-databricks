-- Databricks notebook source
-- MAGIC %md # Full Refresh
-- MAGIC 
-- MAGIC Let's deep dive into **Full Refresh** feature of DLTs.
-- MAGIC 
-- MAGIC You can trigger a full refresh of a DLT pipeline using:
-- MAGIC 
-- MAGIC * The Pipelines UI under **Start > Full refresh all**
-- MAGIC * Delta Live Tables CLI `databricks pipelines start --full-refresh`

-- COMMAND ----------

-- MAGIC %md ## DESCRIBE HISTORY

-- COMMAND ----------

USE jaceklaskowski_meetup

-- COMMAND ----------

SHOW TABLES;

-- COMMAND ----------

SELECT version, operation, operationParameters, readVersion, isolationLevel, isBlindAppend, operationMetrics, engineInfo
FROM (DESCRIBE HISTORY my_streaming_table)

-- COMMAND ----------

-- MAGIC %md ## Full Refresh All
-- MAGIC 
-- MAGIC ```console
-- MAGIC databricks pipelines start --full-refresh --pipeline-id 3a69ffe2-d42a-47b5-8731-84e7ffb3c844
-- MAGIC ```

-- COMMAND ----------

SELECT * FROM my_streaming_table

-- COMMAND ----------

-- MAGIC %md ## Demo
-- MAGIC 
-- MAGIC This demo shows Full refresh all to fix a header issue with Auto Loader in a DLT pipeline.
-- MAGIC 
-- MAGIC 1. Without `header` option, CSVs with headers are processed as if they had one record extra (the header)
-- MAGIC 1. Once fixed and Full refresh all, the Streaming table should have proper records
-- MAGIC 
-- MAGIC Use <a href="$my_streaming_table">my_streaming_table</a> notebook.

-- COMMAND ----------

SHOW TABLES in jaceklaskowski_meetup

-- COMMAND ----------

-- WRONG: Show all records, incl. headers
select * from jaceklaskowski_meetup.my_streaming_table

-- COMMAND ----------

-- CORRECT: Show all records with no headers this time
select * from jaceklaskowski_meetup.my_streaming_table
