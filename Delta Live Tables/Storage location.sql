-- Databricks notebook source
-- MAGIC %md # Storage location

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC **Storage location** can be specified while a Delta Live Table pipeline is created or assigned automatically by the system. It can be specified once and for the whole lifecycle of the DLT pipeline. It cannot be changed ever.
-- MAGIC 
-- MAGIC If auto-assigned, the storage location is under `dbfs:/pipelines` directory.
-- MAGIC 
-- MAGIC Find the Storage location in the **Pipeline settings > Destination** section in the UI.

-- COMMAND ----------

-- MAGIC %fs ls dbfs:/pipelines/960da65b-c9df-4cb9-9456-1005ffe103a9/checkpoints/my_streaming_table/

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC You can also use Delta Live Table API (either REST API Endpoint or `databricks pipelines`).

-- COMMAND ----------

-- MAGIC %md ## Future Meetups
-- MAGIC 
-- MAGIC 1. [Databricks Terraform provider](https://docs.databricks.com/dev-tools/terraform/index.html)
