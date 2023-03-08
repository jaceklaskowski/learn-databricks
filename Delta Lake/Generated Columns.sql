-- Databricks notebook source
-- MAGIC %md # Generated Columns

-- COMMAND ----------

CREATE OR REPLACE TABLE generated_columns (
  id BIGINT GENERATED ALWAYS AS IDENTITY,
  name STRING,
  five_by_default INT GENERATED ALWAYS AS (5)
)


-- COMMAND ----------

-- MAGIC %md ## SHOW CREATE TABLE
-- MAGIC 
-- MAGIC `SHOW CREATE TABLE` seems the only way to find out generated columns.

-- COMMAND ----------

SHOW CREATE TABLE generated_columns

-- COMMAND ----------

DESC TABLE EXTENDED generated_columns id

-- COMMAND ----------

-- MAGIC %md ## Column Metadata

-- COMMAND ----------

-- MAGIC %scala
-- MAGIC 
-- MAGIC import org.apache.spark.sql.connector.catalog.TableCatalog
-- MAGIC import org.apache.spark.sql.connector.catalog.Identifier
-- MAGIC val table = spark.sessionState.catalogManager.currentCatalog.asInstanceOf[TableCatalog].loadTable(Identifier.of(Array("default"), "generated_columns"))
-- MAGIC 
-- MAGIC import com.databricks.sql.transaction.tahoe.catalog.DeltaTableV2
-- MAGIC table.asInstanceOf[DeltaTableV2].snapshot.tableDataSchema.map(_.metadata).foreach(println)

-- COMMAND ----------

-- MAGIC %md ## Using High-Level API
-- MAGIC 
-- MAGIC Using the Developer API seems fruitless as column metadata (where generated column expressions are stored) is cleared up :(

-- COMMAND ----------

-- MAGIC %scala
-- MAGIC 
-- MAGIC import io.delta.tables.DeltaTable
-- MAGIC val dt = DeltaTable.forName("generated_columns")
-- MAGIC dt.toDF.schema.map(c => c.metadata).foreach(println)

-- COMMAND ----------

-- MAGIC %scala
-- MAGIC 
-- MAGIC val table = spark.sharedState.externalCatalog.getTable("default", "generated_columns")
-- MAGIC table.schema.foreach(c => println(c.metadata))
