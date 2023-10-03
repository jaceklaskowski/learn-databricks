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

source_path = 'dbfs:/FileStore/books.csv'

# COMMAND ----------

import dlt
from pyspark.sql import DataFrame

@dlt.table
def books() -> DataFrame:
    return spark \
        .read \
        .option('header', True) \
        .option('inferSchema', True) \
        .csv(source_path)
