# Databricks notebook source
# MAGIC %md
# MAGIC
# MAGIC # Delta Lake

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Agenda
# MAGIC
# MAGIC 1. Anatomy of Delta Lake
# MAGIC 1. Commands (MERGE, UPDATE, DELETE, etc.)
# MAGIC 1. Delta SQL
# MAGIC 1. Optimistic Transactions
# MAGIC 1. Time Travel
# MAGIC 1. Table Constraints
# MAGIC     1. Column Invariants
# MAGIC     1. CHECK Constraints
# MAGIC     1. Generated Columns
# MAGIC 1. Change Data Feed
# MAGIC 1. CDF Table-Valued Functions
# MAGIC 1. Data Skipping
# MAGIC 1. Table Properties
# MAGIC 1. Multi-Hop Architecture
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Introduction
# MAGIC
# MAGIC [Introduction](https://docs.delta.io/latest/delta-intro.html)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Quickstart
# MAGIC
# MAGIC [Quickstart](https://docs.delta.io/latest/quick-start.html)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ### Exercise Time
# MAGIC
# MAGIC Time: 20 mins
# MAGIC
# MAGIC Install PySpark with Delta Lake as described in [PySpark Shell](https://docs.delta.io/latest/quick-start.html#pyspark-shell)
# MAGIC
# MAGIC Go over the following sections up to and including [Conditional update without overwrite](https://docs.delta.io/latest/quick-start.html#conditional-update-without-overwrite):
# MAGIC
# MAGIC 1. [Create a Delta table](https://docs.delta.io/latest/quick-start.html#create-a-table)
# MAGIC 1. [Read data](https://docs.delta.io/latest/quick-start.html#read-data)
# MAGIC 1. [Update table data](https://docs.delta.io/latest/quick-start.html#update-table-data)
# MAGIC     1. Overwrite
# MAGIC     1. Conditional update without overwrite
# MAGIC
# MAGIC Do not execute "Read older versions of data using time travel" yet.

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Batch Reads and Writes
# MAGIC
# MAGIC [Table batch reads and writes](https://docs.delta.io/latest/delta-batch.html)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ### Managed vs External Tables

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ```
# MAGIC sql('drop table managed_table')
# MAGIC sql('drop table external_table')
# MAGIC ```
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ### Open Question
# MAGIC
# MAGIC Why does the following `DESC EXTENDED` give `MANAGED` for a seemingly unmanaged table.
# MAGIC
# MAGIC ----
# MAGIC
# MAGIC ```
# MAGIC >>> sql('desc extended delta.`/tmp/random_directory`').show(truncate=False)
# MAGIC +----------------------------+---------------------------------------------------+-------+
# MAGIC |col_name                    |data_type                                          |comment|
# MAGIC +----------------------------+---------------------------------------------------+-------+
# MAGIC |id                          |bigint                                             |NULL   |
# MAGIC |                            |                                                   |       |
# MAGIC |# Detailed Table Information|                                                   |       |
# MAGIC |Name                        |delta.`file:/tmp/random_directory`                 |       |
# MAGIC |Type                        |MANAGED                                            |       |
# MAGIC |Location                    |/tmp/random_directory                              |       |
# MAGIC |Provider                    |delta                                              |       |
# MAGIC |Table Properties            |[delta.minReaderVersion=1,delta.minWriterVersion=2]|       |
# MAGIC +----------------------------+---------------------------------------------------+-------+
# MAGIC ```

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Time Travel

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC [Time Travel](https://books.japila.pl/delta-lake-internals/time-travel/)

# COMMAND ----------

spark.range(5).write.format('delta').saveAsTable('delta_table')

# COMMAND ----------

# MAGIC %sql
# MAGIC
# MAGIC desc extended delta_table

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ```
# MAGIC >>> spark.read.option('versionAsOf', 3).format('delta').load('/Users/jacek/dev/oss/spark/spark-warehouse/delta_table@v2').show()
# MAGIC Traceback (most recent call last):
# MAGIC   File "<stdin>", line 1, in <module>
# MAGIC   File "/Users/jacek/dev/oss/spark/python/pyspark/sql/readwriter.py", line 307, in load
# MAGIC     return self._df(self._jreader.load(path))
# MAGIC   File "/Users/jacek/dev/oss/spark/python/lib/py4j-0.10.9.7-src.zip/py4j/java_gateway.py", line 1322, in __call__
# MAGIC   File "/Users/jacek/dev/oss/spark/python/pyspark/errors/exceptions/captured.py", line 185, in deco
# MAGIC     raise converted from None
# MAGIC pyspark.errors.exceptions.captured.AnalysisException: [DELTA_UNSUPPORTED_TIME_TRAVEL_MULTIPLE_FORMATS] Cannot specify time travel in multiple formats.
# MAGIC ```

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Exercise
# MAGIC
# MAGIC 1. Create a delta table
# MAGIC 1. Insert, delete, update this delta table
# MAGIC 1. Check out the versions (`DESC HISTORY`)
# MAGIC 1. Load different versions of this delta table
# MAGIC     * Use `path@v[VERSION]` style
# MAGIC     * `versionAsOf` option with the table name (from the Spark catalog)
# MAGIC     * `versionAsOf` option with the path

# COMMAND ----------

# MAGIC %sql
# MAGIC use catalog

# COMMAND ----------

spark.range(1).write.format('delta').saveAsTable('delta_table')

# COMMAND ----------

sql('INSERT INTO demo_table VALUES (1),(2),(3)')
sql('delete from demo_table where id = 1')
sql('update demo_table set id=2 where id=2').show(truncate=False)
sql('desc history demo_table').select('version', 'operation', 'isBlindAppend').show(truncate=False)
v0 = spark.read.option('versionAsOf', 0).table('demo_table')
v1 = sql('select * from delta.`/Users/jacek/dev/oss/spark/spark-warehouse/demo_table@v1`')

https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/api/pyspark.sql.DataFrame.exceptAll.html

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Exercise
# MAGIC
# MAGIC [Demo](https://books.japila.pl/delta-lake-internals/demo/)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## DMLs
# MAGIC
# MAGIC [Table deletes, updates, and merges](https://docs.delta.io/latest/delta-update.html)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Delta Table Utilities
# MAGIC
# MAGIC [Table utility commands](https://docs.delta.io/latest/delta-utility.html)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Table Features
# MAGIC
# MAGIC 1. [What are table features?](https://docs.delta.io/latest/versioning.html#what-are-table-features)
# MAGIC 1. [Drop Delta table features](https://docs.delta.io/latest/delta-drop-feature.html)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Constraints
# MAGIC
# MAGIC [Constraints](https://docs.delta.io/latest/delta-constraints.html)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Default Column Values
# MAGIC
# MAGIC [Default Column Values](https://docs.delta.io/latest/delta-default-columns.html)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Deletion Vectors
# MAGIC
# MAGIC [Deletion Vectors](https://docs.delta.io/latest/delta-deletion-vectors.html)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Change Data Feed
# MAGIC
# MAGIC [Change Data Feed](https://docs.delta.io/latest/delta-change-data-feed.html)
