# Databricks notebook source
# MAGIC %md
# MAGIC
# MAGIC # Job and Task Parameters

# COMMAND ----------

# DBTITLE 0,job.yml
# MAGIC %md
# MAGIC
# MAGIC ```
# MAGIC resources:
# MAGIC   jobs:
# MAGIC     demo_job:
# MAGIC       name: demo_job
# MAGIC       description: My custom description that should describe the purpose of this job
# MAGIC       # https://docs.databricks.com/api/workspace/jobs/create#parameters
# MAGIC       # Job-level parameters
# MAGIC       parameters:
# MAGIC         - name: jacek_custom_variable
# MAGIC           default: FIXME_parameters
# MAGIC       tasks:
# MAGIC         - task_key: notebook_task
# MAGIC           existing_cluster_id: ${var.my-human-readable-name}
# MAGIC           notebook_task:
# MAGIC             notebook_path: ../src/notebook.ipynb
# MAGIC             # https://docs.databricks.com/api/workspace/jobs/create#tasks-notebook_task-base_parameters
# MAGIC             # Base parameters used for each run of this job
# MAGIC             # Parameters at job level take precedence
# MAGIC             # Use dbutils.widgets.get to access the value
# MAGIC             base_parameters:
# MAGIC               jacek_custom_variable: FIXME_base_parameters
# MAGIC ```
