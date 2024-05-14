# Databricks notebook source
# MAGIC %md
# MAGIC
# MAGIC # ANTI and SEMI joins in SQL and DataFrame API

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Discovery of the Day
# MAGIC
# MAGIC There's no `DataFrame.createOrReplaceView` in PySpark and Scala APIs 😬
# MAGIC
# MAGIC `CREATE VIEW` only.

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## SQL Join types explained with 1 picture
# MAGIC
# MAGIC [SQL Join types explained with 1 picture](https://www.securesolutions.no/sql-join-types-explained-with-1-picture/)
# MAGIC
# MAGIC ![Joins](https://www.securesolutions.no/wp-content/uploads/2014/07/joins-1.jpg)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## SQL Joins
# MAGIC
# MAGIC [SQL Joins](https://www.w3schools.com/sql/sql_join.asp)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## JOINs in Spark SQL
# MAGIC
# MAGIC [JOIN](https://spark.apache.org/docs/latest/sql-ref-syntax-qry-select-join.html)

# COMMAND ----------

left = spark.range(3)

# COMMAND ----------

# MAGIC %md ## Left anti join
# MAGIC
# MAGIC ![Left anti join](https://learn.microsoft.com/en-us/power-query/media/merge-queries-left-anti/left-anti-join-operation.png)

# COMMAND ----------

# MAGIC %md ## Left Semi JOIN
# MAGIC
# MAGIC * [Difference Between Anti-Join and Semi-Join](https://www.geeksforgeeks.org/difference-between-anti-join-and-semi-join/)
# MAGIC * [Difference between INNER JOIN and LEFT SEMI JOIN](https://stackoverflow.com/q/21738784/1305344)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## DataFrame API
# MAGIC
# MAGIC * [DataFrame.except](https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/api/pyspark.sql.DataFrame.except.html)
# MAGIC * [DataFrame.subtract](https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/api/pyspark.sql.DataFrame.subtract.html)
# MAGIC * [DataFrame.intersect](https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/api/pyspark.sql.DataFrame.intersect.html)

# COMMAND ----------

left = spark.range(5)
dups_left = left.union(left)
two_threes = spark.createDataFrame([3,3], 'int').withColumnRenamed('value', 'id')
dups_left_with_threes = dups_left.union(two_threes)
right = spark.range(3, 8, 1)

# COMMAND ----------

two_threes.display()

# COMMAND ----------

left.join(right, 'id', 'L_E_f_t_aN_tI').display()

# COMMAND ----------

left.exceptAll(right).display()

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC programmatic vs maths approach

# COMMAND ----------

two_threes.join(right, 'id', 'left_anti').display()

# COMMAND ----------

two_threes.exceptAll(right).display()

# COMMAND ----------

two_threes.subtract(right).display()

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Mind Query Plans
# MAGIC
# MAGIC Explore query plans with larger datasets (best would be to use delta tables) before claiming that one is better than the others 😜
# MAGIC
# MAGIC Danke schon, Paul, for bringing it up to my attention! 🥳
