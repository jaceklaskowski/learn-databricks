-- Databricks notebook source
-- MAGIC %md # Table-Valued Functions
-- MAGIC 
-- MAGIC [Table-Valued Functions](https://books.japila.pl/spark-sql-internals/table-valued-functions/)

-- COMMAND ----------

-- MAGIC %scala
-- MAGIC 
-- MAGIC println(spark.version)

-- COMMAND ----------

-- MAGIC %scala
-- MAGIC 
-- MAGIC import org.apache.spark.sql.catalyst.analysis.TableFunctionRegistry
-- MAGIC display(TableFunctionRegistry.builtin.listFunction.map(_.funcName).sorted.toDF("Table-Valued Function"))

-- COMMAND ----------

-- MAGIC %fs mkdirs /tmp/jacek-laskowski

-- COMMAND ----------

select * from read_files("/tmp/jacek-laskowski")
