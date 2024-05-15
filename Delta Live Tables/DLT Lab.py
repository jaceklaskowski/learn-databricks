# Databricks notebook source
# MAGIC %md # DLT Lab

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC 1. Create a 3-table DLT pipeline
# MAGIC     1. 3 tables for each layer (bronze, silver, gold)
# MAGIC     1. A DLT pipeline based on 1 (at least) or (better / highly recommended) many notebooks
# MAGIC 1. `CREATE TABLE` regular table (non-live) that you can use to `INSERT` records into so your pipeline can digest it and do all the transformations
# MAGIC     1. Think of JSON-encoded medical records
# MAGIC     1. A raw table = JSON intact
# MAGIC     1. A silver table = JSON flatten out (`explode` standard function + `:` JSON access pattern)
# MAGIC     1. A(nother) silver table = some unification (e.g. LonDON, london, LONDON)
# MAGIC     1. A Gold table = some aggs (`count`s = how many people live in different cities or hobbies)
