-- Databricks notebook source
-- MAGIC %md # Table-Valued Functions
-- MAGIC
-- MAGIC [The Internals of Spark SQL](https://books.japila.pl/spark-sql-internals/table-valued-functions/)

-- COMMAND ----------

-- MAGIC %python
-- MAGIC
-- MAGIC import os
-- MAGIC print('DATABRICKS_RUNTIME_VERSION:', os.environ.get('DATABRICKS_RUNTIME_VERSION', '(undefined)'))

-- COMMAND ----------

-- MAGIC %scala
-- MAGIC
-- MAGIC import org.apache.spark.sql.catalyst.analysis.TableFunctionRegistry
-- MAGIC display(TableFunctionRegistry.builtin.listFunction.map(_.funcName).sorted.toDF("Table-Valued Function"))

-- COMMAND ----------

-- MAGIC %fs mkdirs /tmp/jacek-laskowski

-- COMMAND ----------

select * from read_files("/tmp/jacek-laskowski")

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Databricks TVFs
-- MAGIC
-- MAGIC [Alphabetical list of built-in functions](https://docs.databricks.com/en/sql/language-manual/sql-ref-functions-builtin-alpha.html)
