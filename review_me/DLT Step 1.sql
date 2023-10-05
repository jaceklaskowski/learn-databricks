-- Databricks notebook source
CREATE LIVE TABLE five_row_table
AS SELECT * FROM range(0, 5)

-- COMMAND ----------

CREATE LIVE TABLE all_rows_multiplied_by_5
AS SELECT id * 5 id FROM live.five_row_table

-- COMMAND ----------

-- MAGIC %py
-- MAGIC
-- MAGIC # A regular PySpark data loading pattern
-- MAGIC # dataframe = spark.read.format('csv').option('header', True).load('dbfs:/FileStore/books.csv')
-- MAGIC # display(dataframe)
-- MAGIC
-- MAGIC # What am I supposed to do with the two below
-- MAGIC # to create a DLT live table in Python?
-- MAGIC
-- MAGIC # @dlt.table Decorator
-- MAGIC # The Python table and view functions must return a DataFrame
-- MAGIC
-- MAGIC from pyspark.sql import DataFrame
-- MAGIC import dlt
-- MAGIC
-- MAGIC # decorators beg for methods
-- MAGIC
-- MAGIC # A DLT data loading pattern
-- MAGIC
-- MAGIC @dlt.table
-- MAGIC def python_in_sql() -> DataFrame:
-- MAGIC     return spark.read.format('csv').option('header', True).load('dbfs:/FileStore/books.csv')
