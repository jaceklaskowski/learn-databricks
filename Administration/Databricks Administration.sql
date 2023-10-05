-- Databricks notebook source
-- MAGIC %md # Databricks Administration
-- MAGIC
-- MAGIC Commands and tricks to manage Databricks clusters

-- COMMAND ----------

-- MAGIC %scala
-- MAGIC
-- MAGIC println(s"""
-- MAGIC   |Spark version: ${sc.version}
-- MAGIC   |runtime_commit: ${org.apache.spark.BuildInfo.gitHash}
-- MAGIC   |universe_commit: ${com.databricks.BuildInfo.gitHash}
-- MAGIC """.stripMargin)

-- COMMAND ----------

-- MAGIC %py
-- MAGIC
-- MAGIC import os
-- MAGIC os.environ

-- COMMAND ----------

-- MAGIC %sh ls /databricks/spark

-- COMMAND ----------

-- MAGIC %sh cat /databricks/spark/VERSION

-- COMMAND ----------

-- MAGIC %sh ls /databricks/spark/conf

-- COMMAND ----------

-- MAGIC %sh cat /databricks/spark/conf/spark-env.sh
