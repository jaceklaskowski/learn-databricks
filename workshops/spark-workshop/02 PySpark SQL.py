# Databricks notebook source
# MAGIC %md
# MAGIC
# MAGIC # PySpark SQL

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## User-Defined Functions

# COMMAND ----------

df = spark.range(5)

def five():
    return 5

from pyspark.sql.functions import udf
five_udf = udf(five)

# show() == display()
df.select(five_udf()).display()

# COMMAND ----------

from pyspark.sql.functions import udf

@udf
def five():
    return 5

df.select(five()).show()

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC Let's assume `df` is 1TB of data (around 1k records)
# MAGIC
# MAGIC PySpark = A Python frontend <--py4j--> A JVM backend
# MAGIC
# MAGIC 1k records to be processed by PySpark = each and every record is going to be sent over the wire (one by one) to this JVM instance for the UDF to receive the record to work on (process)
# MAGIC
# MAGIC A UDF = a function that accepts **one record at a time**

# COMMAND ----------

# Pandas UDFs are Spark SQL's UDF that accept pandas.Series
from pyspark.sql.functions import pandas_udf

@pandas_udf(returnType="int")
def five() -> int:
    return 5

df.select(five()).show()

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Scala UDFs in PySpark

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC Create a Scala UDF that's going to be "callable" in PySpark or SQL

# COMMAND ----------

# MAGIC %scala
# MAGIC
# MAGIC // def scala_five(n: Int) = 5 * n
# MAGIC val another_scala_five: Int => Int = n => 5 * n
# MAGIC
# MAGIC // scala_five(6)
# MAGIC
# MAGIC // Gotcha! 🥳
# MAGIC // Aha moment: the types = Scala voodoo 😜
# MAGIC // https://spark.apache.org/docs/latest/api/scala/org/apache/spark/sql/UDFRegistration.html
# MAGIC // spark.udf.register[Int, Int]("my_custom_scala_fn", another_scala_five)
# MAGIC spark.udf.register("my_custom_scala_fn", another_scala_five)
# MAGIC
# MAGIC // import org.apache.spark.sql.functions.udf
# MAGIC // val scala_five_udf = udf(scala_five _)
# MAGIC
# MAGIC // spark.range(5).select(scala_five_udf("id")).show()

# COMMAND ----------

# Whoohoo! It works!
result_df = df.selectExpr("my_custom_scala_fn(id) as id")
result_df.display()

# Is this possible that no data is passed between PySpark frontend and Spark backend?

# COMMAND ----------

result_df.explain()

# COMMAND ----------

# DBTITLE 1,Pandas UDF
# Pandas UDFs are Spark SQL's UDF that accept pandas.Series
from pyspark.sql.functions import pandas_udf

import pandas as pd

@pandas_udf(returnType='int')
def identity(rows: pd.Series) -> pd.Series:
    return rows

df.select(identity('id')).display()

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## split Standard Function

# COMMAND ----------

from pyspark.sql.functions import split

strings = spark.createDataFrame([
    ("50000.0#0#0#", "#"),
    ("0@1000.0@", "@"),
    ("1$", "$"),
    ("1000.00^Test_string", "^")], 'name string, delimiter string')

strings.show()

# COMMAND ----------

from pyspark.sql.functions import expr
strings.select(expr("split(name, delimiter)")).show()

# COMMAND ----------

strings.selectExpr("split(name, delimiter)").show()

# COMMAND ----------

strings.createOrReplaceTempView("strings_table")

# COMMAND ----------

spark.sql("SELECT split(name, delimiter) FROM strings_table").show()

# COMMAND ----------

# MAGIC %sql
# MAGIC
# MAGIC SELECT split(name, delimiter) FROM strings_table

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## 🧑‍💻 Exercise Time

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC 1. https://jaceklaskowski.github.io/spark-workshop/exercises/sql/limiting-collect_set-standard-function.html
# MAGIC 1. https://jaceklaskowski.github.io/spark-workshop/exercises/sql/How-to-add-days-as-values-of-a-column-to-date.html
# MAGIC 1. https://jaceklaskowski.github.io/spark-workshop/exercises/spark-sql-exercise-Difference-in-Days-Between-Dates-As-Strings.html
# MAGIC 1. https://jaceklaskowski.github.io/spark-workshop/exercises/sql/explode-structs-array.html

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Aggregate Functions
# MAGIC
# MAGIC https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/functions.html#aggregate-functions

# COMMAND ----------

ns = spark.range(5)

# COMMAND ----------

# DBTITLE 1,Curious Case of max Function
# The following query won't work
# Can you explain why?

# Uncomment the following line to get the error go away
# from pyspark.sql.functions import max

# ns.select(max('id')).show()

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## 🧑‍💻 Exercise Time

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC 1. https://jaceklaskowski.github.io/spark-workshop/exercises/sql/structs-for-column-names-and-values.html
# MAGIC 1. https://jaceklaskowski.github.io/spark-workshop/exercises/sql/Finding-Ids-of-Rows-with-Word-in-Array-Column.html
# MAGIC 1. https://jaceklaskowski.github.io/spark-workshop/exercises/sql/Multiple-Aggregations.html
# MAGIC 1. https://jaceklaskowski.github.io/spark-workshop/exercises/spark-sql-exercise-Collect-values-per-group.html
# MAGIC 1. https://jaceklaskowski.github.io/spark-workshop/exercises/spark-sql-exercise-Finding-maximum-values-per-group-groupBy.html
# MAGIC 1. (tricky) https://jaceklaskowski.github.io/spark-workshop/exercises/spark-sql-exercise-Finding-maximum-value-agg.html
# MAGIC 1. (tricky) https://jaceklaskowski.github.io/spark-workshop/exercises/sql/Finding-Most-Populated-Cities-Per-Country.html
