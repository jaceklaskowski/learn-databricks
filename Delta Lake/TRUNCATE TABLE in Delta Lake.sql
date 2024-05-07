-- Databricks notebook source
-- MAGIC %md # TRUNCATE TABLE in Delta Lake
-- MAGIC
-- MAGIC The not-so-obvious ways

-- COMMAND ----------

-- MAGIC %scala
-- MAGIC
-- MAGIC // `truncateTable` = `TRUNCATE TABLE` was running perfectly fine with Hive
-- MAGIC // 1k tests that did `TRUNCATE TABLE` and `INSERT INTO` 3-10-20 records, do some testing and it's over and over again.
-- MAGIC
-- MAGIC // With Hive, it took 30 mins
-- MAGIC
-- MAGIC // Switching from `format("hive")` to `format("delta")`
-- MAGIC
-- MAGIC // With Delta Lake, it took 5 hours
-- MAGIC
-- MAGIC // TRUNCATE TABLE is NOT supported by Delta Lake (open-source version / outside Databricks)
-- MAGIC // because...all the tests were executed OUTSIDE Databricks
-- MAGIC
-- MAGIC // Why do you think the time could even increase?!
-- MAGIC // 1. Metadata! What happens when you `DELETE FROM` / `TRUNCATE` => a new version is created (= a disk op)
-- MAGIC
-- MAGIC protected def truncateTable(databaseName: String, tableName: String): Unit = {
-- MAGIC   val fullTableName = s"$databaseName.$tableName"
-- MAGIC
-- MAGIC   val beforeNs = System.nanoTime()
-- MAGIC
-- MAGIC   // Approach #0
-- MAGIC   // val approach = "DELETE FROM"
-- MAGIC   // spark.sql(s"DELETE FROM $databaseName.$tableName")
-- MAGIC
-- MAGIC   // Approach #1
-- MAGIC   // https://stackoverflow.com/a/67519402/1305344
-- MAGIC   val approach = "limit(0)"
-- MAGIC   spark.table(fullTableName).limit(0).write.mode("overwrite").format("delta").saveAsTable(fullTableName)
-- MAGIC
-- MAGIC   // Approach #2
-- MAGIC   // 10x slower than DELETE FROM
-- MAGIC   // https://docs.delta.io/latest/delta-utility.html#remove-files-no-longer-referenced-by-a-delta-table
-- MAGIC   // VACUUM RETAIN 0 HOURS
-- MAGIC   //   .config("spark.databricks.delta.retentionDurationCheck.enabled", "false")
-- MAGIC   //   .config("spark.databricks.delta.vacuum.parallelDelete.enabled", "true")
-- MAGIC   // val approach = "VACUUM RETAIN 0 HOURS"
-- MAGIC   // spark.sql(s"VACUUM $fullTableName RETAIN 0 HOURS")
-- MAGIC
-- MAGIC   // Approach #3
-- MAGIC   // https://spark.apache.org/docs/latest/sql-ref-syntax-ddl-truncate-table.html
-- MAGIC   // Not supported in Delta Lake OSS
-- MAGIC   // val approach = "TRUNCATE TABLE"
-- MAGIC   // spark.sql(s"TRUNCATE TABLE $databaseName.$tableName")
-- MAGIC
-- MAGIC   // Approach #4
-- MAGIC   // val approach = "DeltaTable API"
-- MAGIC   // import io.delta.tables.DeltaTable
-- MAGIC   // DeltaTable.forName(fullTableName).delete()
-- MAGIC
-- MAGIC   val tookSecs = (System.nanoTime() - beforeNs) / 1e+9
-- MAGIC   println(s">>> truncateTable($fullTableName) took ${tookSecs}s (using $approach)")
-- MAGIC }

-- COMMAND ----------

DROP TABLE IF EXISTS jacek_demo

-- COMMAND ----------

CREATE TABLE jacek_demo
AS SELECT 1

-- COMMAND ----------

DESCRIBE HISTORY jacek_demo

-- COMMAND ----------

SELECT * FROM jacek_demo

-- COMMAND ----------

TRUNCATE TABLE jacek_demo

-- COMMAND ----------

DESCRIBE HISTORY jacek_demo

-- COMMAND ----------

SELECT * FROM jacek_demo
