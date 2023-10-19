# Databricks notebook source
# MAGIC %md # Databricks Asset Bundles
# MAGIC
# MAGIC [Databricks Asset Bundles](https://www.databricks.com/resources/demos/tours/data-engineering/databricks-asset-bundles):
# MAGIC
# MAGIC > Databricks Asset Bundles is a new capability on Databricks that **standardizes and unifies the deployment strategy** for all data products developed on the platform.
# MAGIC > It allows developers to describe the infrastructure and resources of their project through a **YAML configuration file**.
# MAGIC
# MAGIC The main take-aways from the above introduction about DAB are as follows:
# MAGIC
# MAGIC 1. DAB is all about standardizing deployment of Databricks projects
# MAGIC 1. DAB is an [Infrastructure as code (IaC)](https://en.wikipedia.org/wiki/Infrastructure_as_code) tool
# MAGIC 1. DAB uses a YAML configuration file to describe what/when/how

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC Databricks asset bundles make it possible to express complete data, analytics, and ML projects as a collection of source files called a bundle.
# MAGIC
# MAGIC ➡️ Learn more in the [official documentation](https://docs.databricks.com/en/dev-tools/bundles/index.html)

# COMMAND ----------

# MAGIC %md ## Automate Databricks Deployments
# MAGIC
# MAGIC DAB is not alone in the IaC/deployment 'market'.
# MAGIC
# MAGIC Developers have been using the following for quite some time:
# MAGIC
# MAGIC 1. [Databricks REST API](https://docs.databricks.com/api/)
# MAGIC 1. [Databricks CLI](https://docs.databricks.com/en/dev-tools/cli/index.html)
# MAGIC 1. [Databricks Terraform provider](https://docs.databricks.com/en/dev-tools/terraform/index.html)
# MAGIC 1. [dbx by Databricks Labs](https://docs.databricks.com/en/archive/dev-tools/dbx/dbx.html)

# COMMAND ----------

# MAGIC %md ### Migrate from dbx to bundles
# MAGIC
# MAGIC [Migrate from dbx to bundles](https://docs.databricks.com/en/archive/dev-tools/dbx/dbx-migrate.html)
# MAGIC
# MAGIC From [databrickslabs/dbx](https://github.com/databrickslabs/dbx#legal-information):
# MAGIC
# MAGIC > Databricks recommends using Databricks asset bundles for CI/CD. Please see migration guidance on how to migrate from dbx to dabs
# MAGIC

# COMMAND ----------

# MAGIC %md ## Demo
# MAGIC
# MAGIC [Develop a job on Databricks by using Databricks asset bundles](https://docs.databricks.com/en/workflows/jobs/how-to/use-bundles-with-jobs.html)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ```
# MAGIC $ databricks --version
# MAGIC Databricks CLI v0.208.0
# MAGIC ```

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ```shell
# MAGIC $ databricks bundle
# MAGIC Databricks Asset Bundles
# MAGIC
# MAGIC Online documentation: https://docs.databricks.com/en/dev-tools/bundles
# MAGIC
# MAGIC Usage:
# MAGIC   databricks bundle [command]
# MAGIC
# MAGIC Available Commands:
# MAGIC   deploy      Deploy bundle
# MAGIC   destroy     Destroy deployed bundle resources
# MAGIC   init        Initialize Template
# MAGIC   run         Run a resource (e.g. a job or a pipeline)
# MAGIC   schema      Generate JSON Schema for bundle configuration
# MAGIC   sync        Synchronize bundle tree to the workspace
# MAGIC   validate    Validate configuration
# MAGIC
# MAGIC Flags:
# MAGIC   -h, --help          help for bundle
# MAGIC       --var strings   set values for variables defined in bundle config. Example: --var="foo=bar"
# MAGIC
# MAGIC Global Flags:
# MAGIC       --log-file file            file to write logs to (default stderr)
# MAGIC       --log-format type          log output format (text or json) (default text)
# MAGIC       --log-level format         log level (default disabled)
# MAGIC   -o, --output type              output type: text or json (default text)
# MAGIC   -p, --profile string           ~/.databrickscfg profile
# MAGIC       --progress-format format   format for progress logs (append, inplace, json) (default default)
# MAGIC   -t, --target string            bundle target to use (if applicable)
# MAGIC
# MAGIC Use "databricks bundle [command] --help" for more information about a command.
# MAGIC ```

# COMMAND ----------

# MAGIC %md ## Questions
# MAGIC
# MAGIC 1. Where does `databricks bundle init` take templates from?

# COMMAND ----------

# MAGIC %md ## Demo: Create DAB Template (WIP)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC An idea is to execute the following command with a random template name and guide the audience through errors.
# MAGIC
# MAGIC ```
# MAGIC databricks bundle init
# MAGIC ```
