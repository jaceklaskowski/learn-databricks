# Databricks notebook source
# MAGIC %md # PySpark

# COMMAND ----------

# MAGIC %md # Create DataFrame From NumPy Array

# COMMAND ----------

# MAGIC %pip install numpy matplotlib scipy

# COMMAND ----------

dbutils.library.restartPython()

# COMMAND ----------

# https://realpython.com/preview/numpy-random-normal/
import numpy as np
rng = np.random.default_rng()
numbers = rng.normal(size=10_000)
nums = spark.createDataFrame(numbers)
display(nums)

# COMMAND ----------

# MAGIC %md # Standard Functions
# MAGIC
# MAGIC [pyspark.sql.functions](https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/functions.html)

# COMMAND ----------

# MAGIC %md # Basic Aggregation with pandas UDFs

# COMMAND ----------

import pandas as pd
from pyspark.sql.functions import pandas_udf

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC Learn more about [pandas.Series](https://pandas.pydata.org/docs/reference/api/pandas.Series.html).

# COMMAND ----------

@pandas_udf(returnType = "long")
def group_id(vs: pd.Series) -> pd.Series:
    return (vs.abs() * 1000).round() % 2

# COMMAND ----------

with_gid = nums.withColumn("gid", group_id(nums.value))
display(with_gid)

# COMMAND ----------

display(with_gid.groupby("gid").count())

# COMMAND ----------

@pandas_udf(returnType = "long")
def my_count(s: pd.Series) -> 'long':
    return pd.Series(s.count())

# COMMAND ----------

grouped_nums = with_gid.groupBy("gid")
count_by_gid_agg = my_count("gid").alias("count")
counts_by_gid = grouped_nums.agg(count_by_gid_agg)

# COMMAND ----------

display(counts_by_gid)

# COMMAND ----------

# MAGIC %md # DataFrame Partitions
# MAGIC
# MAGIC [pyspark.sql.functions.spark_partition_id](https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/api/pyspark.sql.functions.spark_partition_id.html#pyspark.sql.functions.spark_partition_id)

# COMMAND ----------

from pyspark.sql.functions import spark_partition_id

display(counts_by_gid.withColumn("spark_partition_id", spark_partition_id()))
