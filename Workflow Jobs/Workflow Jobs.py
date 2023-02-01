# Databricks notebook source
# MAGIC %md # Orchestration with Databricks Workflow Jobs
# MAGIC 
# MAGIC This notebook is based on the [Data Engineer Learning Path by Databricks Academy](https://github.com/databricks-academy/data-engineer-learning-path) (specifically, [05 - Workflow Jobs](https://github.com/databricks-academy/data-engineer-learning-path/tree/published/05%20-%20Workflow%20Jobs)).

# COMMAND ----------

# MAGIC %md ## Concepts
# MAGIC 
# MAGIC 1. **Databricks Workflows** used as a product name
# MAGIC 1. A task orchestration workflow
# MAGIC 1. Monitoring and debugging features

# COMMAND ----------

# MAGIC %md ## Databricks Workflows
# MAGIC 
# MAGIC * a fully-managed, cloud-based, general-purpose task orchestration service
# MAGIC     * There are two task orchestration services: **Workflow Jobs (Workflows)** and **Delta Live Tables (DLT)**
# MAGIC     * DLTs can be a task in Workflows
# MAGIC * Data pipelines without managing any infrastructure
# MAGIC * a service for data engineers, data scientists and analysts to build reliable data, analytics and AI workflows on any cloud.
# MAGIC * enables all data teams to orchestrate any combination of tasks, such as notebooks, SQL, ML models and python code
# MAGIC * Part of the Databricks platform with data governance and monitoring services

# COMMAND ----------

# MAGIC %md ## Run other jobs with the new 'Run Job' task
# MAGIC 
# MAGIC By using the new 'Run Job' task in your job, you can orchestrate other jobs. This allows you to reuse generic jobs with parameters, as well as split up large jobs into smaller, modular pieces.
# MAGIC 
# MAGIC ![Run Job Task](workflows-run-job-task.png)
