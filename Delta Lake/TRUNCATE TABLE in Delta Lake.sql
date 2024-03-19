-- Databricks notebook source
-- MAGIC %md # TRUNCATE TABLE in Delta Lake

-- COMMAND ----------

DROP TABLE IF EXISTS jacek_demo

-- COMMAND ----------

CREATE TABLE jacek_demo
AS SELECT 1

-- COMMAND ----------

DESCRIBE HISTORY jacek_demo

-- COMMAND ----------

SELECT * FROM jacek_demo

-- COMMAND ----------

TRUNCATE TABLE jacek_demo

-- COMMAND ----------

DESCRIBE HISTORY jacek_demo

-- COMMAND ----------

SELECT * FROM jacek_demo

-- COMMAND ----------


