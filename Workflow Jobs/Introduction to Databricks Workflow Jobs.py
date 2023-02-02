# Databricks notebook source
# MAGIC %md # Orchestration with Databricks Workflow Jobs
# MAGIC 
# MAGIC This notebook is based on the [Data Engineer Learning Path by Databricks Academy](https://github.com/databricks-academy/data-engineer-learning-path) (specifically, [05 - Workflow Jobs](https://github.com/databricks-academy/data-engineer-learning-path/tree/published/05%20-%20Workflow%20Jobs)).

# COMMAND ----------

# MAGIC %md ## Databricks Lakehouse
# MAGIC 
# MAGIC **Databricks Lakehouse** (also known as **Databricks Platform** or simply **Databricks**) is a SaaS-based data processing and AI platform solution with a hosted environment with Apache Spark (**Databricks Spark**), Delta Lake, MLflow.
# MAGIC 
# MAGIC Google says: **SaaS** is a method of software delivery and licensing in which software is accessed online via a subscription (rather than bought and installed on individual computers).
# MAGIC 
# MAGIC For the purpose of this presentation (and perhaps in general), SaaS is the **cloud** (computing facilities providing remote data storage and processing services via the internet).

# COMMAND ----------

# MAGIC %md ## Naming Convention
# MAGIC 
# MAGIC From [Jan van der Vegt](https://www.linkedin.com/in/jan-van-der-vegt/), a PM working on Databricks Workflows:
# MAGIC 
# MAGIC > the product itself is now called **Databricks Workflows** and the DAGs are the **jobs**
# MAGIC 
# MAGIC > For referencing an instance we just use "Job". When talking about the product we say "Databricks Workflows".

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

# MAGIC %md ## Competition

# COMMAND ----------

# MAGIC %md ### Azure Data Factory
# MAGIC 
# MAGIC [Introducing 'Managed Airflow' in Azure Data Factory](https://techcommunity.microsoft.com/t5/azure-data-factory-blog/introducing-managed-airflow-in-azure-data-factory/ba-p/3730151)

# COMMAND ----------

# MAGIC %md ## Create Job
# MAGIC 
# MAGIC [Learn more](https://docs.databricks.com/workflows/jobs/jobs.html#create-a-job)

# COMMAND ----------

# MAGIC %md ### New Job split-view authoring experience
# MAGIC 
# MAGIC Similarly to DLT UI, Jobs UI allows for editing your task while seeing your workflow.

# COMMAND ----------

# MAGIC %md ### Run other jobs
# MAGIC 
# MAGIC By using the new 'Run Job' task in your job, you can orchestrate other jobs. This allows you to reuse generic jobs with parameters, as well as split up large jobs into smaller, modular pieces.
# MAGIC 
# MAGIC ![Run Job Task](workflows-run-job-task.png)

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
