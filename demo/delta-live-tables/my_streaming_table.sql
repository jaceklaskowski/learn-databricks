-- Databricks notebook source
-- MAGIC %md # my_streaming_table DLT Table

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ## Why SQL Considered Superior (over Python)
-- MAGIC 
-- MAGIC Unlike in Python, [Delta Live Tables SQL](https://docs.databricks.com/workflows/delta-live-tables/delta-live-tables-sql-ref.html) allow for:
-- MAGIC 
-- MAGIC 1. Executing DLT notebooks for syntax analysis (using `Run all`)
-- MAGIC 1. Markdown 😍
-- MAGIC 
-- MAGIC You can still use SQL notebooks with Python notebooks in a single DLT pipeline.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC When executing the notebook in a DLT pipeline you will get this WARN message:
-- MAGIC 
-- MAGIC ```
-- MAGIC Magic commands (e.g. %py, %sql and %run) are not supported with the exception of
-- MAGIC %pip within a Python notebook. Cells containing magic commands are ignored.
-- MAGIC Unsupported magic commands were found in the following notebooks
-- MAGIC 
-- MAGIC /Repos/jacek@japila.pl/learn-databricks/Delta Live Tables/auto_loader: %fs
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC Let's start with an example non-DLT query with `cloud_files` TVF (Auto Loader).
-- MAGIC 
-- MAGIC It won't work.
-- MAGIC 
-- MAGIC `cloud_files` creates a streaming table while CTAS does not define one.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC The following won't work as is in a DLT notebook.
-- MAGIC 
-- MAGIC ```
-- MAGIC Unable to process top-level query. DLT currently only accepts 'CREATE TEMPORARY LIVE VIEW', 'CREATE OR REFRESH LIVE TABLE', 'APPLY CHANGES INTO', and 'SET' statements.
-- MAGIC ```
-- MAGIC 
-- MAGIC Don't forget to comment it out before executing the notebook in a DLT pipeline.

-- COMMAND ----------

-- SELECT * FROM cloud_files("/databricks-datasets/retail-org/customers/", "csv")

-- COMMAND ----------

-- MAGIC %md ## Schema Inference

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC [Auto Loader](https://docs.databricks.com/workflows/delta-live-tables/delta-live-tables-data-sources.html#auto-loader):
-- MAGIC 
-- MAGIC * You can use supported format options with Auto Loader.
-- MAGIC * Use `map()` function to pass options to `cloud_files()`

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ```sql
-- MAGIC CREATE OR REFRESH STREAMING LIVE TABLE <table_name>
-- MAGIC AS SELECT *
-- MAGIC   FROM cloud_files(
-- MAGIC     "<file_path>",
-- MAGIC     "<file_format>",
-- MAGIC     map(
-- MAGIC       "<option_key>", "<option_value",
-- MAGIC       "<option_key>", "<option_value",
-- MAGIC       ...
-- MAGIC     )
-- MAGIC   )
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC Use `schema` option to specify the schema manually
-- MAGIC 
-- MAGIC Mandatory for formats that with no [schema inference](https://docs.databricks.com/ingestion/auto-loader/schema.html)
-- MAGIC 
-- MAGIC ```
-- MAGIC CREATE OR REFRESH STREAMING LIVE TABLE <table_name>
-- MAGIC AS SELECT *
-- MAGIC   FROM cloud_files(
-- MAGIC     "<file_path>",
-- MAGIC     "<file_format>",
-- MAGIC     map("schema", "title STRING, id INT, revisionId INT, revisionTimestamp TIMESTAMP, revisionUsername STRING, revisionUsernameId INT, text STRING")
-- MAGIC   )
-- MAGIC ```

-- COMMAND ----------

-- no "header", "true" by default
CREATE OR REFRESH STREAMING LIVE TABLE raw_streaming_table(
  CONSTRAINT names_at_least_5_char_long EXPECT (name IS NOT NULL AND len(name) >= 5),
  CONSTRAINT ids_only_even EXPECT (id % 2 = 0)
)
AS SELECT * FROM
  cloud_files(
    "${cloud_files_input_path}",
    "csv",
    map(
      "schema", "id INT, name STRING"
    )
  )
