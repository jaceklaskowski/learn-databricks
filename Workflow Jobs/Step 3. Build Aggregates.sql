-- Databricks notebook source
-- MAGIC %md # Build Aggregates
-- MAGIC 
-- MAGIC ...for presentation layer

-- COMMAND ----------

-- MAGIC %python
-- MAGIC 
-- MAGIC # Creates a text input widget with a given name and default value.
-- MAGIC # Notebook Widgets are only for Run all (when executed outside a job)
-- MAGIC dbutils.widgets.removeAll()
-- MAGIC dbutils.widgets.text(name = "database_name", defaultValue = "jaceklaskowski", label = "Database Name")
-- MAGIC dbutils.widgets.text(name = "raw_table_name", defaultValue = "workflows_raw_data", label = "Raw Table Name")
-- MAGIC dbutils.widgets.text(name = "silver_table_name", defaultValue = "workflows_transform", label = "Silver Table Name")
-- MAGIC dbutils.widgets.text(name = "gold_table_name", defaultValue = "workflows_aggregates", label = "Gold Table Name")

-- COMMAND ----------

USE ${database_name}

-- COMMAND ----------

CREATE OR REPLACE VIEW ${gold_table_name}
COMMENT 'Golden layer'
AS
  SELECT length(name) % 2 gid, count(name) count, collect_set(name) names
  FROM ${silver_table_name}
  GROUP BY 1

-- COMMAND ----------

SHOW VIEWS

-- COMMAND ----------

SELECT * FROM ${gold_table_name}
