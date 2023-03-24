-- Databricks notebook source
-- MAGIC %md # Databricks Terraform Provider

-- COMMAND ----------

-- MAGIC %md # Terraform
-- MAGIC 
-- MAGIC **Terraform** is an **infrastructure as code (IaC) tool** that lets you build, change, and version cloud and on-prem resources safely and efficiently.
-- MAGIC 
-- MAGIC Terraform lets you define both cloud and on-prem resources in human-readable configuration files that you can version, reuse, and share.
-- MAGIC 
-- MAGIC Terraform creates and manages resources on cloud platforms and other services through their application programming interfaces (APIs).
-- MAGIC 
-- MAGIC Create a Terraform configuration file (`.tf` file) and use `terraform` commands:
-- MAGIC 
-- MAGIC * `terraform init`
-- MAGIC * `terraform fmt`
-- MAGIC * `terraform validate`
-- MAGIC * `terraform show`
-- MAGIC * `terraform plan`
-- MAGIC * `terraform apply`
-- MAGIC * `terraform refresh`
-- MAGIC * _there are more_

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC [Install Terraform](https://developer.hashicorp.com/terraform/downloads)
-- MAGIC 
-- MAGIC ```console
-- MAGIC $ brew tap hashicorp/tap && brew install hashicorp/tap/terraform
-- MAGIC ...
-- MAGIC Error: Your Command Line Tools are too outdated.
-- MAGIC Update them from Software Update in System Preferences.
-- MAGIC 
-- MAGIC If that doesn't show you any updates, run:
-- MAGIC   sudo rm -rf /Library/Developer/CommandLineTools
-- MAGIC   sudo xcode-select --install
-- MAGIC 
-- MAGIC Alternatively, manually download them from:
-- MAGIC   https://developer.apple.com/download/all/.
-- MAGIC You should download the Command Line Tools for Xcode 14.1.
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md ## Main Commands
-- MAGIC 
-- MAGIC [Basic CLI Features](https://developer.hashicorp.com/terraform/cli/commands)
-- MAGIC 
-- MAGIC `terraform` command
-- MAGIC 
-- MAGIC Command | Description
-- MAGIC --------|---------------
-- MAGIC  `init` | Prepare your working directory for other commands
-- MAGIC  `validate` | Check whether the configuration is valid
-- MAGIC  `plan` | Show changes required by the current configuration
-- MAGIC  `apply` | Create or update infrastructure
-- MAGIC  `destroy` | Destroy previously-created infrastructure

-- COMMAND ----------

-- MAGIC %md ## Oh My Zsh
-- MAGIC 
-- MAGIC [Terraform plugin](https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/terraform/README.md)

-- COMMAND ----------

-- MAGIC %md ## Providers
-- MAGIC 
-- MAGIC [Providers](https://developer.hashicorp.com/terraform/language/providers):
-- MAGIC 
-- MAGIC * Terraform relies on **plugins** called **providers** to interact with remote systems (cloud providers, SaaS providers, and other APIs)
-- MAGIC * Most providers configure a specific infrastructure platform (either cloud or self-hosted)
-- MAGIC * Each provider adds a set of [resource types](https://developer.hashicorp.com/terraform/language/resources) and/or [data sources](https://developer.hashicorp.com/terraform/language/data-sources) that Terraform can manage
-- MAGIC * The [Terraform Registry](https://registry.terraform.io/browse/providers) is the main directory of publicly available Terraform providers
-- MAGIC 
-- MAGIC [Provider Requirements](https://developer.hashicorp.com/terraform/language/providers/requirements):
-- MAGIC * Each Terraform module must declare which providers it requires in a `required_providers` block (so that Terraform can install and use them)

-- COMMAND ----------

-- MAGIC %md ### How to Find Providers
-- MAGIC 
-- MAGIC [How to Find Providers](https://developer.hashicorp.com/terraform/language/providers#how-to-find-providers):
-- MAGIC 
-- MAGIC * Browse [the providers section of the Terraform Registry](https://registry.terraform.io/browse/providers)

-- COMMAND ----------

-- MAGIC %md ### How to Use Providers
-- MAGIC 
-- MAGIC [How to Use Providers](https://developer.hashicorp.com/terraform/language/providers):
-- MAGIC 
-- MAGIC * Providers are released separately from Terraform itself
-- MAGIC * Providers have their own version numbers
-- MAGIC * Terraform CLI supports an optional plugin cache (using the `plugin_cache_dir` setting in the [CLI configuration file](https://developer.hashicorp.com/terraform/cli/config/config-file))

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC **RECOMMENDATION** Constrain the acceptable provider versions in the configuration's provider requirements block (to prevent `terraform init` from installing newer versions of the provider that could be incompatible with the configuration)
-- MAGIC 
-- MAGIC To ensure Terraform always installs the same provider versions for a given configuration, you can use Terraform CLI to create a [dependency lock file](https://developer.hashicorp.com/terraform/language/files/dependency-lock) and commit it to version control along with your configuration.
-- MAGIC If a lock file is present, Terraform CLI will all obey it when installing providers.

-- COMMAND ----------

-- MAGIC %md # Terraform Extension for Visual Studio Code
-- MAGIC 
-- MAGIC [Terraform Extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)

-- COMMAND ----------

-- MAGIC %md # Databricks Terraform Provider
-- MAGIC 
-- MAGIC [Databricks Provider](https://registry.terraform.io/providers/databricks/databricks/latest)
-- MAGIC 
-- MAGIC [Databricks Provider Documentation](https://registry.terraform.io/providers/databricks/databricks/latest/docs) on the Terraform Registry website
-- MAGIC 
-- MAGIC The [terraform-databricks-examples](https://github.com/databricks/terraform-databricks-examples) repository in GitHub
-- MAGIC 
-- MAGIC [Databricks Terraform provider](https://docs.databricks.com/dev-tools/terraform/index.html):
-- MAGIC 
-- MAGIC * Use the Databricks Terraform provider to manage Databricks workspaces and the associated cloud infrastructure
-- MAGIC * The goal of the Databricks Terraform provider is to support all Databricks REST APIs, supporting automation of the most complicated aspects of deploying and managing your data platforms.

-- COMMAND ----------

-- MAGIC %md ## Install Databricks Provider
-- MAGIC 
-- MAGIC To install this provider, copy and paste this code into your Terraform configuration. Then, run `terraform init`.
-- MAGIC 
-- MAGIC ```
-- MAGIC terraform {
-- MAGIC   required_providers {
-- MAGIC     databricks = {
-- MAGIC       source = "databricks/databricks"
-- MAGIC       version = "1.13.0"
-- MAGIC     }
-- MAGIC   }
-- MAGIC }
-- MAGIC 
-- MAGIC provider "databricks" {}
-- MAGIC ```
-- MAGIC 
-- MAGIC [Empty provider block](https://registry.terraform.io/providers/databricks/databricks/latest/docs#empty-provider-block)

-- COMMAND ----------

-- MAGIC %md ## databricks_pipeline Resource
-- MAGIC 
-- MAGIC [databricks_pipeline Resource](https://github.com/databricks/terraform-provider-databricks/blob/master/docs/resources/pipeline.md)
-- MAGIC 
-- MAGIC * Deploys Delta Live Table workflows
-- MAGIC 
-- MAGIC `terraform apply -auto-approve` to skip interactive approval of plan before applying.
-- MAGIC 
-- MAGIC `databricks_pipeline` is `pipelines.ResourcePipeline()` in the code (`provider/provider.go`):
-- MAGIC 
-- MAGIC * `ResourcePipeline` defines the Terraform resource for pipelines

-- COMMAND ----------

-- MAGIC %md # Debugging Terraform
-- MAGIC 
-- MAGIC [Debugging Terraform](https://developer.hashicorp.com/terraform/internals/debugging) (the page does not seem to be linked in the docs menu)
-- MAGIC 
-- MAGIC * Terraform has detailed logs that you can enable by setting the `TF_LOG` environment variable
-- MAGIC * detailed logs to appear on `stderr`
-- MAGIC * `TF_LOG` can be one of the log levels (in order of decreasing verbosity) `TRACE`, `DEBUG`, `INFO`, `WARN` or `ERROR`
-- MAGIC * To disable, either unset `TF_LOG`, or set it to `off`
-- MAGIC * Logging can be enabled separately for terraform itself and the provider plugins using the `TF_LOG_CORE` or `TF_LOG_PROVIDER` environment variables
-- MAGIC * `TF_LOG_PATH` to force the log to always be appended to a specific file
-- MAGIC 
-- MAGIC ```
-- MAGIC TF_LOG=DEBUG DATABRICKS_DEBUG_TRUNCATE_BYTES=250000 terraform apply -no-color 2>&1 | tee tf-debug.log
-- MAGIC ```
-- MAGIC 
-- MAGIC [internal/logging/logging.go](https://github.com/hashicorp/terraform/blob/main/internal/logging/logging.go)

-- COMMAND ----------

-- MAGIC %md # Environment Variables
-- MAGIC 
-- MAGIC [Environment Variables](https://developer.hashicorp.com/terraform/cli/config/environment-variables)

-- COMMAND ----------

-- MAGIC %md # Build Infrastructure
-- MAGIC 
-- MAGIC [Build Infrastructure](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build)

-- COMMAND ----------

-- MAGIC %md # Review Me

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC 1. [Create clusters, notebooks, and jobs with Terraform](https://docs.databricks.com/dev-tools/terraform/cluster-notebook-job.html)
