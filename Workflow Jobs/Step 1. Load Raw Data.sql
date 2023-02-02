-- Databricks notebook source
-- MAGIC %md # Load Raw Data

-- COMMAND ----------

-- MAGIC %python
-- MAGIC 
-- MAGIC spark.version

-- COMMAND ----------

CREATE DATABASE IF NOT EXISTS jaceklaskowski;
USE jaceklaskowski

-- COMMAND ----------

SHOW TABLES

-- COMMAND ----------

-- MAGIC %md ## Create workflows_raw_data
-- MAGIC 
-- MAGIC Learn more in [CREATE VIEW](https://docs.databricks.com/sql/language-manual/sql-ref-syntax-ddl-create-view.html)

-- COMMAND ----------

CREATE OR REPLACE VIEW workflows_raw_data
  (id COMMENT 'Unique identification number', name)
COMMENT 'Bronze layer'
AS
  SELECT id, name
  FROM VALUES (0, "zero"), (1, "one") t(id, name)

-- COMMAND ----------

SELECT * FROM workflows_raw_data
