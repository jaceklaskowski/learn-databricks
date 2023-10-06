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
# MAGIC
# MAGIC [Query parameters](https://docs.databricks.com/en/sql/user/queries/query-parameters.html)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC 1. Queries can be parameterized with curly brackets (`{{ table_pattern }}`)
# MAGIC 1. Substitute values into a query at runtime
# MAGIC 1. A widget appears above the results pane
# MAGIC 1. Query parameters are more flexible than query filters, and should only be used in cases where query filters are not sufficient
# MAGIC 1. `Cmd + I` to define a query parameter at the text caret
# MAGIC 1. Click **Apply Changes** to run a query with a parameter value

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ```sql
# MAGIC show tables like {{ table_pattern }}
# MAGIC ```
