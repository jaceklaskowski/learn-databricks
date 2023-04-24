# Databricks notebook source
# MAGIC %pip install numpy matplotlib scipy

# COMMAND ----------

dbutils.library.restartPython()

# COMMAND ----------

# https://realpython.com/preview/numpy-random-normal/
import numpy as np
rng = np.random.default_rng()
numbers = rng.normal(size=10_000)
display(spark.createDataFrame(numbers))

# COMMAND ----------


