-- Databricks notebook source
-- MAGIC %md # Storage location

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC **Storage location** can be specified explicitly by a user while creating a Delta Live Table pipeline or assigned automatically by the runtime.
-- MAGIC 
-- MAGIC It can only be specified once and for the whole lifecycle of a DLT pipeline. It cannot be changed ever.
-- MAGIC 
-- MAGIC If auto-assigned by the runtime, the storage location is under `dbfs:/pipelines` directory (in a directory with the same name as the pipeline ID).
-- MAGIC 
-- MAGIC You can find out about the **Storage location** of a DLT pipeline in the **Pipeline settings > Destination** section in the UI.

-- COMMAND ----------

-- MAGIC %fs ls dbfs:/pipelines/960da65b-c9df-4cb9-9456-1005ffe103a9/

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC You can also find out about the Storage location of a DLT pipeline using [Delta Live Table API](https://docs.databricks.com/workflows/delta-live-tables/delta-live-tables-api-guide.html) directly or higher-level [Delta Live Tables CLI](https://docs.databricks.com/dev-tools/cli/dlt-cli.html) (`databricks pipelines`).
-- MAGIC 
-- MAGIC ```console
-- MAGIC $ databricks pipelines get --pipeline-id 960da65b-c9df-4cb9-9456-1005ffe103a9 | jq '.spec.storage'
-- MAGIC "dbfs:/pipelines/960da65b-c9df-4cb9-9456-1005ffe103a9"
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md ## system

-- COMMAND ----------

-- MAGIC %fs ls dbfs:/pipelines/960da65b-c9df-4cb9-9456-1005ffe103a9/system/

-- COMMAND ----------

-- MAGIC %fs ls dbfs:/pipelines/960da65b-c9df-4cb9-9456-1005ffe103a9/system/events

-- COMMAND ----------

-- MAGIC %md ## events Delta Table

-- COMMAND ----------

SELECT * FROM delta.`dbfs:/pipelines/960da65b-c9df-4cb9-9456-1005ffe103a9/system/events`
