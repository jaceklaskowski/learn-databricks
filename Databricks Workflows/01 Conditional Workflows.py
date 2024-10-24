# Databricks notebook source
# MAGIC %md
# MAGIC
# MAGIC # Conditional Workflows

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Conditional Tasks
# MAGIC
# MAGIC `if/else condition` task is used to run a part of a job DAG based on the results of a boolean expression.
# MAGIC
# MAGIC Adds branching logic to your job
# MAGIC
# MAGIC [Add branching logic to your job with the If/else condition task](https://docs.databricks.com/en/workflows/jobs/conditional-tasks.html#add-branching-logic-to-your-job-with-the-ifelse-condition-task):
# MAGIC
# MAGIC 1. Runs a part of a job DAG based on a boolean expression
# MAGIC 1. The expression consists of a boolean operator and a pair of operands, where the operands might reference job or task state using [job and task parameter variables](https://docs.databricks.com/en/workflows/jobs/parameter-value-references.html) or use [task values](https://docs.databricks.com/en/workflows/jobs/share-task-context.html).
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Run if dependencies
# MAGIC
# MAGIC [Add the Run if condition of a task](https://docs.databricks.com/en/workflows/jobs/conditional-tasks.html#add-the-run-if-condition-of-a-task):
# MAGIC
# MAGIC 1. Adds conditions to a task
# MAGIC 1. `Run if dependencies` drop-down menu in the task configuration
# MAGIC 1. Condition is evaluated after completing all the task dependencies

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Conditional Execution
# MAGIC
# MAGIC 1. Tasks configured to handle failures or not meeting if/else condition are marked as Excluded.
# MAGIC 1. Excluded tasks are skipped and are treated as successful.
# MAGIC 1. If all task dependencies are excluded, the task is also excluded, regardless of its Run if condition.
# MAGIC 1. If you cancel a task run, the cancellation propagates through downstream tasks, and tasks with a Run if condition that handles failure are run, for example, to verify a cleanup task runs when a task run is canceled.

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Job Run Status
# MAGIC
# MAGIC [How does Databricks Jobs determine job run status?](https://docs.databricks.com/en/workflows/jobs/conditional-tasks.html#how-does-databricks-jobs-determine-job-run-status)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Learn More

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC 1. [Run tasks conditionally in a Databricks job](https://docs.databricks.com/en/workflows/jobs/conditional-tasks.html)
