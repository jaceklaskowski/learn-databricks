# Databricks notebook source
# MAGIC %md # Data Visualization on Databricks

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC Inspired by the course [Introduction to Python for Data Science and Data Engineering](https://www.databricks.com/training/catalog/introduction-to-python-for-data-science-and-data-engineering-969)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## pandas

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ### pandas.core.frame.DataFrame

# COMMAND ----------

import pandas as pd

# COMMAND ----------

pd.__version__

# COMMAND ----------

# MAGIC %pip install --upgrade pandas

# COMMAND ----------

dbutils.library.restartPython()

# COMMAND ----------

import pandas as pd
pd.__version__

# COMMAND ----------

# data = a list of lists
data = [
    [0, 'she',  'She Senior Dev'],
    [1, 'he',   'He Junior Dev'],
    [2, 'them', 'Them Python Dev'],
]
columns = ['id', 'name', 'role']

# COMMAND ----------

pandas_dataframe = pd.DataFrame(data=data, columns=columns)

# COMMAND ----------

type(pandas_dataframe)

# COMMAND ----------

display(pandas_dataframe)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ### pandas.core.series.Series

# COMMAND ----------

type(pandas_dataframe['id'])

# COMMAND ----------

display(pandas_dataframe['id'])

# COMMAND ----------

# Good ol' map in Functional Programming (FP)
pandas_dataframe['id'] + 1 * 2

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Spark SQL

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ### DataFrame

# COMMAND ----------

# Guess what happens in PySpark with no data provided for a cell
schema='id long, name string, role string'
pyspark_dataframe = spark.createDataFrame(data=data, schema=schema)

# COMMAND ----------

type(pyspark_dataframe)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Databricks Built-in Visualizations

# COMMAND ----------

display(pyspark_dataframe)

# COMMAND ----------

display(pyspark_dataframe)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Python Visualization Libraries

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC On Day 2 of the [Introduction to Python for Data Science and Data Engineering](https://www.databricks.com/training/catalog/introduction-to-python-for-data-science-and-data-engineering-969) course, Databricks introduces [pandas.DataFrame.hist](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.hist.html).
# MAGIC
# MAGIC > A histogram is a representation of the distribution of data. This function calls `matplotlib.pyplot.hist()`, on each series in the DataFrame, resulting in one histogram per column.

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC In the highly-applauded book by the author of pandas [Python for Data Analysis: Data Wrangling with pandas, NumPy, and Jupyter](https://www.amazon.com/Python-Data-Analysis-Wrangling-Jupyter-dp-109810403X/dp/109810403X), one of the take-aways is:
# MAGIC
# MAGIC > Create informative visualizations with matplotlib

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Matplotlib
# MAGIC
# MAGIC [Matplotlib: Visualization with Python](https://matplotlib.org/):
# MAGIC
# MAGIC > **Matplotlib** is a comprehensive library for creating static, animated, and interactive visualizations in Python. Matplotlib makes easy things easy and hard things possible.

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## pandas.DataFrame.hist

# COMMAND ----------

pandas_dataframe['id'].hist()

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Seaborn
# MAGIC
# MAGIC [seaborn: statistical data visualization](https://seaborn.pydata.org/):
# MAGIC
# MAGIC > **Seaborn** is a Python data visualization library based on [matplotlib](https://matplotlib.org/). It provides a high-level interface for drawing attractive and informative statistical graphics.

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Visualizations in Databricks notebooks
# MAGIC
# MAGIC Based on Databricks' [Visualizations in Databricks notebooks](https://docs.databricks.com/en/visualizations/index.html):
# MAGIC
# MAGIC * Databricks has built-in support for charts and visualizations in both Databricks SQL and in notebooks
# MAGIC * To create a visualization, click `+` above the result and select Visualization
# MAGIC * If you hover over the top right of a chart in the visualization editor, a Plotly toolbar appears with operations such as select, zoom, and pan
# MAGIC * Click the downward pointing arrow at the right of the tab name for the following operations on a visualization:
# MAGIC     * Download
# MAGIC     * Remove
# MAGIC     * Duplicate
# MAGIC     * Rename
# MAGIC     * Add to dashboard
# MAGIC * You can change the name of a visualization by clicking directly and editing the name in place
# MAGIC * You can edit a visualization

# COMMAND ----------

bikes = spark.read.csv("/databricks-datasets/bikeSharing/data-001/day.csv", header="true", inferSchema="true")
display(bikes)
