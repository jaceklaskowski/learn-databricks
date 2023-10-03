-- Databricks notebook source
-- MAGIC %md # Deep Dive into DLTs

-- COMMAND ----------

-- MAGIC %py
-- MAGIC
-- MAGIC dbutils.widgets.text(
-- MAGIC     name='storage_location',
-- MAGIC     defaultValue='Please specify Storage location',
-- MAGIC     label='Storage location')

-- COMMAND ----------

-- MAGIC %py
-- MAGIC
-- MAGIC storage_location = dbutils.widgets.get('storage_location')

-- COMMAND ----------

-- MAGIC %python
-- MAGIC
-- MAGIC # %fs ls dbfs:/pipelines/75fb9324-5321-4be6-b9ca-a3a8f9b47a9b
-- MAGIC display(dbutils.fs.ls(storage_location))

-- COMMAND ----------

-- MAGIC %python
-- MAGIC
-- MAGIC # %fs ls dbfs:/pipelines/75fb9324-5321-4be6-b9ca-a3a8f9b47a9b/tables/
-- MAGIC display(dbutils.fs.ls(f'{storage_location}/tables'))

-- COMMAND ----------

SELECT '${storage_location}'

-- COMMAND ----------

select * from delta.`${storage_location}/system/events`

-- COMMAND ----------

DESCRIBE HISTORY delta.`${storage_location}/system/events`

-- COMMAND ----------

SELECT count(*) FROM delta.`${storage_location}/system/events`@v524
