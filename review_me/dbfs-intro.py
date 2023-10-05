# Databricks notebook source
# MAGIC %py
# MAGIC
# MAGIC # this is NOT a Spark code (pyspark)
# MAGIC # We're about to load people dataset
# MAGIC spark.read.format('csv').load('/people.csv')

# COMMAND ----------

# MAGIC %fs ls dbfs:/FileStore/books.csv

# COMMAND ----------

# MAGIC %md ## cat

# COMMAND ----------

# MAGIC %fs cat dbfs:/FileStore/books.csv

# COMMAND ----------

dbutils.fs.head('dbfs:/FileStore/books.csv')

# COMMAND ----------

# MAGIC %fs head dbfs:/FileStore/books.csv

# COMMAND ----------

dbutils.help()

# COMMAND ----------

# MAGIC %sh ls /dbfs/FileStore
