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
