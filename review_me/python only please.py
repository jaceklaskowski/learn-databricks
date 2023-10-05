# Databricks notebook source
# MAGIC %md # Create DLT Table (Live Table) using Python API

# COMMAND ----------

dbutils.widgets.text(name='filename', defaultValue='dbfs:/FileStore/books.csv')
filename = dbutils.widgets.get('filename')

# COMMAND ----------

import dlt

# COMMAND ----------

# MAGIC %py
# MAGIC
# MAGIC # A regular PySpark data loading pattern
# MAGIC # dataframe = spark.read.format('csv').option('header', True).load('dbfs:/FileStore/books.csv')
# MAGIC # display(dataframe)
# MAGIC
# MAGIC # What am I supposed to do with the two below
# MAGIC # to create a DLT live table in Python?
# MAGIC
# MAGIC # @dlt.table Decorator
# MAGIC # The Python table and view functions must return a DataFrame
# MAGIC
# MAGIC from pyspark.sql import DataFrame
# MAGIC
# MAGIC # decorators beg for methods
# MAGIC
# MAGIC # A DLT data loading pattern
# MAGIC
# MAGIC @dlt.table(name='raw_books')
# MAGIC def raw_load_csv() -> DataFrame:
# MAGIC     return spark.read.format('csv').option('header', True).load(filename)

# COMMAND ----------

@dlt.table
def silver_book_titles() -> DataFrame:
    # The following won't work as we renamed the table name using @dlt.table(name=...)
    # return spark.table('live.raw_load_csv').select('title')

    # This is how to access Spark property
    column_name = spark.conf.get('column_name')
    return spark.table('live.raw_books').select(column_name)

# COMMAND ----------

from pyspark.sql import functions as F


@dlt.table
def golden_upper_titles() -> DataFrame:
    return spark.table('live.silver_book_titles').select(F.upper('title').alias('upper_title'))

# COMMAND ----------

# MAGIC %sql
# MAGIC
# MAGIC CREATE LIVE TABLE sql_in_python
# MAGIC AS SELECT * FROM range(0, 5)

# COMMAND ----------

# MAGIC %sql
# MAGIC
# MAGIC show tables

# COMMAND ----------

from pyspark.sql import functions as F
spark.table('my_table').select(F.upper('name')).display()

# COMMAND ----------

# MAGIC %sql insert into my_table values (0, 'ania')

# COMMAND ----------


