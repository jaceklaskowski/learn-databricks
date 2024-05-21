# Databricks notebook source
# MAGIC %md
# MAGIC
# MAGIC # Tables, Views and Materialized Views in Databricks

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## What's the diff between Table and View?

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC 1. Tables store data (and metadata)
# MAGIC     1. This was also a query and data is as fresh as the time the "underlying" query was executed at
# MAGIC     1. May quickly get outdated / stale
# MAGIC 1. Views are only computations stored in a catalog, e.g. Hive metastore (as part of metadata) = they will always be executed against some external data source
# MAGIC     1. it's going to be whatever tables could be created from
# MAGIC     1. Are **ALWAYS** fresh

# COMMAND ----------

# MAGIC %sql
# MAGIC CREATE VIEW user_lookup AS SELECT 1 as id

# COMMAND ----------

# MAGIC %sql
# MAGIC DESC EXTENDED user_lookup

# COMMAND ----------

# MAGIC %scala
# MAGIC
# MAGIC spark.sharedState.externalCatalog

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## What's the difference between Materialized Views and Views?

# COMMAND ----------

# MAGIC %md
# MAGIC **Materialized views** are computations with data
# MAGIC
# MAGIC 1. Like tables, they are outdated / stale
# MAGIC 1. Like tables, they've got data
# MAGIC 1. Like views, they have the computation they were defined with
# MAGIC
# MAGIC Materialized views are only available in Databricks SQL and now in Delta Live Tables

# COMMAND ----------

# MAGIC %md
# MAGIC ## Resources

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC 1. [Materialized Views by Databricks](https://www.databricks.com/glossary/materialized-views)
# MAGIC 1. [Use materialized views in Databricks SQL](https://docs.databricks.com/en/sql/user/materialized-views.html)
# MAGIC 1. [CREATE MATERIALIZED VIEW](https://docs.databricks.com/en/sql/language-manual/sql-ref-syntax-ddl-create-materialized-view.html)
