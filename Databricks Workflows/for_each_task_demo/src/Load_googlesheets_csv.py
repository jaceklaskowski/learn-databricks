# Databricks notebook source
# MAGIC %md
# MAGIC
# MAGIC # Load googlesheets csv Notebook

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC This notebook is part of the For each task Demo.

# COMMAND ----------

# MAGIC %md ## Step 1. Load CSV file
# MAGIC
# MAGIC It could load a CSV file with `google_spreadsheet`s (to load in parallel in the For each task).

# COMMAND ----------

google_spreadsheet_df = spark.createDataFrame(
    [
        ("Non-logistics - Energy", "[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]", "[1]"),
        ("Use Phase Factors", "[0,1,2,3,4,5,6]", "[1]"),
    ],
    "google_spreadsheet string, use_cols string, skip_rows string",
)

# COMMAND ----------

display(google_spreadsheet_df)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Step 2. Collect Data

# COMMAND ----------

gsheets = google_spreadsheet_df.toJSON().collect()

# COMMAND ----------

print(gsheets)

# COMMAND ----------

print(type(gsheets))

# COMMAND ----------

print(type(gsheets[0]))

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Step 3. Define Task Value

# COMMAND ----------

help(dbutils.jobs.taskValues.set)

# COMMAND ----------

dbutils.jobs.taskValues.set(key='gsheets', value=gsheets)
