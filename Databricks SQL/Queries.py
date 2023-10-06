# Databricks notebook source
# MAGIC %md # Databricks SQL » Queries

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC 1. Queries are associated with a catalog and a schema
# MAGIC 1. Queries can be used as tasks in Workflow jobs (see [Workflow Jobs]($../Workflow Jobs/Databricks Jobs))
# MAGIC 1. The results of executing queries can be added to dashboards (see [Dashboards]($./Dashboards))

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ```sql
# MAGIC SELECT
# MAGIC   *
# MAGIC FROM
# MAGIC   book_ranks
# MAGIC WHERE
# MAGIC   book_rank in (1, 2)
# MAGIC ```

# COMMAND ----------

# MAGIC %md ## Parametrized Queries

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC 1. Queries can be parameterized with curly brackets (`{{ table_pattern }}`)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ```sql
# MAGIC show tables like {{ table_pattern }}
# MAGIC ```
