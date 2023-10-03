# Databricks notebook source
# MAGIC %scala
# MAGIC
# MAGIC spark.range(5).createTempView("kevin_view_scala")

# COMMAND ----------

spark.table('kevin_view_scala')
