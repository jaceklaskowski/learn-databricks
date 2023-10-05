# Databricks notebook source
# MAGIC %md # Exercise: Finding 1st and 2nd Bestsellers Per Genre

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC This is a DLT pipeline for [Exercise: Finding 1st and 2nd Bestsellers Per Genre](https://jaceklaskowski.github.io/spark-workshop/exercises/sql/Finding-1st-and-2nd-Bestsellers-Per-Genre.html).

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC 1. Create a live table (with a raw data) = `books` table

# COMMAND ----------

import dlt
from pyspark.sql import DataFrame

@dlt.table
def books() -> DataFrame:
    return spark.range(4)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC -- CREATE TABLE jacek_laskowski.books
# MAGIC -- OPTIONS (header=true)
# MAGIC -- AS SELECT * FROM csv.`/FileStore/books.csv`

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC -- SELECT * FROM jacek_laskowski.books

# COMMAND ----------

# MAGIC %sql
# MAGIC -- CREATE LIVE TABLE books
# MAGIC -- OPTIONS (header=true)
# MAGIC -- AS SELECT * FROM csv.`/FileStore/books.csv`

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC %scala
# MAGIC
# MAGIC val books = spark
# MAGIC   .read
# MAGIC   .option("header", true)
# MAGIC   .option("inferSchema", true)
# MAGIC   .csv("/FileStore/books.csv")
# MAGIC books.schema
