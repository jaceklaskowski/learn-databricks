# Databricks notebook source
# MAGIC %md
# MAGIC
# MAGIC # Nested Task

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC This notebook is a **nested task** used as part of a For each task in the For each Task demo.
# MAGIC
# MAGIC 1. The nested task is the task to run for each iteration of the For each task.
# MAGIC 1. Can be one of the standard Databricks Jobs task types.
# MAGIC 1. Cannot be another For each task.

# COMMAND ----------

single_csv_line = dbutils.widgets.get("single_csv_line")
print(single_csv_line)
