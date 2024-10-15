# Databricks notebook source
# MAGIC %md
# MAGIC
# MAGIC # Tips and Tricks

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## List Resources
# MAGIC
# MAGIC There's no command line option to list the resources managed in a DAB project.
# MAGIC
# MAGIC Use [jq](https://jqlang.github.io/jq/) and [keys](https://jqlang.github.io/jq/manual/#keys-keys_unsorted).
# MAGIC
# MAGIC [How to get key names from JSON using jq](https://stackoverflow.com/q/23118341/1305344)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ``` console
# MAGIC $ databricks bundle validate --output json | jq '.resources | keys'
# MAGIC [
# MAGIC   "jobs"
# MAGIC ]
# MAGIC ```

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ``` console
# MAGIC $ databricks bundle validate --output json | jq '.resources.jobs | keys'
# MAGIC [
# MAGIC   "my_job"
# MAGIC ]
# MAGIC ```
