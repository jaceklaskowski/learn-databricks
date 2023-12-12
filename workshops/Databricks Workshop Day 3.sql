-- Databricks notebook source
-- MAGIC %md # Databricks Workshop Day 3
-- MAGIC
-- MAGIC Duration: 4.5 hours (9:30-14:00)

-- COMMAND ----------

-- MAGIC %md ## Schedule

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC * The class starts at 9:30
-- MAGIC * A class is split into 1-hour blocks with a 12-minute break each
-- MAGIC     * Breaks at the end of an hour
-- MAGIC     * However, the first 20' break is at 10:30 (till 10:50)

-- COMMAND ----------

-- MAGIC %md ## Agenda

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC 1. (spark) [The Internals of Structured Query Execution](https://jaceklaskowski.github.io/spark-workshop/slides/spark-sql-internals-of-structured-query-execution.html)
-- MAGIC     * jak czytać, na co zwracać uwagę 
-- MAGIC     * omówić ogólnie
-- MAGIC     * analiza na przykładzie załadunku do silver i MOLka
-- MAGIC     * [Exercise: How to add days (as values of a column) to date?](https://jaceklaskowski.github.io/spark-workshop/exercises/sql/How-to-add-days-as-values-of-a-column-to-date.html)
-- MAGIC     * [Exercise: split function with variable delimiter per row](https://jaceklaskowski.github.io/spark-workshop/exercises/sql/split-function-with-variable-delimiter-per-row.html)
-- MAGIC 1. (spark) Narrow and Wide Transformations
-- MAGIC     * [Basic Aggregation](https://jaceklaskowski.github.io/spark-workshop/slides/spark-sql-basic-aggregation.html#/home)
-- MAGIC     * [Exercise: Finding Ids of Rows with Word in Array Column](https://jaceklaskowski.github.io/spark-workshop/exercises/sql/Finding-Ids-of-Rows-with-Word-in-Array-Column.html)
-- MAGIC     * [Windowed Aggregation](https://jaceklaskowski.github.io/spark-workshop/slides/spark-sql-windowed-aggregation.html#/home)
-- MAGIC     * [Exercise: Finding 1st and 2nd Bestsellers Per Genre](https://jaceklaskowski.github.io/spark-workshop/exercises/sql/Finding-1st-and-2nd-Bestsellers-Per-Genre.html)
-- MAGIC     * [Exercise: Calculating Gap Between Current And Highest Salaries Per Department](https://jaceklaskowski.github.io/spark-workshop/exercises/sql/Calculating-Gap-Between-Current-And-Highest-Salaries-Per-Department.html)
-- MAGIC     * [Exercise: Calculating Difference Between Consecutive Rows Per Window](https://jaceklaskowski.github.io/spark-workshop/exercises/sql/Calculating-Difference-Between-Consecutive-Rows-Per-Window.html)
-- MAGIC     * [Demo: Dynamic Partition Pruning](https://books.japila.pl/spark-sql-internals/demo/dynamic-partition-pruning/)
-- MAGIC 1. (spark) Data Shuffle
-- MAGIC     * jak sprawdzić czy występują w planie zapytania
-- MAGIC     * w jakich sytuacjach i jak możemy przeciwdziałać
-- MAGIC     * możemy zerknąć na plan wykonania naszego ładowania
-- MAGIC     * kiedy warto stosować [Bucketing](https://books.japila.pl/spark-sql-internals/bucketing/)
-- MAGIC     * [Demo: ObjectHashAggregateExec and Sort-Based Fallback Tasks](https://books.japila.pl/spark-sql-internals/demo/objecthashaggregateexec-sort-based-fallback-tasks/)
-- MAGIC     * [Demo: Spilling](https://books.japila.pl/spark-sql-internals/demo/spilling/)
-- MAGIC 1. (spark) [Joins](https://jaceklaskowski.github.io/spark-workshop/slides/spark-sql-joins.html)
-- MAGIC     * joiny, hinty itp (broadcasty), jak sobie radzic z joinami duzych tabel
-- MAGIC     * range joiny -> czy stosować, jak stosować, wszystkie podziały itp
-- MAGIC     * [Bloom Filter Join](https://books.japila.pl/spark-sql-internals/bloom-filter-join/)
-- MAGIC     * [Runtime Filtering](https://books.japila.pl/spark-sql-internals/runtime-filtering/)
-- MAGIC     * [Exercise: Finding Most Populated Cities Per Country](https://jaceklaskowski.github.io/spark-workshop/exercises/sql/Finding-Most-Populated-Cities-Per-Country.html)
-- MAGIC     * [Exercise: Selecting the most important rows per assigned priority](https://jaceklaskowski.github.io/spark-workshop/exercises/sql/selecting-the-most-important-rows-per-assigned-priority.html)
-- MAGIC 1. [Adaptive Query Execution (AQE)](https://books.japila.pl/spark-sql-internals/adaptive-query-execution/)
-- MAGIC 1. (delta lake/databricks) [Change Data Feed / Change Data Capture](https://books.japila.pl/delta-lake-internals/change-data-feed/)
-- MAGIC     * "Pure" Delta Lake (not Delta Live Tables)
-- MAGIC     * Mediallion Architecture
-- MAGIC     * The Gold layer based on CDF of (a JOIN query of) tables from the Silver layer
-- MAGIC     * [Use Delta Lake change data feed on Databricks](https://docs.databricks.com/en/delta/delta-change-data-feed.html)
-- MAGIC     * [Demo: Change Data Feed](https://books.japila.pl/delta-lake-internals/demo/change-data-feed/)
-- MAGIC     * [Notebook example: Propagate changes with Delta change data feed](https://docs.databricks.com/en/delta/delta-change-data-feed.html#notebook-example-propagate-changes-with-delta-change-data-feed)
-- MAGIC
