-- Databricks notebook source
-- MAGIC %md # Delta Live Tables » Agenda

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC | # | Module |
-- MAGIC | --- | --- |
-- MAGIC | 0 | [Introduction]($./Delta Live Tables) |
-- MAGIC | 1 | [Delta Live Tables SQL]($./Building Delta Live Tables pipelines with SQL) |
-- MAGIC | 2 | [Delta Live Tables Python API]($./Delta Live Tables Python) |
-- MAGIC | x | [Pipeline settings]($./Pipeline settings) |
-- MAGIC | 2L | [DLT Lab]($./DLT Lab) |
-- MAGIC | 3 | [Expectations]($./Expectations) |
-- MAGIC | 4 | [Storage location]($./Storage location) |
-- MAGIC | 5 | [Full Refresh]($./Full Refresh) |
-- MAGIC | 6 | [Deep Dive into DLTs]($./Deep Dive into DLTs) |
-- MAGIC | 7 | [CLI]($./Delta Live Tables CLI) |
-- MAGIC | 8 | [Auto Loader and Streaming DLTs]($./Auto Loader and Streaming DLTs) |

-- COMMAND ----------

-- MAGIC %md ## Open Topics / TODOs
-- MAGIC
-- MAGIC [Open Topics / TODOs]($./TODOs)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Topics
-- MAGIC
-- MAGIC * How to work with files in Databricks
-- MAGIC * `/FileStore`
-- MAGIC * `dbfs` magic command
-- MAGIC * Parameters in jobs vs DLT pipelines
-- MAGIC * How to parameterized SQL queries (to define parameters at job level)
-- MAGIC     * https://docs.databricks.com/en/sql/user/queries/query-parameters.html

-- COMMAND ----------

-- MAGIC %md ## Heads-Up
-- MAGIC
-- MAGIC 1. You can use Python in a SQL notebook for a DLT pipeline yet it won't be rendered in a dataflow (and vice versa)

-- COMMAND ----------

-- MAGIC %md ## Exercise
-- MAGIC
-- MAGIC Based on https://jaceklaskowski.github.io/spark-workshop/exercises/spark-sql-exercise-Using-upper-Standard-Function.html
-- MAGIC
-- MAGIC Create a DLT pipeline that does the following:
-- MAGIC
-- MAGIC 1. FIXME Accepts a parameter - a CSV filename to load
-- MAGIC 1. FIXME Accepts another parameter that is the column name with string values
-- MAGIC 1. Executes `upper` standard function on this string column
-- MAGIC
-- MAGIC FIXMEs = how to pass parameters to a DLT pipeline
-- MAGIC
-- MAGIC In summary:
-- MAGIC
-- MAGIC The dataflow (pipeline) should be two tables

-- COMMAND ----------

-- MAGIC %md ## Exercise (Databricks SQL)
-- MAGIC
-- MAGIC Create a job with a DLT pipeline (that's already created) and a (SQL) query
