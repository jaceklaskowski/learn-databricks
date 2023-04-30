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

# MAGIC %md # Basic Aggregation with pandas UDFs

# COMMAND ----------

import pandas as pd
from pyspark.sql.functions import pandas_udf

# COMMAND ----------

@pandas_udf(returnType = "long")
def my_count(s: pd.Series) -> 'long':
    return pd.Series(s.count())

# COMMAND ----------

from pyspark.sql.functions import abs
grouped_nums = (nums
    .withColumn("gid", abs((nums.value * 100) % 2))
    .groupBy("gid"))
count_by_gid_agg = my_count("gid").alias("count")
counts_by_gid = grouped_nums.agg(count_by_gid_agg)

# COMMAND ----------

display(counts_by_gid)
