-- Databricks notebook source
-- MAGIC %md
-- MAGIC # Parameterized Queries
-- MAGIC
-- MAGIC [The Internals of Spark SQL](https://books.japila.pl/spark-sql-internals/parameterized-queries/)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Parameter markers
-- MAGIC
-- MAGIC [Parameter markers](https://docs.databricks.com/en/sql/language-manual/sql-ref-parameter-marker.html)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC The following parameterized query does not seem to work in Databricks (as I hoped) and fails with the exception:
-- MAGIC
-- MAGIC > org.apache.spark.sql.catalyst.ExtendedAnalysisException: [UNBOUND_SQL_PARAMETER] Found the unbound parameter: limitA. Please, fix `args` and provide a mapping of the parameter to either a SQL literal or collection constructor functions such as `map()`, `array()`, `struct()`. SQLSTATE: 42P02; line 4 pos 6;
-- MAGIC
-- MAGIC ```sql
-- MAGIC WITH a AS (SELECT 1 c)
-- MAGIC SELECT *
-- MAGIC FROM a
-- MAGIC LIMIT : limitA
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## DECLARE VARIABLE
-- MAGIC
-- MAGIC [DECLARE VARIABLE](https://docs.databricks.com/en/sql/language-manual/sql-ref-syntax-ddl-declare-variable.html)

-- COMMAND ----------

DECLARE OR REPLACE VARIABLE limitA INT DEFAULT 5;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## SET VARIABLE
-- MAGIC
-- MAGIC [SET VARIABLE](https://docs.databricks.com/en/sql/language-manual/sql-ref-syntax-aux-set-variable.html)

-- COMMAND ----------

SET VARIABLE limitA=10

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## EXECUTE IMMEDIATE
-- MAGIC
-- MAGIC [EXECUTE IMMEDIATE](https://docs.databricks.com/en/sql/language-manual/sql-ref-syntax-aux-execute-immediate.html)

-- COMMAND ----------

DECLARE OR REPLACE sqlStr = 'WITH a AS (SELECT "It works! 🔥" result)
SELECT *
FROM a
LIMIT :limitA';

-- COMMAND ----------

DECLARE OR REPLACE limitA = 5;

-- COMMAND ----------

EXECUTE IMMEDIATE sqlStr USING (limitA AS limitA);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Learn More
-- MAGIC
-- MAGIC 1. [Parameterized queries with PySpark](https://www.databricks.com/blog/parameterized-queries-pyspark)
