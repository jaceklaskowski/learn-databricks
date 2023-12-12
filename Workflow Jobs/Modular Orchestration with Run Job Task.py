# Databricks notebook source
# MAGIC %md # Modular Orchestration with Run Job Task

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC 1. Breaking down large complex workflows (DAGs) into logical chunks or smaller "child" jobs that are defined and managed separately
# MAGIC 1. parent and child jobs
# MAGIC 1. split a DAG up by organizational boundaries
# MAGIC     * allowing different teams in an organization to work together on different parts of a workflow
# MAGIC     * ownership of parts of the workflow can be better managed, with different teams potentially using different code repositories for the jobs they own
# MAGIC     * testing and updates covered by child job ownership
# MAGIC 1. reusability
# MAGIC     * define common shared steps in a job once and then reuse that as a child job in different parent workflows
# MAGIC     * With parameters, reused tasks can be made more flexible to fit the needs of different parent workflows
# MAGIC 1. Creates a modular workflow

# COMMAND ----------

# MAGIC %md ## Run Job
# MAGIC
# MAGIC 1. A new task type **Run Job**
# MAGIC     * Requires a job to trigger
# MAGIC 1. Calls a job to be run by the task
# MAGIC 1. Jobs triggered by a Run Job task use their own cluster configuration
# MAGIC     * [Trigger a new job run](https://docs.databricks.com/api/workspace/jobs/runnow)

# COMMAND ----------

# MAGIC %md ## Parameters
# MAGIC
# MAGIC 1. Enter the key and value of each job parameter to pass to a Run Job
# MAGIC 1. [Pass context about job runs into job tasks](https://docs.databricks.com/en/workflows/jobs/parameter-value-references.html)
# MAGIC     * Click **Browse dynamic values** for a list of available dynamic value references
# MAGIC 1. If job parameters are configured on the job a task belongs to, those parameters are displayed when you add task parameters.
# MAGIC     * If job and task parameters share a key, the job parameter takes precedence.
# MAGIC     * A warning is shown in the UI if you attempt to add a task parameter with the same key as a job parameter.
# MAGIC     * [Add parameters for all job tasks](https://docs.databricks.com/en/workflows/jobs/settings.html#add-parameters-for-all-job-tasks)

# COMMAND ----------

# MAGIC %md ## Task Queueing
# MAGIC
# MAGIC 1. A workspace is limited to 1000 concurrent task runs. A 429 Too Many Requests response is returned when you request a run that cannot start immediately.
# MAGIC 1. The number of jobs a workspace can create in an hour is limited to 10000 (includes “runs submit”). This limit also affects jobs created by the REST API and notebook workflows.

# COMMAND ----------

# MAGIC %md ## Gotchas
# MAGIC
# MAGIC 1. You should not create jobs with circular dependencies or jobs that nest more than three Run Job tasks.
# MAGIC 1. Circular dependencies are Run Job tasks that directly or indirectly trigger each other.
# MAGIC 1. A run is queued when the maximum concurrent Run Job task runs in the workspace is reached (see [What if my job cannot run because of concurrency limits?](https://docs.databricks.com/en/workflows/jobs/create-run-jobs.html#what-if-my-job-cannot-run-because-of-concurrency-limits))

# COMMAND ----------

# MAGIC %md ## Learn More
# MAGIC
# MAGIC 1. [Modular Orchestration with Databricks Workflows](https://www.databricks.com/blog/modular-orchestration-databricks-workflows)
# MAGIC 1. [Task type options](https://docs.databricks.com/en/workflows/jobs/create-run-jobs.html#task-type-options)
