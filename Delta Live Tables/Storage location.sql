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

-- MAGIC %md
-- MAGIC 
-- MAGIC [Databricks recommends always storing checkpoint and schema evolution information in storage locations managed by Unity Catalog](https://docs.databricks.com/ingestion/auto-loader/unity-catalog.html#specifying-locations-for-auto-loader-resources-for-unity-catalog)

-- COMMAND ----------

-- MAGIC %md ## Autoloader Directory
-- MAGIC 
-- MAGIC Contains schema evolution information

-- COMMAND ----------

-- MAGIC %fs ls dbfs:/pipelines/960da65b-c9df-4cb9-9456-1005ffe103a9/autoloader

-- COMMAND ----------

-- MAGIC %fs ls dbfs:/pipelines/960da65b-c9df-4cb9-9456-1005ffe103a9/autoloader/schema_1493166085_/_schemas

-- COMMAND ----------

-- MAGIC %fs head dbfs:/pipelines/960da65b-c9df-4cb9-9456-1005ffe103a9/autoloader/schema_1493166085_/_schemas/0

-- COMMAND ----------

-- MAGIC %md ## System Directory

-- COMMAND ----------

-- MAGIC %fs ls dbfs:/pipelines/960da65b-c9df-4cb9-9456-1005ffe103a9/system/

-- COMMAND ----------

-- MAGIC %fs ls dbfs:/pipelines/960da65b-c9df-4cb9-9456-1005ffe103a9/system/events

-- COMMAND ----------

-- MAGIC %md ## Events Delta Table

-- COMMAND ----------

SELECT * FROM delta.`dbfs:/pipelines/a02952e6-7197-44a4-a072-5ea5124d7bce/system/events`

-- COMMAND ----------

-- MAGIC %md ## Data Quality Checks

-- COMMAND ----------

-- MAGIC %python
-- MAGIC 
-- MAGIC pipelines = spark.createDataFrame(data = dbutils.fs.ls("dbfs:/pipelines/"))
-- MAGIC path = pipelines.orderBy(pipelines["modificationTime"].desc()).select("path").head().path
-- MAGIC spark.conf.set("pipeline.path", path)
-- MAGIC print(spark.conf.get('pipeline.path'))

-- COMMAND ----------

SELECT '${pipeline.path}' path

-- COMMAND ----------

DESCRIBE delta.`${pipeline.path}/system/events`

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC Inspired by [this article](https://www.linkedin.com/pulse/delta-live-tables-how-build-pipeline-run-data-quality-mathias-weber/) and feeling a bit adventurous to use some advanced "tools":
-- MAGIC 
-- MAGIC * [Common Table Expression (CTE)](https://spark.apache.org/docs/latest/sql-ref-syntax-qry-select-cte.html)
-- MAGIC * [JSON path expression](https://docs.databricks.com/sql/language-manual/sql-ref-json-path-expression.html)

-- COMMAND ----------

WITH data_quality AS (
  WITH details AS (
    SELECT
      id update_id,
      details:flow_progress:data_quality:expectations
    FROM delta.`dbfs:/pipelines/05740fff-c03e-4366-8061-2680f9e9ce48/system/events`
    WHERE event_type = 'flow_progress'
  )
  SELECT
    update_id,
    explode(from_json(expectations, "array<struct<name: string, dataset: string, passed_records: int, failed_records: int>>")) expectations
  FROM details
  WHERE expectations IS NOT NULL
)
SELECT update_id, expectations.* FROM data_quality
