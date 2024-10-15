# Databricks notebook source
# MAGIC %md
# MAGIC
# MAGIC # For each Task

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Looping for Tasks in Databricks Workflows
# MAGIC
# MAGIC Use the For each task to run a task in a loop with a different set of parameters to each iteration of the task.
# MAGIC
# MAGIC Adding the For each task to a job requires two tasks:
# MAGIC
# MAGIC 1. The For each task
# MAGIC 1. A nested task

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Parameter Types
# MAGIC
# MAGIC A parameter of a nested task of For each task can be one of the following:
# MAGIC
# MAGIC 1. A JSON-formatted collection when you create or edit a task (e.g., `[1,2,3]`)
# MAGIC 1. A task value (`dbutils.jobs.taskValues`)
# MAGIC 1. A job parameter

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Reference Input Parameter in Nested Task
# MAGIC
# MAGIC To reference parameters passed from the For each task, click Parameters:
# MAGIC
# MAGIC 1. Use the `{{input}}` dynamic reference to set the value to the array value of each iteration.
# MAGIC 1. `{{input.<key>}}` to reference individual object fields when you iterate over a list of objects.

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Concurrency
# MAGIC
# MAGIC A For each task can specify `Concurrency` for the number of task iterations to run in parallel.
# MAGIC
# MAGIC `Concurrency` setting must be set between 1 and 100.
# MAGIC
# MAGIC By default, the concurrency is 1 and the nested tasks are run sequentially.
# MAGIC
# MAGIC ![Concurrency](./for_each_task_concurrency.png)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Demo
# MAGIC
# MAGIC 1. Create a new job
# MAGIC     * Use <a href="$./Load_googlesheets_csv">Load_googlesheets_csv</a> notebook as the starting point
# MAGIC     * Loads a CSV data and makes it available as a task value
# MAGIC 1. Define a For each task
# MAGIC     * Use <a href="$./For each Task Demo Nested Task">For each Task Demo Nested Task</a> notebook as the nested task
# MAGIC 1. Run the job

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Learn More
# MAGIC
# MAGIC 1. [Streamlining repetitive tasks in Databricks Workflows](https://www.databricks.com/blog/streamlining-repetitive-tasks-databricks-workflows)
# MAGIC 1. [Run a parameterized Databricks job task in a loop](https://docs.databricks.com/en/jobs/for-each.html)
# MAGIC 1. [Converting Stored Procedures to Databricks — The For Each Task](https://medium.com/dbsql-sme-engineering/converting-stored-procedures-to-databricks-the-for-each-task-028dd872fb34)
# MAGIC 1. [Databricks Workflow ‘For Each’ Task: Limitations and Workarounds](https://afroinfotech.medium.com/databricks-workflow-for-each-task-limitations-and-workarounds-41fa1b1a0cf4)
