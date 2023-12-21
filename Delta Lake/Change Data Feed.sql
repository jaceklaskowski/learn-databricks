-- Databricks notebook source
-- MAGIC %md # Change Data Feed

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## DLT Demo
-- MAGIC
-- MAGIC W tym temacie interesuje nas jakiś przykład, w którym za pomocą DLT załadujemy przyrostowo tabele na podstawie kilku złączonych tabel (`JOIN`). Innymi słowy chcemy uzyskać odpowiedź i zobaczyć czy za pomocą DLT da się ładować warstwę GOLD w trybie CDC/CDF.
-- MAGIC
-- MAGIC Przykładowe zapytanie, na podstawie którego powinna być ładowana/aktualizowana tabela w GOLD np. tabela **gold.fact_loaded_cdc**. Spodziewamy się, ze jeżeli zostaną zaktualizowane/załadowane nowe rekordy w silver.tab1 to w tabeli gold. `gold.fact_loaded_cdc` zostaną załadowane/zaktualizowane odpowiednie wpisy.

-- COMMAND ----------

-- MAGIC %md ## Problem Pawła
-- MAGIC
-- MAGIC ja tez mam z tym problem jak to rozumiec...dla mnie przy DLT @dlt.table dla strumieniowych danych tworzy DLT materialized view co jest bardzo mylace bo wraper jest @dlt.table. i rozumiem ze wiev odtwatrza/materializowane dane tylko dla danych z streaming
-- MAGIC
-- MAGIC ---
-- MAGIC
-- MAGIC Na data + ai summit w tym roku zapowiadali DLT w Databricks SQL. Ten nowy create mat. view co jest w preview wyglada jakby mozna było uzyc tylko w tych nowych DLT, tylko te applies to: Databricks SQL jest misleading, powinni dodac ze to dotyczy tylko 
-- MAGIC
-- MAGIC ---
-- MAGIC
-- MAGIC Czyli materialized view == live table? Czemu nie zachowali originalnej nazwy z DLT? :/
-- MAGIC
-- MAGIC

-- COMMAND ----------

-- select
--   t1.name,
--   case
--     when t1.name = 'abc' then t2.quantity * 10
--     else t3.quantity
--   end as quantity,
--   t2.col1,
--   t3.col1
-- from
--   silver.tab1 t1
--   inner join silver.tab2 t2 on t2.id = t1.id
--   left join silver.tab3 t3 on t3.id = t1.id

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Demo
-- MAGIC
-- MAGIC [Demo: Change Data Feed](https://books.japila.pl/delta-lake-internals/demo/change-data-feed/)

-- COMMAND ----------

-- MAGIC %md ### Intro

-- COMMAND ----------

CREATE SCHEMA IF NOT EXISTS jacek_laskowski;

-- COMMAND ----------

USE jacek_laskowski;

-- COMMAND ----------

-- MAGIC %md ### Main Stream

-- COMMAND ----------

DROP TABLE IF EXISTS cdf_demo;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC Why....równoległe odpalenie SQLek

-- COMMAND ----------

CREATE TABLE cdf_demo (id INT, name STRING)
USING delta
TBLPROPERTIES (delta.enableChangeDataFeed = true);

-- COMMAND ----------

-- NOTE: No table version
SELECT * FROM cdf_demo;

-- COMMAND ----------

INSERT INTO cdf_demo VALUES (0, 'insert into');

-- COMMAND ----------

SELECT * FROM cdf_demo;

-- COMMAND ----------

SELECT * FROM cdf_demo@v0;

-- COMMAND ----------

DESC EXTENDED cdf_demo

-- COMMAND ----------

-- MAGIC %scala
-- MAGIC
-- MAGIC val df = sql("DESC EXTENDED cdf_demo")
-- MAGIC df.where("Location")

-- COMMAND ----------

-- SELECT location
-- FROM (DESC EXTENDED cdf_demo)

-- COMMAND ----------

-- MAGIC %fs ls dbfs:/user/hive/warehouse/jacek_laskowski.db/cdf_demo

-- COMMAND ----------

-- MAGIC %fs ls dbfs:/user/hive/warehouse/jacek_laskowski.db/cdf_demo/_delta_log

-- COMMAND ----------

-- MAGIC %fs head dbfs:/user/hive/warehouse/jacek_laskowski.db/cdf_demo/_delta_log/00000000000000000001.json

-- COMMAND ----------

DESC HISTORY cdf_demo

-- COMMAND ----------

UPDATE cdf_demo SET name = 'update' WHERE id = 0;

-- COMMAND ----------

DESC HISTORY cdf_demo

-- COMMAND ----------

-- MAGIC %fs ls dbfs:/user/hive/warehouse/jacek_laskowski.db/cdf_demo/

-- COMMAND ----------

-- MAGIC %fs ls dbfs:/user/hive/warehouse/jacek_laskowski.db/cdf_demo/_change_data/

-- COMMAND ----------

SET spark.databricks.delta.formatCheck.enabled=false

-- COMMAND ----------

SELECT * FROM parquet.`dbfs:/user/hive/warehouse/jacek_laskowski.db/cdf_demo/_change_data/`

-- COMMAND ----------

-- MAGIC %scala
-- MAGIC
-- MAGIC val changes = spark
-- MAGIC   .read
-- MAGIC   .format("delta")
-- MAGIC   .option("readChangeFeed", true)
-- MAGIC   .option("startingVersion", 0) // could be any version (1, 2 in this example)
-- MAGIC   .table("cdf_demo")
-- MAGIC display(changes)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC Will there ever be `0` in `_commit_version`?

-- COMMAND ----------

-- MAGIC %md ## CDF Table-Valued Functions
-- MAGIC
-- MAGIC [CDF Table-Valued Functions](http://0.0.0.0:8000/delta-lake-internals/table-valued-functions/)

-- COMMAND ----------

SHOW FUNCTIONS LIKE 'table_*';

-- COMMAND ----------

SELECT * FROM table_changes('cdf_demo', 0)

-- COMMAND ----------

-- MAGIC %md ## Streaming CDF (WIP)

-- COMMAND ----------

-- MAGIC %py
-- MAGIC
-- MAGIC dbutils.notebook.exit('work in progress')

-- COMMAND ----------

-- MAGIC %scala
-- MAGIC
-- MAGIC spark
-- MAGIC   .readStream
-- MAGIC   .format("delta")
-- MAGIC   .option("readChangeFeed", true)
-- MAGIC   .table("cdf_demo")
-- MAGIC   .writeStream
-- MAGIC   .format("console")
-- MAGIC   .option("truncate", false)
-- MAGIC   .queryName("Change feed from delta_demo")
-- MAGIC   .start

-- COMMAND ----------

MERGE INTO cdf_demo t
USING (VALUES 5 s(id))
ON t.id = s.id
WHEN NOT MATCHED THEN INSERT *;

-- COMMAND ----------

INSERT INTO cdf_demo VALUES (6);
