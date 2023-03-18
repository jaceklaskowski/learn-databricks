-- Databricks notebook source
-- MAGIC %md # Bucketing

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC * Not supported by Delta Lake

-- COMMAND ----------

DROP SCHEMA jaceklaskowski CASCADE;

-- COMMAND ----------

-- SCHEMA == DATABASE
CREATE SCHEMA jaceklaskowski;
USE jaceklaskowski;

-- COMMAND ----------

CREATE TABLE bucketed (
  id BIGINT,
  name STRING,
  type STRING)
USING parquet
CLUSTERED BY (type) INTO 8 BUCKETS

-- COMMAND ----------

-- MAGIC %scala
-- MAGIC 
-- MAGIC import org.apache.spark.sql.SaveMode
-- MAGIC spark.range(10e4.toLong).write.format("parquet").mode(SaveMode.Overwrite).saveAsTable("jaceklaskowski.t10e4")
-- MAGIC spark.range(10e6.toLong).write.format("parquet").mode(SaveMode.Overwrite).saveAsTable("jaceklaskowski.t10e6")

-- COMMAND ----------

SHOW TABLES

-- COMMAND ----------

-- MAGIC %scala
-- MAGIC 
-- MAGIC sc.setJobDescription("Setup")
-- MAGIC 
-- MAGIC spark.conf.set("spark.sql.autoBroadcastJoinThreshold", -1)
-- MAGIC spark.conf.set("spark.sql.adaptive.enabled", false)
-- MAGIC 
-- MAGIC // https://docs.databricks.com/optimizations/disk-cache.html
-- MAGIC spark.conf.set("spark.databricks.io.cache.enabled", false)

-- COMMAND ----------

-- MAGIC %scala
-- MAGIC 
-- MAGIC sc.setJobDescription("Non-Bucketed Join")
-- MAGIC 
-- MAGIC val t4 = spark.table("t10e4")
-- MAGIC val t6 = spark.table("t10e6")
-- MAGIC 
-- MAGIC assert(t4.count == 10e4)
-- MAGIC assert(t6.count == 10e6)
-- MAGIC 
-- MAGIC // trigger execution of the join query
-- MAGIC t4.join(t6, "id").foreach(_ => ())

-- COMMAND ----------

-- MAGIC %scala
-- MAGIC 
-- MAGIC sc.setJobDescription("Create Bucketed Tables")
-- MAGIC 
-- MAGIC import org.apache.spark.sql.SaveMode
-- MAGIC spark.range(10e4.toLong)
-- MAGIC   .write
-- MAGIC   .format("parquet")
-- MAGIC   .bucketBy(4, "id")
-- MAGIC   .sortBy("id")
-- MAGIC   .mode(SaveMode.Overwrite)
-- MAGIC   .saveAsTable("bucketed_4_10e4")
-- MAGIC 
-- MAGIC spark.range(10e6.toLong)
-- MAGIC   .write
-- MAGIC   .format("parquet")
-- MAGIC   .bucketBy(4, "id")
-- MAGIC   .sortBy("id")
-- MAGIC   .mode(SaveMode.Overwrite)
-- MAGIC   .saveAsTable("bucketed_4_10e6")

-- COMMAND ----------

-- MAGIC %scala
-- MAGIC 
-- MAGIC sc.setJobDescription("Bucketed Join")
-- MAGIC 
-- MAGIC val bucketed_4_10e4 = spark.table("bucketed_4_10e4")
-- MAGIC val bucketed_4_10e6 = spark.table("bucketed_4_10e6")
-- MAGIC bucketed_4_10e4.join(bucketed_4_10e6, "id").foreach(_ => ())
