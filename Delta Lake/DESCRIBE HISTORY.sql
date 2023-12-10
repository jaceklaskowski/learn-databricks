-- Databricks notebook source
-- MAGIC %md # DESCRIBE HISTORY
-- MAGIC
-- MAGIC `DESCRIBE HISTORY` command can be used in subqueries in Delta Lake (on [Databricks only](https://twitter.com/jaceklaskowski/status/1733466666749526278)).

-- COMMAND ----------

-- https://docs.databricks.com/en/sql/language-manual/sql-ref-syntax-ddl-create-table-using.html
CREATE TABLE my_students (id INT, name STRING, age INT);

-- COMMAND ----------

-- https://docs.databricks.com/en/sql/language-manual/sql-ref-syntax-dml-insert-into.html
INSERT INTO my_students
VALUES
  (0, 'Jacek', 50);

-- COMMAND ----------

SELECT *
FROM (
  DESCRIBE HISTORY my_students
)
WHERE version = 1;

-- COMMAND ----------

-- MAGIC %scala
-- MAGIC
-- MAGIC val q = sql("""SELECT *
-- MAGIC FROM (
-- MAGIC   DESCRIBE HISTORY my_students
-- MAGIC )
-- MAGIC WHERE version = 1;""")
-- MAGIC q.explain(extended = true)

-- COMMAND ----------

-- MAGIC %md ## DESCRIBE HISTORY Command
-- MAGIC
-- MAGIC A little about the internals of [DESCRIBE HISTORY Command](https://books.japila.pl/delta-lake-internals/commands/describe-history/)
-- MAGIC
-- MAGIC * a mere wrapper around `DeltaHistoryManager` to access the history of a delta table
-- MAGIC * Possible Cost Optimization on Microsoft Azure using `spark.databricks.delta.history.maxKeysPerList` configuration property

-- COMMAND ----------

SET spark.databricks.delta.history.maxKeysPerList
