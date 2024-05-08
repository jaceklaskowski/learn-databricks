-- Databricks notebook source
-- MAGIC %md # Load Raw Data
-- MAGIC
-- MAGIC This notebook uses an input parameter (using [Databricks widgets](https://docs.databricks.com/notebooks/widgets.html)).
-- MAGIC
-- MAGIC Name | Default Value | Label
-- MAGIC -----|---------------|-------
-- MAGIC  `table_name` | workflows_raw_data | Table Name (Raw Data)
-- MAGIC  `database_name` | jaceklaskowski | Database Name

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC **NOTE**:
-- MAGIC
-- MAGIC > Do not use `Run all` button to run all the cells.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC [Databricks widgets](https://docs.databricks.com/notebooks/widgets.html) describes how to access widgets values in Spark SQL.
-- MAGIC
-- MAGIC
-- MAGIC Unfortunatelly, [notebooks in jobs cannot use widgets](https://docs.databricks.com/notebooks/widgets.html#using-widget-values-in-spark-sql):
-- MAGIC
-- MAGIC > In general, you cannot use widgets (...) if you use Run All or run the notebook as a job.
-- MAGIC
-- MAGIC There are a couple of issues to keep in mind, esp. while doing a demo:
-- MAGIC
-- MAGIC 1. In general, you cannot use widgets to pass arguments between different languages within a notebook
-- MAGIC 1. You can create a widget `arg1` in a Python cell and use it in a SQL or Scala cell only if you run one cell at a time.
-- MAGIC 1. Using widget values between different languages does not work if you use **Run All** or run the notebook as a job

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

CREATE OR REPLACE VIEW ${raw_table_name}
  (id COMMENT 'Unique identification number', name)
COMMENT 'Bronze layer'
AS
  SELECT id, name
  FROM VALUES (0, "zero"), (1, "one") t(id, name)

-- COMMAND ----------

SELECT * FROM ${raw_table_name}
