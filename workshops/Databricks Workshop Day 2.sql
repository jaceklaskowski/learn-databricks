-- Databricks notebook source
-- MAGIC %md # Databricks Workshop Day 2

-- COMMAND ----------

-- MAGIC %md ## Schedule

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC * The class starts at 9:30
-- MAGIC * A class is split into 1-hour blocks with a 12-minute break each
-- MAGIC     * Breaks at the end of an hour
-- MAGIC     * However, the first 20' break is at 10:30 (till 10:50)

-- COMMAND ----------

-- MAGIC %md ## Agenda
-- MAGIC
-- MAGIC 1. Available Datasets
-- MAGIC 1. Warm Up Exercises
-- MAGIC 1. An overview of the main abstractions of [Spark SQL](https://jaceklaskowski.github.io/spark-workshop/slides/spark-sql.html#/home) (15')
-- MAGIC     1. [Exercise: Using CSV Data Source](https://jaceklaskowski.github.io/spark-workshop/exercises/spark-sql-exercise-Using-CSV-Data-Source.html)
-- MAGIC 1. [Columns and Dataset Operators](https://jaceklaskowski.github.io/spark-workshop/slides/spark-sql-columns-and-dataset-operators.html#/home) (15')
-- MAGIC 1. [Standard and User-Defined Functions](https://jaceklaskowski.github.io/spark-workshop/slides/spark-sql-standard-functions-udfs.html#/home) (15')
-- MAGIC     1. [Exercise: Using explode Standard Function](https://jaceklaskowski.github.io/spark-workshop/exercises/spark-sql-exercise-Using-explode-Standard-Function.html)
-- MAGIC     1. [Exercise: Converting Arrays of Strings to String](https://jaceklaskowski.github.io/spark-workshop/exercises/spark-sql-exercise-Converting-Arrays-of-Strings-to-String.html)
-- MAGIC     1. [Exercise: Using upper Standard Function](https://jaceklaskowski.github.io/spark-workshop/exercises/spark-sql-exercise-Using-upper-Standard-Function.html)
-- MAGIC     1. [Exercise: Difference in Days Between Dates As Strings](https://jaceklaskowski.github.io/spark-workshop/exercises/spark-sql-exercise-Difference-in-Days-Between-Dates-As-Strings.html)
-- MAGIC     1. [Exercise: Using UDFs](https://jaceklaskowski.github.io/spark-workshop/exercises/spark-sql-exercise-Using-UDFs.html)
-- MAGIC 1. [Basic Aggregation](https://jaceklaskowski.github.io/spark-workshop/slides/spark-sql-basic-aggregation.html#/home) (15')
-- MAGIC     1. [Exercise: Finding maximum values per group (groupBy)](https://jaceklaskowski.github.io/spark-workshop/exercises/spark-sql-exercise-Finding-maximum-values-per-group-groupBy.html)
-- MAGIC     1. [Exercise: Collect values per group](https://jaceklaskowski.github.io/spark-workshop/exercises/spark-sql-exercise-Collect-values-per-group.html)
-- MAGIC
-- MAGIC > **Note**
-- MAGIC >
-- MAGIC > More exercises at [Exercises for Apache Spark™ and Scala Workshops](https://jaceklaskowski.github.io/spark-workshop/exercises/).

-- COMMAND ----------

-- MAGIC %fs ls /databricks-datasets

-- COMMAND ----------

-- MAGIC %fs ls dbfs:/mnt/dbacademy-datasets/data-engineer-learning-path/v04

-- COMMAND ----------

-- MAGIC %fs ls dbfs:/mnt/dbacademy-datasets/data-engineer-learning-path/v04/ecommerce/raw/events-kafka

-- COMMAND ----------

-- MAGIC %md ## Know Your Audience
-- MAGIC
-- MAGIC 1. What's your programming language of choice in Databricks? Python? Scala? SQL?

-- COMMAND ----------

-- MAGIC %md ## Warm Up Exercises

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC 1. Query a single (JSON) file
-- MAGIC 1. Show a schema of a (JSON) dataset
-- MAGIC 1. Query a single directory of (JSON) files
-- MAGIC 1. Create references to files (using `CREATE TABLE|VIEW AS`)
-- MAGIC 1. Use CTEs
