-- Databricks notebook source
-- MAGIC %md # Transform

-- COMMAND ----------

USE jaceklaskowski

-- COMMAND ----------

CREATE OR REPLACE VIEW workflows_transform
COMMENT 'Silver layer'
AS
  SELECT id, upper(name) name
  FROM workflows_raw_data

-- COMMAND ----------

SHOW VIEWS
