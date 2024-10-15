# Databricks notebook source
# MAGIC %md
# MAGIC
# MAGIC # Apache Spark Workshop
# MAGIC
# MAGIC This course prepares you to become an Apache Spark expert! 😎
# MAGIC
# MAGIC **Duration**: 5 days

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC This is your DataFrame:
# MAGIC
# MAGIC Partition | Values | # counters | Partial Results
# MAGIC -|-|-|-
# MAGIC Partition1 | a a a b | 2 | (a, 3), (b, 1)
# MAGIC Partition2 | b b b | 1 | (b, 3)
# MAGIC
# MAGIC A sample query: `data.groupBy('letter').count()`
# MAGIC
# MAGIC You execute `count()` on the dataset with the two partitions
# MAGIC
# MAGIC count() -> up to `2n` counters per every partition and `n` number of distinct values
# MAGIC * 1 for the first partition
# MAGIC * 2 for the second partition
# MAGIC
# MAGIC `groupBy('letter)`

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC > Can we remove the last day (Structured Streaming), and possibly run the 4 days worth of content as a 5 day training to leave more space for labs / questions / discussions.

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Instructor
# MAGIC
# MAGIC * **Jacek Laskowski** is a Freelance Data(bricks) Engineer
# MAGIC * Specializing in Apache Spark, Delta Lake, Databricks, and Apache Kafka
# MAGIC * Development | Consulting | Training
# MAGIC * Among contributors to [Apache Spark](https://spark.apache.org/), [Delta Lake](https://delta.io/), [Unity Catalog](https://www.unitycatalog.io/)
# MAGIC * Contact me at jacek@japila.pl
# MAGIC * Follow [@JacekLaskowski](https://twitter.com/jaceklaskowski) on X/twitter for more #ApacheSpark, #Databricks, #DeltaLake, #UnityCatalog
# MAGIC * Best known by [The Internals of Online Books](https://books.japila.pl/)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Goal
# MAGIC
# MAGIC 1. Advance in solving analytical problems using PySpark and Delta Lake
# MAGIC 1. Use Apache Spark for data pipeline development and deployment
# MAGIC 1. Use Delta Lake for data management

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Agenda

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ### Day 1. The Essentials of PySpark SQL
# MAGIC
# MAGIC 1. Foundations of Spark SQL
# MAGIC     1. SparkSession
# MAGIC 1. Exercise: Create a PySpark command-line application
# MAGIC 1. Dataset and DataFrame APIs
# MAGIC 1. Columns and Dataset Operators
# MAGIC
# MAGIC The slides at [Day 1. The Essentials of Spark SQL](https://jaceklaskowski.github.io/spark-workshop/slides/00_agenda-5-days-Apache-Spark-with-Scala-for-PySpark-Developers-Workshop.html#/day1)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ### Day 2. PySpark SQL
# MAGIC
# MAGIC 1. [Standard Functions](https://jaceklaskowski.github.io/spark-workshop/slides/spark-sql-standard-functions-udfs.html#/home)
# MAGIC 1. User-Defined Functions
# MAGIC 1. Basic Aggregation
# MAGIC 1. Structured Query Execution
# MAGIC     1. Logical and Physical Optimizations
# MAGIC     1. Adaptive Query Execution
# MAGIC     1. Whole-Stage Code Generation
# MAGIC     1. Join Optimizations

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ### Question
# MAGIC
# MAGIC Why did we end up with 3 parquet files for `spark.range(2).write.saveAsTable('a')`?
# MAGIC
# MAGIC 1. Every DataFrame is a collection of partitions (indexed from 0 and on)
# MAGIC
# MAGIC ```
# MAGIC >>> spark.range(2).explain()
# MAGIC == Physical Plan ==
# MAGIC *(1) Range (0, 2, step=1, splits=12)
# MAGIC ```
# MAGIC
# MAGIC splits are a HDFS thing
# MAGIC
# MAGIC In HDFS, files are **split** into data splits (data chunks)
# MAGIC
# MAGIC splits (HDFS) = partition (Spark)
# MAGIC
# MAGIC 2 elements should be in 12 partitions
# MAGIC
# MAGIC What partitioning strategy would you choose to...
# MAGIC
# MAGIC Round robin
# MAGIC
# MAGIC Hash Partitioning
# MAGIC
# MAGIC Range partitioning
# MAGIC
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ### Day 3. Delta Lake
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
# MAGIC 👉 [03 Delta Lake]($./03 Delta Lake)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ### Day 4. Advanced PySpark SQL
# MAGIC
# MAGIC 1. Joins
# MAGIC 1. Windowed Aggregation
# MAGIC 1. Multi-Dimensional Aggregation
# MAGIC 1. Monitoring
# MAGIC     1. Web UI
# MAGIC     1. SparkListeners
# MAGIC 1. SparkSessionExtensions
# MAGIC 1. [User-Defined Aggregate Functions](https://spark.apache.org/docs/latest/sql-ref-functions-udf-aggregate.html)
# MAGIC 1. [Table-Valued Functions](https://spark.apache.org/docs/latest/sql-ref-syntax-qry-select-tvf.html)
# MAGIC 1. Connectors / Data Sources
# MAGIC 1. Performance Tuning

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ### Day 5. Spark Core (1 day)
# MAGIC
# MAGIC 1. SparkContext
# MAGIC 1. RDD API
# MAGIC 1. Caching and Persistence
# MAGIC 1. Checkpointing
# MAGIC 1. Spark Connect
# MAGIC 1. Web UI
# MAGIC 1. Spark Jobs, Stages, Tasks, Partitions
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ### (optional) Unity Catalog
# MAGIC
# MAGIC * A high-level intro
# MAGIC * Data lineage
# MAGIC * OSS vs Databricks UC

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Participants
# MAGIC
# MAGIC 1. 12 people
# MAGIC 1. Primary language: Python (PySpark)
# MAGIC 1. Scala/Python. Actively working on Spark. Is not familiar with internals and tuning.
# MAGIC 1. Operating systems
# MAGIC     1. macOS
# MAGIC     1. MS Windows
# MAGIC 1. IDEs
# MAGIC     1. Visual Code
# MAGIC     1. PyCharm
# MAGIC 1. Build tools
# MAGIC     1. Apache Maven
# MAGIC 1. Familiar with git and command line

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Preinstalled Software
# MAGIC
# MAGIC For participants, I highly recommend they come with the following software installed to make the learning experience smooth:
# MAGIC
# MAGIC 1. Java 17 from https://www.oracle.com/java/technologies/downloads/?er=221886#java17 for their operating system
# MAGIC 2. Apache Spark 3.5.2 (spark-3.5.2-bin-hadoop3.tgz) from https://spark.apache.org/downloads.html
# MAGIC 3. Their favourite IDE and the build tool of their choice
# MAGIC 4. git
# MAGIC 5. A good terminal (iTerm2 on macOS is great, not sure about MS Windows)
# MAGIC 6. Apache Kafka from https://kafka.apache.org/downloads
# MAGIC 7. Optional yet highly recommended, go through "Running the Examples and Shell" https://spark.apache.org/docs/latest/index.html#running-the-examples-and-shell on their operating system, esp. MS Windows may run into troubles due to the underlying file system that's not POSIX-compliant and requires https://github.com/steveloughran/winutils.
# MAGIC     1. [Running Spark Applications on Windows](https://books.japila.pl/apache-spark-internals/tips-and-tricks/running-spark-windows/)
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Schedule
# MAGIC
# MAGIC 1. A class is split into 1-hour blocks with a 12-minute break each.
# MAGIC 1. Each day starts at 9am and ends at 4pm to let students have an extra 1 hour at the end of a day to work alone on exercises and have enough room for some cognitive work at its own pace
# MAGIC 1. Lunch break at 12pm for 1 hour
# MAGIC
# MAGIC [Acting as Teaching Assistant in Optimizing Apache Spark™ on Databricks Course](https://jaceklaskowski.medium.com/acting-as-teaching-assistant-in-optimizing-apache-spark-on-databricks-course-a23d4916e81a)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC NY Time | Poland (start) time
# MAGIC -|-
# MAGIC 9:00 – 9:48 (12’ break) | 15:00 - 15:48
# MAGIC 10:00 – 10:48 (12’ break) | 16:00 - 16:48
# MAGIC 11:00 – 11:48 (12’ break) | 17:00 - 17:48
# MAGIC Lunch break (1h) |
# MAGIC 13:00 – 13:48 (12’ break) | 19:00 - 19:48
# MAGIC 14:00 – 14:48 (12’ break) | 20:00 - 20:48
# MAGIC 15:00 – 15:48 (12’ break) | 21:00 - 21:48
# MAGIC 16:00 – 17:00 a quiet working hour |

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Learning Resources
# MAGIC
# MAGIC 1. [Apache Spark™ and Scala Workshops](https://jaceklaskowski.github.io/spark-workshop/slides/#agendas)
# MAGIC 1. [Apache Spark™ Advanced for Developers Workshop](https://jaceklaskowski.github.io/spark-workshop/slides/00_agenda-5-days-Apache-Spark-Advanced-for-Developers.html#/home)
# MAGIC 1. [Apache Spark™ with Scala for PySpark Developers Workshop](https://jaceklaskowski.github.io/spark-workshop/slides/00_agenda-5-days-Apache-Spark-with-Scala-for-PySpark-Developers-Workshop.html#/home)
# MAGIC 1. [PySpark Overview](https://spark.apache.org/docs/latest/api/python/index.html)
# MAGIC 1. [Exercises for Apache Spark™ and Scala Workshops](https://jaceklaskowski.github.io/spark-workshop/exercises/)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Exercise
# MAGIC
# MAGIC Write a PySpark app that is a Python command-line application that uses Spark SQL's Python API.
# MAGIC
# MAGIC 1. Creates `SparkSession`
# MAGIC 1. Loads data from a given directory (hardcode it at first but then switch to `args`)
# MAGIC 1. Prints out the data (using `show()`)
