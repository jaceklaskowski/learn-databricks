-- Databricks notebook source
-- MAGIC %md # Load Raw Data
-- MAGIC 
-- MAGIC This notebook uses an input parameter (using [Databricks widgets](https://docs.databricks.com/notebooks/widgets.html)).
-- MAGIC 
-- MAGIC Name | Default Value | Label
-- MAGIC -----|---------------|-------
-- MAGIC  `table_name` | workflows_raw_data | Table Name (Raw Data)
-- MAGIC  `database_name` | jaceklaskowski | Database Name
-- MAGIC 
-- MAGIC Unfortunatelly, [notebooks in jobs cannot use widgets](https://docs.databricks.com/notebooks/widgets.html#using-widget-values-in-spark-sql):
-- MAGIC 
-- MAGIC > In general, you cannot use widgets (...) if you use Run All or run the notebook as a job.
-- MAGIC 
-- MAGIC I thought I'm left with [task values](https://docs.databricks.com/workflows/jobs/how-to-share-task-values.html) only to pass arbitrary parameters between tasks in a Databricks job.
-- MAGIC 
-- MAGIC That's not really true as this notebook (and the accompanying Databricks Job) demonstrates.
-- MAGIC 
-- MAGIC Simply define 

-- COMMAND ----------

-- MAGIC %python
-- MAGIC 
-- MAGIC dbutils.jobs.taskValues.help()

-- COMMAND ----------

-- MAGIC %python
-- MAGIC 
-- MAGIC dbutils.jobs.taskValues.help("get")

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

-- The following does not seem to work
-- REMOVE WIDGET table_name;
-- CREATE WIDGET TEXT table_name DEFAULT "workflows_raw_data";

-- COMMAND ----------

CREATE DATABASE IF NOT EXISTS ${database_name};
USE ${database_name}

-- COMMAND ----------

SHOW TABLES

-- COMMAND ----------

-- MAGIC %md ## Create Raw Table
-- MAGIC 
-- MAGIC Learn more in [CREATE VIEW](https://docs.databricks.com/sql/language-manual/sql-ref-syntax-ddl-create-view.html)

-- COMMAND ----------

-- MAGIC %python
-- MAGIC 
-- MAGIC dbutils.widgets.getArgument("raw_table_name")

-- COMMAND ----------

-- Accessing widget value in SQL
-- Learn more in https://docs.databricks.com/notebooks/widgets.html
CREATE OR REPLACE VIEW ${raw_table_name}
  (id COMMENT 'Unique identification number', name)
COMMENT 'Bronze layer'
AS
  SELECT id, name
  FROM VALUES (0, "zero"), (1, "one") t(id, name)

-- COMMAND ----------

SELECT * FROM ${raw_table_name}

-- COMMAND ----------


