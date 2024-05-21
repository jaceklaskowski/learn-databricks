# Databricks notebook source
# MAGIC %md
# MAGIC
# MAGIC Define a Delta Live Tables dataset 
# MAGIC
# MAGIC It must return either a Spark or Koalas DataFrame.

# COMMAND ----------

import dlt
from pyspark.sql import DataFrame

@dlt.table()
def five_record_table() -> DataFrame:
    print('Hello world')
    return spark.range(5)
