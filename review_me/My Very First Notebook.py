# Databricks notebook source
dbutils.widgets.text(name='name', defaultValue='Jacek', label='Name')

# COMMAND ----------

table_name = dbutils.widgets.get('name')

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC # SQL

# COMMAND ----------

# MAGIC %sql
# MAGIC
# MAGIC SHOW SCHEMAS

# COMMAND ----------

# MAGIC %sql
# MAGIC
# MAGIC -- catalog'.'schema'.'table
# MAGIC -- database.table
# MAGIC SELECT '${name}'

# COMMAND ----------

# MAGIC %sql
# MAGIC
# MAGIC SHOW TABLES LIKE '${name}'

# COMMAND ----------

# MAGIC %sql
# MAGIC
# MAGIC SHOW TABLES LIKE '${name}'

# COMMAND ----------

# MAGIC %md # Some Python

# COMMAND ----------

print('Bonjour a tous !')

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC # Some Scala

# COMMAND ----------

# MAGIC %scala
# MAGIC println("How are you today?")

# COMMAND ----------

# MAGIC %md ## Questions

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC 1. Where to find notebooks?
