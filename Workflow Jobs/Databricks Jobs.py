# Databricks notebook source
# MAGIC %md # Databricks Jobs
# MAGIC 
# MAGIC This notebook is based on the [Data Engineer Learning Path by Databricks Academy](https://github.com/databricks-academy/data-engineer-learning-path) (specifically, [05 - Workflow Jobs](https://github.com/databricks-academy/data-engineer-learning-path/tree/published/05%20-%20Workflow%20Jobs)).
# MAGIC 
# MAGIC Following on the naming convention in [Create, run, and manage Databricks Jobs](https://docs.databricks.com/workflows/jobs/jobs.html), this notebook uses **Databricks Jobs** as the name of the Databricks Workflows feature to be discussed.

# COMMAND ----------

# MAGIC %md ## Databricks Lakehouse
# MAGIC 
# MAGIC **Databricks Lakehouse** (also known as **Databricks Platform** or simply **Databricks**) is a SaaS-based data processing and AI platform solution with a hosted environment with Apache Spark (**Databricks Spark**), Delta Lake, MLflow.
# MAGIC 
# MAGIC Also, Databricks Lakehouse is a fully-managed, cloud-native data lakehouse service.
# MAGIC 
# MAGIC Google says: **SaaS** is a method of software delivery and licensing in which software is accessed online via a subscription (rather than bought and installed on individual computers).
# MAGIC 
# MAGIC For the purpose of this presentation (and perhaps in general), SaaS is the **cloud** (computing facilities providing remote data storage and processing services via the internet).

# COMMAND ----------

# MAGIC %md ## Databricks Workflows
# MAGIC 
# MAGIC * a fully-managed, cloud-based, general-purpose task orchestration (workflow) service
# MAGIC     * There are two task orchestration services: **Workflow Jobs (Workflows)** and **Delta Live Tables (DLT)**
# MAGIC     * DLTs can be a task in Workflows
# MAGIC * Data pipelines without managing any infrastructure
# MAGIC * a service for data engineers, data scientists and analysts to build reliable data, analytics and AI workflows on any cloud.
# MAGIC * enables all data teams to orchestrate any combination of tasks, such as notebooks, SQL, ML models and python code
# MAGIC * Part of the Databricks platform with data governance and monitoring services

# COMMAND ----------

# MAGIC %md ## Naming Conventions
# MAGIC 
# MAGIC From [Jan van der Vegt](https://www.linkedin.com/in/jan-van-der-vegt/), a PM working on Databricks Workflows:
# MAGIC 
# MAGIC > the product itself is now called **Databricks Workflows** and the DAGs are the **jobs**
# MAGIC 
# MAGIC > For referencing an instance we just use "Job". When talking about the product we say "Databricks Workflows".

# COMMAND ----------

# MAGIC %md ## Features
# MAGIC 
# MAGIC From [Create, run, and manage Databricks Jobs](https://docs.databricks.com/workflows/jobs/jobs.html):
# MAGIC 
# MAGIC 1. **A job** is a way to run a non-interactive code on a Databricks cluster (e.g. scheduled ETLs)
# MAGIC 1. Create and run jobs using the UI, the [Jobs CLI](https://docs.databricks.com/dev-tools/cli/jobs-cli.html), or by invoking the [Jobs API](https://docs.databricks.com/dev-tools/api/latest/jobs.html)
# MAGIC 1. Repair and re-run a failed or canceled job using the UI or API
# MAGIC 1. Monitor job run results using the UI, CLI, API, and notifications (for example, email, webhook destination, or Slack notifications)

# COMMAND ----------

# MAGIC %md ## Job 101
# MAGIC 
# MAGIC 1. job can consist of a single task or can be a large, multi-task workflow with complex dependencies
# MAGIC     * A job graph is a DAG
# MAGIC 1. Databricks manages the task orchestration, cluster management, monitoring, and error reporting
# MAGIC 1. Run jobs immediately or periodically through a scheduling system
# MAGIC 1. A task can be a JAR, a Databricks notebook, a Delta Live Tables pipeline, or an application written in Scala, Java, or Python. Legacy Spark Submit applications are also supported.
# MAGIC 1. control the execution order of tasks by specifying dependencies between the tasks
# MAGIC 1. Tasks can run in sequence or parallel
# MAGIC 1. create jobs only in a Data Science & Engineering workspace or a Machine Learning workspace
# MAGIC 1. Limits:
# MAGIC     * 1000 concurrent task runs
# MAGIC     * The number of jobs created per hour < 10000
# MAGIC 1. Many task types (e.g., notebook, DLT Pipeline, SQL, dbt)

# COMMAND ----------

# MAGIC %md ### New Job split-view authoring experience
# MAGIC 
# MAGIC Similarly to DLT UI, Jobs UI allows for editing your task while seeing your workflow.

