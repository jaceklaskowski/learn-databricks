-- Databricks notebook source
-- MAGIC %md # Merge

-- COMMAND ----------

-- MAGIC %md ## Examples

-- COMMAND ----------

-- MAGIC %md ### Conditional Update with Delete

-- COMMAND ----------

DROP TABLE IF EXISTS source;
DROP TABLE IF EXISTS target;

-- COMMAND ----------

CREATE TABLE source
USING delta
AS VALUES
  (0, 0),
  (1, 10),
  (2, 20) AS data(key, value);

-- COMMAND ----------

select * from source;

-- COMMAND ----------

CREATE TABLE target
USING delta
AS VALUES
  (1, 1),
  (2, 2),
  (3, 3) AS data(key, value);

-- COMMAND ----------

select * from target;

-- COMMAND ----------

MERGE INTO target t
USING source s
ON s.key = t.key
WHEN MATCHED AND s.key <> 1 THEN UPDATE SET key = s.key, value = s.value
WHEN MATCHED THEN DELETE

-- COMMAND ----------

select * from target;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Learning Resources

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC * [The Internals of Delta Lake](https://books.japila.pl/delta-lake-internals/commands/merge/)
