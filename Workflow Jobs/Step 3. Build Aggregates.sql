-- Databricks notebook source
-- MAGIC %md # Build Aggregates
-- MAGIC 
-- MAGIC ...for presentation layer

-- COMMAND ----------

USE jaceklaskowski

-- COMMAND ----------

CREATE OR REPLACE VIEW workflows_aggregates
COMMENT 'Golden layer'
AS
  SELECT length(name) % 2 gid, count(name) count, collect_set(name) names
  FROM workflows_transform
  GROUP BY 1

-- COMMAND ----------

SHOW VIEWS

-- COMMAND ----------

SELECT * FROM workflows_aggregates