# COMMAND ----------

# DBTITLE 1,Example DAG
# MAGIC %md ### Example DAG
# MAGIC 
# MAGIC ```json
# MAGIC {
# MAGIC     "name": "My Job",
# MAGIC     "email_notifications": {
# MAGIC         "no_alert_for_skipped_runs": false
# MAGIC     },
# MAGIC     "webhook_notifications": {},
# MAGIC     "timeout_seconds": 0,
# MAGIC     "max_concurrent_runs": 1,
# MAGIC     "tasks": [
# MAGIC         {
# MAGIC             "task_key": "Load_Raw_Data",
# MAGIC             "notebook_task": {
# MAGIC                 "notebook_path": "/Repos/jacek@japila.pl/learn-databricks/Workflow Jobs/Step 1. Load Raw Data",
# MAGIC                 "base_parameters": {
# MAGIC                     "city": "warsaw",
# MAGIC                     "date": "2023-02-01"
# MAGIC                 },
# MAGIC                 "source": "WORKSPACE"
# MAGIC             },
# MAGIC             "job_cluster_key": "Shared_job_cluster",
# MAGIC             "timeout_seconds": 0,
# MAGIC             "email_notifications": {
# MAGIC                 "on_start": [
# MAGIC                     "jacek@japila.pl"
# MAGIC                 ],
# MAGIC                 "on_success": [
# MAGIC                     "jacek@japila.pl"
# MAGIC                 ],
# MAGIC                 "on_failure": [
# MAGIC                     "jacek@japila.pl"
# MAGIC                 ]
# MAGIC             }
# MAGIC         },
# MAGIC         {
# MAGIC             "task_key": "Transform",
# MAGIC             "depends_on": [
# MAGIC                 {
# MAGIC                     "task_key": "Load_Raw_Data"
# MAGIC                 }
# MAGIC             ],
# MAGIC             "notebook_task": {
# MAGIC                 "notebook_path": "/Repos/jacek@japila.pl/learn-databricks/Workflow Jobs/Step 2. Transform",
# MAGIC                 "source": "WORKSPACE"
# MAGIC             },
# MAGIC             "job_cluster_key": "Shared_job_cluster",
# MAGIC             "timeout_seconds": 0,
# MAGIC             "email_notifications": {}
# MAGIC         },
# MAGIC         {
# MAGIC             "task_key": "Build_Aggregates",
# MAGIC             "depends_on": [
# MAGIC                 {
# MAGIC                     "task_key": "Transform"
# MAGIC                 }
# MAGIC             ],
# MAGIC             "notebook_task": {
# MAGIC                 "notebook_path": "/Repos/jacek@japila.pl/learn-databricks/Workflow Jobs/Step 3. Build Aggregates",
# MAGIC                 "source": "WORKSPACE"
# MAGIC             },
# MAGIC             "job_cluster_key": "Shared_job_cluster",
# MAGIC             "timeout_seconds": 0,
# MAGIC             "email_notifications": {}
# MAGIC         }
# MAGIC     ],
# MAGIC     "job_clusters": [
# MAGIC         {
# MAGIC             "job_cluster_key": "Shared_job_cluster",
# MAGIC             "new_cluster": {
# MAGIC                 "cluster_name": "",
# MAGIC                 "spark_version": "11.3.x-scala2.12",
# MAGIC                 "aws_attributes": {
# MAGIC                     "first_on_demand": 1,
# MAGIC                     "availability": "SPOT_WITH_FALLBACK",
# MAGIC                     "zone_id": "us-west-2a",
# MAGIC                     "spot_bid_price_percent": 100,
# MAGIC                     "ebs_volume_count": 0
# MAGIC                 },
# MAGIC                 "node_type_id": "i3.xlarge",
# MAGIC                 "spark_env_vars": {
# MAGIC                     "PYSPARK_PYTHON": "/databricks/python3/bin/python3"
# MAGIC                 },
# MAGIC                 "enable_elastic_disk": false,
# MAGIC                 "data_security_mode": "SINGLE_USER",
# MAGIC                 "runtime_engine": "STANDARD",
# MAGIC                 "num_workers": 8
# MAGIC             }
# MAGIC         }
# MAGIC     ],
# MAGIC     "tags": {
# MAGIC         "my_key": "my_value"
# MAGIC     },
# MAGIC     "format": "MULTI_TASK"
# MAGIC }
# MAGIC ```

# COMMAND ----------

# MAGIC %md
# MAGIC 
# MAGIC ## Share information between tasks in a Databricks job

# COMMAND ----------

