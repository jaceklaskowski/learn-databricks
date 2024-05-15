# Databricks notebook source
# MAGIC %md # Pipeline settings
# MAGIC
# MAGIC Click the **Settings** button in the DLT UI
# MAGIC
# MAGIC There are two main UI settings views:
# MAGIC
# MAGIC 1. **UI** - a human-friendly view
# MAGIC 1. **JSON**
# MAGIC
# MAGIC There is one extra available under the three-dots menu:
# MAGIC
# MAGIC 1. **Pipeline settings YAML** that can be used with Databricks Asset Bundles to source control and apply CI/CD to pipelines.

# COMMAND ----------

# MAGIC %md
# MAGIC ## General

# COMMAND ----------

# MAGIC %md
# MAGIC ## Source code
# MAGIC
# MAGIC ➡️ [Configure source code libraries](https://docs.databricks.com/en/delta-live-tables/settings.html#select-a-cluster-policy)
# MAGIC
# MAGIC Use the file selector in the Delta Live Tables UI to configure the source code defining your pipeline.
# MAGIC
# MAGIC Pipeline source code is defined in Databricks notebooks or in SQL or Python scripts stored in workspace files.
# MAGIC
# MAGIC You can add one or more notebooks or workspace files or a combination of notebooks and workspace files.

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ```
# MAGIC "libraries": [
# MAGIC     {
# MAGIC         "notebook": {
# MAGIC             "path": "/Repos/jacek@japila.pl/learn-databricks/Delta Live Tables/delta-live-tables-bundle/five_record_table"
# MAGIC         }
# MAGIC     },
# MAGIC     {
# MAGIC         "file": {
# MAGIC             "path": "/Repos/jacek@japila.pl/learn-databricks/Delta Live Tables/delta-live-tables-bundle/bronze_table.sql"
# MAGIC         }
# MAGIC     }
# MAGIC ],
# MAGIC ```
