# Databricks notebook source
# MAGIC %md
# MAGIC
# MAGIC # Delta Live Tables Python API

# COMMAND ----------

# MAGIC %md ## dlt Module
# MAGIC
# MAGIC Delta Live Tables Python functions are defined in the `dlt` module
# MAGIC
# MAGIC ```py
# MAGIC import dlt
# MAGIC ```

# COMMAND ----------

# MAGIC %md ## @dlt.table Decorator
# MAGIC
# MAGIC Used to define tables (incl. streaming tables)

# COMMAND ----------

# MAGIC %md ## @dlt.view Decorator

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## How Dataflow Graph is Rendered
# MAGIC
# MAGIC * The Python `table` and `view` methods must return either a Spark or Koalas `DataFrame`
# MAGIC * DataFrame transformations are executed **after** the full dataflow graph has been resolved
# MAGIC * Non-`table` or `view` functions are executed once at the graph initialization phase

# COMMAND ----------

# MAGIC %md ## Learn More
# MAGIC
# MAGIC * [Delta Live Tables Python language reference](https://docs.databricks.com/en/delta-live-tables/python-ref.html)
