-- Databricks notebook source
-- MAGIC %md # Databricks Workshop Day 2
-- MAGIC
-- MAGIC Duration: 4.5 hours (9:30-14:00)

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
-- MAGIC 1. Training Datasets
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

-- MAGIC %md ## Training Datasets
-- MAGIC
-- MAGIC Review of the available datasets to be used during exercises (incl. pre-installed Databricks Datasets).

-- COMMAND ----------

-- MAGIC %fs ls /databricks-datasets

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC What are the ways to read text files (e.g., `README.md`) using this Databricks notebook?

-- COMMAND ----------

-- MAGIC %python
-- MAGIC
-- MAGIC display(spark.read.text("dbfs:/databricks-datasets/README.md"))

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC That's a bit too DataFrame'y. It is simply to hard to read like an article (in a page-like format).
-- MAGIC
-- MAGIC Are there any other more human-friendly ways?

-- COMMAND ----------

-- MAGIC %python 
-- MAGIC
-- MAGIC # DataFrame.show looks more human-friendly, actually.
-- MAGIC # Just a single column with the lines as rows.
-- MAGIC spark.read.text("dbfs:/databricks-datasets/README.md").show(truncate=False)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC Can we do better? 🤔
-- MAGIC
-- MAGIC Yes, we can! 🚀
-- MAGIC
-- MAGIC There are the following Databricks-specific magic commands:
-- MAGIC
-- MAGIC * `%fs head`
-- MAGIC * `%sh cat`

-- COMMAND ----------

-- MAGIC %fs head dbfs:/databricks-datasets/README.md

-- COMMAND ----------

-- MAGIC %sh cat /dbfs/databricks-datasets/README.md

-- COMMAND ----------

-- MAGIC %sh ls /dbfs/databricks-datasets

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC The following datasets are most likely not available unless you're participating in a Databricks Academy course. Sorry 🤷‍♂️

-- COMMAND ----------

-- MAGIC %fs ls dbfs:/mnt/dbacademy-datasets/data-engineer-learning-path/v04

-- COMMAND ----------

-- MAGIC %fs ls dbfs:/mnt/dbacademy-datasets/data-engineer-learning-path/v04/ecommerce/raw/events-kafka

-- COMMAND ----------

SELECT * FROM text.`dbfs:/databricks-datasets/README.md`

-- COMMAND ----------

-- MAGIC %md ## SQL on JDBC Table

-- COMMAND ----------

CREATE TABLE jdbc_marek
USING http
OPTIONS (url='jdbc:ala:ma:kota')

-- COMMAND ----------

-- MAGIC %md ## Know Your Audience
-- MAGIC
-- MAGIC 1. What's your programming language of choice in Databricks? Python? Scala? SQL?
-- MAGIC
-- MAGIC Mainly SQL with some Python (no Scala)

-- COMMAND ----------

-- MAGIC %md ## Warm Up Exercises

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC 1. Query a single (JSON/markdown) file
-- MAGIC 1. Show a schema of a (JSON) dataset
-- MAGIC 1. Query a single directory of (JSON) files
-- MAGIC 1. Create references to files (using `CREATE TABLE|VIEW AS`)
-- MAGIC 1. Use CTEs

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC https://docs.databricks.com/en/sql/language-manual/sql-ref-syntax-ddl-create-table.html

-- COMMAND ----------

CREATE TABLE jacek_day2_demo (
  id LONG,
  name STRING
) AS VALUES
  (1, 'one'),
  (2, 'two')

-- COMMAND ----------

-- MAGIC %scala
-- MAGIC
-- MAGIC Seq(
-- MAGIC   (1, "one"),
-- MAGIC   (2, "two")
-- MAGIC ).toDF("id", "name").write.saveAsTable("jacek_day2_nums")

-- COMMAND ----------

SHOW TABLES

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC https://docs.databricks.com/en/sql/language-manual/sql-ref-syntax-aux-show-tables.html

-- COMMAND ----------

SHOW TABLES LIKE 'jacek_day2*'

-- COMMAND ----------

DESC jacek_day2_nums

-- COMMAND ----------

-- MAGIC %fs ls /Users/jacek@japila.pl/1k.parquet/

-- COMMAND ----------

SELECT * FROM text.`/Users/jacek@japila.pl`

-- COMMAND ----------

-- MAGIC %python
-- MAGIC
-- MAGIC spark.range(2).write.json('dataset.json')

-- COMMAND ----------

-- MAGIC %fs ls dataset.json

-- COMMAND ----------

-- MAGIC %python
-- MAGIC
-- MAGIC spark.range(1).write.save('/Users/jacek@japila.pl/dataset.delta')

-- COMMAND ----------

-- MAGIC %fs ls /Users/jacek@japila.pl/dataset.delta

-- COMMAND ----------

-- MAGIC %fs ls dbfs:/Users/jacek@japila.pl/dataset.delta/_delta_log/

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## _SUCCESS

-- COMMAND ----------

-- MAGIC %python
-- MAGIC
-- MAGIC spark

-- COMMAND ----------

-- MAGIC %python
-- MAGIC
-- MAGIC path='/FileStore/tables/people.csv'
-- MAGIC people = spark \
-- MAGIC     .read \
-- MAGIC     .option('header', True) \
-- MAGIC     .option('inferSchema', True) \
-- MAGIC     .csv(path)
-- MAGIC people.printSchema()

-- COMMAND ----------

-- https://docs.databricks.com/en/notebooks/widgets.html#language-sql
CREATE WIDGET TEXT filename DEFAULT "people.csv"

-- COMMAND ----------

-- MAGIC %python
-- MAGIC
-- MAGIC my_filename = f'{dbutils.widgets.get("filename")}.csv'

-- COMMAND ----------

-- Use OPTIONS to load a CSV dataset
-- CTE needed?! 🤔
SELECT * FROM csv.`/FileStore/tables/${my_filename}`

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Columns

-- COMMAND ----------

-- MAGIC %python
-- MAGIC
-- MAGIC display(people)

-- COMMAND ----------

-- MAGIC %python
-- MAGIC
-- MAGIC c = people.id.alias('to_alias')
-- MAGIC type(c)
-- MAGIC
-- MAGIC # SELECT id to_alias FROM csv.`...people.csv`
-- MAGIC display(people.select(c))

-- COMMAND ----------

-- MAGIC %python
-- MAGIC
-- MAGIC type(people)

-- COMMAND ----------

-- MAGIC %python
-- MAGIC
-- MAGIC # from pyspark.sql.functions import col
-- MAGIC # people.select('*').where(col('id') == 0).display()
-- MAGIC
-- MAGIC # people.select('*').where(people.id == 0).display()
-- MAGIC
-- MAGIC cond = 'id = 0'
-- MAGIC people.select('*').where(cond).display()

-- COMMAND ----------

-- MAGIC %python
-- MAGIC
-- MAGIC from pyspark.sql import functions as F
-- MAGIC hello = F.col('name')
-- MAGIC display(people.select(hello))