# MAGIC %md
# MAGIC 
# MAGIC ### News
# MAGIC 
# MAGIC 1. [Databricks Workflows: Introducing DAG, Serverless Compute & trigger based flows](https://www.linkedin.com/pulse/databricks-workflows-introducing-dag-serverless-compute-dhondt/)
# MAGIC 1. [Easier creation and editing of Databricks jobs in the UI](https://docs.databricks.com/release-notes/product/2023/january.html#easier-creation-and-editing-of-databricks-jobs-in-the-ui)
# MAGIC 1. [Improvements to the Databricks Jobs UI when viewing job runs](https://docs.databricks.com/release-notes/product/2023/january.html#improvements-to-the-databricks-jobs-ui-when-viewing-job-runs)
# MAGIC 1. [Databricks ❤️ IDEs](https://www.databricks.com/blog/2023/02/14/announcing-a-native-visual-studio-code-experience-for-databricks.html)

# COMMAND ----------

# MAGIC %md
# MAGIC 
# MAGIC ### Parameterized Notebook Tasks with Input Widgets
# MAGIC 
# MAGIC 1. Input widgets allow you to add parameters to your notebooks and dashboards.
# MAGIC 1. Building a notebook or dashboard that is re-executed with different parameters
# MAGIC 1. `dbutils.widgets.help()`
# MAGIC 
# MAGIC Unfortunatelly, [notebooks in jobs cannot use widgets](https://docs.databricks.com/notebooks/widgets.html#using-widget-values-in-spark-sql):
# MAGIC 
# MAGIC > In general, you cannot use widgets (...) if you use Run All or run the notebook as a job.
# MAGIC 
# MAGIC Learn more:
# MAGIC 
# MAGIC * [Databricks widgets](https://docs.databricks.com/notebooks/widgets.html)
# MAGIC * [Databricks Widgets in SQL Notebook](https://pub.towardsai.net/databricks-widgets-in-sql-notebook-6c7cdbe47402)

# COMMAND ----------

# MAGIC %md
# MAGIC 
# MAGIC ### Task values
# MAGIC 
# MAGIC Learn more in [Share information between tasks in a Databricks job](https://docs.databricks.com/workflows/jobs/how-to-share-task-values.html)
# MAGIC 
# MAGIC There are two limitations of [dbutils.jobs.taskValues.get](https://docs.databricks.com/dev-tools/databricks-utils.html#get-command-dbutilsjobstaskvaluesget) command:
# MAGIC 
# MAGIC 1. Available only for Python (no SQL variant)
# MAGIC 1. Gets the contents of the specified task value for the **specified task** in the current job run
# MAGIC 
# MAGIC How to pass in arguments to "opening" notebooks in Databricks Jobs? [You can pass parameters for your task](https://docs.databricks.com/workflows/jobs/jobs.html#create-a-job).
# MAGIC 
# MAGIC > **Notebook**: Click **Add** and specify the key and value of each parameter to pass to the task. You can override or add additional parameters when you manually run a task using the Run a job with different parameters option. Parameters set the value of the [notebook widget](https://docs.databricks.com/notebooks/widgets.html) specified by the key of the parameter. Use task parameter variables to pass a limited set of dynamic values as part of a parameter value.
# MAGIC 
# MAGIC What?! Notebook widgets again?!

# COMMAND ----------

# MAGIC %md
# MAGIC 
# MAGIC ## Run Job Task
# MAGIC 
# MAGIC By using the new 'Run Job' task in your job, you can orchestrate other jobs. This allows you to reuse generic jobs with parameters, as well as split up large jobs into smaller, modular pieces.
# MAGIC 
# MAGIC ![Run Job Task](workflows-run-job-task.png)

# COMMAND ----------

# MAGIC %md ## Schedule Job from Repo
# MAGIC 
# MAGIC You can now schedule a job from your repo. Visit Create Job and pick “Git” for the Source field.
# MAGIC 
# MAGIC Learn more in [Build Reliable Production Data and ML Pipelines With Git Support for Databricks Workflows](https://www.databricks.com/blog/2022/06/21/build-reliable-production-data-and-ml-pipelines-with-git-support-for-databricks-workflows.html)

# COMMAND ----------

# MAGIC %md ## Increase jobs limit
# MAGIC 
# MAGIC In [Databricks administration guide](https://docs.databricks.com/administration-guide/workspace/enable-increased-jobs-limit.html):
# MAGIC 
# MAGIC > By default, Databricks limits the number of jobs in a workspace based on the pricing tier.

# COMMAND ----------

# MAGIC %md ## Competition

# COMMAND ----------

# MAGIC %md ### Azure Data Factory
# MAGIC 
# MAGIC [Introducing 'Managed Airflow' in Azure Data Factory](https://techcommunity.microsoft.com/t5/azure-data-factory-blog/introducing-managed-airflow-in-azure-data-factory/ba-p/3730151)
