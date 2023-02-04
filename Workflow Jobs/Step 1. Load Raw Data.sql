-- Databricks notebook source
-- MAGIC %md # Load Raw Data
-- MAGIC 
-- MAGIC This notebook uses an input parameter (using [Databricks widgets](https://docs.databricks.com/notebooks/widgets.html)).
-- MAGIC 
-- MAGIC Name | Default Value | Label
-- MAGIC -----|---------------|-------
-- MAGIC  `table_name` | workflows_raw_data | Table Name (Raw Data)

-- COMMAND ----------

-- MAGIC %python
-- MAGIC 
-- MAGIC # Creates a text input widget with a given name and default value.
-- MAGIC dbutils.widgets.removeAll()
-- MAGIC dbutils.widgets.text(name = "table_name", defaultValue = "workflows_raw_data", label = "Table Name (Raw Data)")

-- COMMAND ----------

-- The following does not seem to work
-- REMOVE WIDGET table_name;
-- CREATE WIDGET TEXT table_name DEFAULT "workflows_raw_data";

-- COMMAND ----------

CREATE DATABASE IF NOT EXISTS jaceklaskowski;
USE jaceklaskowski

-- COMMAND ----------

SHOW TABLES

-- COMMAND ----------

-- MAGIC %md ## Create Raw Table
-- MAGIC 
-- MAGIC Learn more in [CREATE VIEW](https://docs.databricks.com/sql/language-manual/sql-ref-syntax-ddl-create-view.html)

-- COMMAND ----------

-- MAGIC %python
-- MAGIC 
-- MAGIC dbutils.widgets.getArgument("table_name")

-- COMMAND ----------

-- Accessing widget value in SQL
-- Learn more in https://docs.databricks.com/notebooks/widgets.html
CREATE OR REPLACE VIEW ${table_name}
  (id COMMENT 'Unique identification number', name)
COMMENT 'Bronze layer'
AS
  SELECT id, name
  FROM VALUES (0, "zero"), (1, "one") t(id, name)

-- COMMAND ----------

SELECT * FROM ${table_name}
