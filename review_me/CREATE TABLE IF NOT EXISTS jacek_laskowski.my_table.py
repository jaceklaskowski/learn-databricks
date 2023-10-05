# Databricks notebook source
# MAGIC %md # Day 1 Exercise One
# MAGIC
# MAGIC Create a table

# COMMAND ----------

# MAGIC %md ## Define Variable

# COMMAND ----------

# MAGIC %md ## Execute Code (Python)

# COMMAND ----------

dbutils.widgets.text(name='table_name', defaultValue='jacek_laskowski.my_table', label='Table Name')
table_name_param = dbutils.widgets.get('table_name')

# COMMAND ----------

print(f'Table name {table_name_param}')

# COMMAND ----------

# MAGIC %md ## Execute Code (Scala)

# COMMAND ----------

# MAGIC %scala
# MAGIC
# MAGIC val table_name_param = dbutils.widgets.get("table_name")

# COMMAND ----------

# MAGIC %scala
# MAGIC
# MAGIC println(s"Table name: $table_name_param")

# COMMAND ----------

# MAGIC %sql
# MAGIC
# MAGIC SHOW TABLES

# COMMAND ----------

# MAGIC %md ## Exercise / Question
# MAGIC
# MAGIC Change (find the way how to do it) the default schema to be `main`.

# COMMAND ----------

# MAGIC %sql
# MAGIC
# MAGIC CREATE SCHEMA IF NOT EXISTS jacek_laskowski

# COMMAND ----------

# MAGIC %sql
# MAGIC
# MAGIC CREATE TABLE IF NOT EXISTS ${table_name} (
# MAGIC   id LONG,
# MAGIC   name STRING
# MAGIC )
# MAGIC USING delta

# COMMAND ----------

# MAGIC %sql
# MAGIC
# MAGIC SHOW TABLES IN jacek_laskowski

# COMMAND ----------

# MAGIC %sql
# MAGIC
# MAGIC SELECT * FROM ${table_name}
