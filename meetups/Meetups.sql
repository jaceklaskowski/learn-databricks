-- Databricks notebook source
-- MAGIC %md # Meetups
-- MAGIC 
-- MAGIC This notebook is a list of topics to be covered as part of **Databricks Talks** series of the [Warsaw Data Engineering](https://www.meetup.com/warsaw-data-engineering/) meetup group.
-- MAGIC 
-- MAGIC And some other meetup-related things.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC 1. [Databricks Terraform provider](https://docs.databricks.com/dev-tools/terraform/index.html)

-- COMMAND ----------

-- MAGIC %md # Before We Start ~ News

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ### Databricks Runtime 12.2 LTS
-- MAGIC 
-- MAGIC [Databricks Runtime 12.2 LTS](https://docs.databricks.com/release-notes/runtime/12.2.html) is out and is the latest LTS with Apache Spark 3.3.2 under the covers.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC In [Delta Live Tables release notes and the release upgrade process](https://docs.databricks.com/release-notes/delta-live-tables/index.html):
-- MAGIC 
-- MAGIC > Because Delta Live Tables is versionless, both workspace and runtime changes take place automatically.
-- MAGIC 
-- MAGIC > Delta Live Tables is considered to be a versionless product, which means that Databricks automatically upgrades the Delta Live Tables runtime to support enhancements and upgrades to the platform. Databricks recommends limiting external dependencies for Delta Live Tables pipelines.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ### Delta Live Tables Release 2023.06
-- MAGIC 
-- MAGIC [Release 2023.06](https://docs.databricks.com/release-notes/delta-live-tables/2023/06/index.html):
-- MAGIC 
-- MAGIC * Databricks Runtime 11.0.12
-- MAGIC 
-- MAGIC There's an inconsistency though as the UI says 11.3 (under [Compute](/#joblist/pipelines)).

-- COMMAND ----------

-- MAGIC %md ### DLT Pipeline Dependencies
-- MAGIC 
-- MAGIC [Pipeline dependencies](https://docs.databricks.com/release-notes/delta-live-tables/index.html#pipeline-dependencies):
-- MAGIC 
-- MAGIC * Delta Live Tables supports external dependencies in your pipelines;
-- MAGIC     * any Python package using the `%pip install` command
-- MAGIC * Delta Live Tables also supports using global and cluster-scoped [init scripts](https://docs.databricks.com/clusters/init-scripts.html)
-- MAGIC 
-- MAGIC **Recommendation**: [Minimize using init scripts in your pipelines](https://docs.databricks.com/release-notes/delta-live-tables/index.html#pipeline-dependencies)
-- MAGIC 
-- MAGIC [Can I use Scala or Java libraries in a Delta Live Tables pipeline?](https://docs.databricks.com/workflows/delta-live-tables/delta-live-tables-faqs-issues.html#can-i-use-scala-or-java-libraries-in-a-delta-live-tables-pipeline):
-- MAGIC 
-- MAGIC * No, Delta Live Tables supports only SQL and Python. You cannot use JVM libraries in a pipeline.

-- COMMAND ----------

-- MAGIC %md ### Files in Repos
-- MAGIC 
-- MAGIC [What are workspace files?](https://docs.databricks.com/files/workspace.html):
-- MAGIC 
-- MAGIC * Support for workspace files is in Public Preview.
-- MAGIC * Files in Repos is GA
-- MAGIC * A workspace file is any file in the Databricks workspace that is not a Databricks notebook
-- MAGIC     * But...**you cannot embed images in notebooks** :(
-- MAGIC * Workspace files are enabled everywhere by default for Databricks Runtime 11.2 and above. Files in Repos is enabled by default in Databricks Runtime 11.0 and above, and can be manually disabled or enabled.
-- MAGIC * Did you know that...you can use the command `%sh pwd` in a notebook inside a repo to check if Files in Repos is enabled?
-- MAGIC * Fun fact: All the links to the notebooks in the meetups use "Files in Repos" feature

-- COMMAND ----------

-- MAGIC %md ## Azure Databricks and Personal Compute Policy Available By Default To All Users
-- MAGIC 
-- MAGIC **On 11 April 2023, the [Personal Compute](https://learn.microsoft.com/en-gb/azure/databricks/clusters/personal-compute) policy will become available by default to all users of Azure Databricks premium workspaces** — users will no longer need specific permission from the administrator.
-- MAGIC 
-- MAGIC * Simplifies the Azure Databricks onboarding experience so all users can immediately create single-machine compute resources with Spark available in local mode. All-purpose compute pricing applies to these resources.
-- MAGIC 
-- MAGIC If you don’t want users to be able to create Personal Compute resources in Azure Databricks without admin approval, an Azure Active Directory (Azure AD) administrator will need to change account-wide access by 11 April 2023.

-- COMMAND ----------

-- MAGIC %md ## Does Delta Live Tables only support updating of Delta tables
-- MAGIC 
-- MAGIC [Does Delta Live Tables only support updating of Delta tables](https://docs.databricks.com/workflows/delta-live-tables/delta-live-tables-faqs-issues.html#does-delta-live-tables-only-support-updating-of-delta-tables):
-- MAGIC 
-- MAGIC > Yes, Delta Live Tables can only be used to update Delta tables.

-- COMMAND ----------

-- MAGIC %md # March 16, 2023
-- MAGIC 
-- MAGIC ➡️ [Delta Live Tables CLI cntd., Storage Location and Auto Loader (online)](https://www.meetup.com/warsaw-data-engineering/events/292215944/)
-- MAGIC 
-- MAGIC Agenda:
-- MAGIC 
-- MAGIC 1. <a href="$Delta Live Tables/Delta Live Tables CLI">Demo: Databricks CLI i Delta Live Tables pipelines</a> ([start here](#notebook/4149416302950404/command/4149416302950416))
-- MAGIC 1. <a href="$Delta Live Tables/Storage location">Demo: Co kryje się w Storage Location</a>
-- MAGIC 1. <a href="$Delta Live Tables/Auto Loader and Streaming DLTs">Użycie Auto Loader i STREAMING DLTs</a>
-- MAGIC 1. <a href="$Delta Live Tables/Full Refresh">Full Refresh</a>
