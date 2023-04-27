// Databricks notebook source
// MAGIC %md # Parquet Connector

// COMMAND ----------

// MAGIC %md
// MAGIC 
// MAGIC ## Requirements
// MAGIC 
// MAGIC 1. A load-save query (loading a parquet dataset, `Dataset.map` over records and saving it out)
// MAGIC     1. Let's call `Dataset.map` operation as `samanta`
// MAGIC 1. A Scala case class as a record
// MAGIC 1. 1 partition
// MAGIC 1. 1GB per record

// COMMAND ----------

// MAGIC %md
// MAGIC 
// MAGIC ## Open questions and observations
// MAGIC 
// MAGIC 1. Vectorized parquet decoding seems making query processing faster
// MAGIC 1. `Dataset.map` vs `Dataset.mapPartitions`

// COMMAND ----------

// MAGIC %md ## Experiment

// COMMAND ----------

val input = "/Users/jacek@japila.pl/1g.parquet"
val output = "/Users/jacek@japila.pl/1g.parquet_output"

// COMMAND ----------

dbutils.fs.rm(dir = input, recurse = true)
dbutils.fs.rm(dir = output, recurse = true)

// COMMAND ----------

// MAGIC %md ### Prepare 1G parquet dataset

// COMMAND ----------

// 

// Each number takes up 4 bytes
// 1 billion numbers gives 4GB
// We just need 1GB (hence division by 4)

spark.range(1000*1000*1000 / 4).repartition(1).write.format("parquet").mode("overwrite").save(input)

// COMMAND ----------

// MAGIC %fs ls /Users/jacek@japila.pl/1g.parquet/

// COMMAND ----------

// MAGIC %md ### Run the query

// COMMAND ----------

sc.setJobDescription(s"mapPartition over parquet ($dataset)")

// https://docs.databricks.com/optimizations/disk-cache.html
spark.conf.set("spark.databricks.io.cache.enabled", "false")

import spark.implicits._
case class MyRecord(id: Long, name: String)

// FIXME Każdy task po 1GB i takich rekodów ~1k

// FIXME What exactly should samanta convert to?
val samanta = (mr: MyRecord) => r

spark
  .read
  .parquet(input)
  .as[MyRecord]
  // .map(samanta)
  .write
  .format("parquet")
  .save(output)

// COMMAND ----------

// Skip the rest
dbutils.notebook.exit("skip the rest")

// COMMAND ----------

sc.setJobDescription("mapPartition over parquet (data20K)")

# https://docs.databricks.com/optimizations/disk-cache.html
spark.conf.set("spark.databricks.io.cache.enabled", "false")

val samanta_jeden_rekord = r => r
val samanta = rs => Iterator.single(rs.length) // rs.map(samanta_jeden_rekord)

// FIXME
// 1 task / partycja
// 1 executor only najmniejszy
// rekord waży 1G (case class = row)
// zbadać row groups
// mapPartitions vs map
val r = spark.read.schema("rating DOUBLE,review STRING").parquet("/databricks-datasets/amazon/data20K").mapPartitions(samanta)
display(r)

// COMMAND ----------

// MAGIC %md
// MAGIC 
// MAGIC ## Spark QA
// MAGIC 
// MAGIC 1. Introduction to JVM (Łukasz)
