# Databricks notebook source
# MAGIC %md # 04 Advanced PySpark SQL

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Agenda
# MAGIC
# MAGIC 1. Joins
# MAGIC 1. Windowed Aggregation
# MAGIC 1. Pivoting
# MAGIC 1. Multi-Dimensional Aggregation
# MAGIC 1. Monitoring
# MAGIC     1. Web UI
# MAGIC     1. SparkListeners
# MAGIC 1. SparkSessionExtensions
# MAGIC 1. [User-Defined Aggregate Functions](https://spark.apache.org/docs/latest/sql-ref-functions-udf-aggregate.html)
# MAGIC 1. [Table-Valued Functions](https://spark.apache.org/docs/latest/sql-ref-syntax-qry-select-tvf.html)
# MAGIC     1. [Python User-defined Table Functions (UDTFs)](https://spark.apache.org/docs/3.5.2/api/python/user_guide/sql/python_udtf.html)
# MAGIC 1. Connectors / Data Sources
# MAGIC 1. Performance Tuning
# MAGIC 1. [The Internals of Structured Query Execution](https://jaceklaskowski.github.io/spark-workshop/slides/spark-sql-internals-of-structured-query-execution.html#/home)
# MAGIC 1. [Caching and Persistence](https://jaceklaskowski.github.io/spark-workshop/slides/spark-sql-dataset-caching-and-persistence.html#/home)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Data(Frame) is Query and Query is Data(Frame)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC PySpark SQL:
# MAGIC
# MAGIC ```py
# MAGIC df = spark.range(5)
# MAGIC ```
# MAGIC
# MAGIC Scala API for DataFrame (Spark SQL):
# MAGIC
# MAGIC ```scala
# MAGIC val query = spark.range(5)
# MAGIC ```
# MAGIC
# MAGIC ```py
# MAGIC nums = spark.range(5)
# MAGIC ns = spark.range(5)
# MAGIC ids = spark.range(5)
# MAGIC ```
# MAGIC
# MAGIC ----
# MAGIC
# MAGIC ```py
# MAGIC people_df = spark.table('my_catalog.my_schema.people`)
# MAGIC ```
# MAGIC
# MAGIC people / names (I use words to describe the main concept in tables)
# MAGIC
# MAGIC id | name | city
# MAGIC -|-|-
# MAGIC 0 | Jacek | Warsaw
# MAGIC 1 | Bhaumik | NY
# MAGIC 2 | Nate | Seattle
# MAGIC
# MAGIC ---
# MAGIC
# MAGIC `people_df.display()`

# COMMAND ----------

def people():
    return [
        (0, 'Jacek', 'Warsaw'),
        (1, 'Bhaumik', 'NY'),
    ]

# COMMAND ----------

# This is a description of a computation
people

# This is execution / application of a computation
people()

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Joins
# MAGIC
# MAGIC 1. [Joins](https://jaceklaskowski.github.io/spark-workshop/slides/spark-sql-joins.html#/home)
# MAGIC 1. [Join Hints](https://spark.apache.org/docs/3.5.2/sql-ref-syntax-qry-select-hints.html#join-hints)
# MAGIC 1. [Join Strategy Hints for SQL Queries](https://spark.apache.org/docs/3.5.2/sql-performance-tuning.html#join-strategy-hints-for-sql-queries)
# MAGIC 1. [Exercise: Finding Most Populated Cities Per Country](https://jaceklaskowski.github.io/spark-workshop/exercises/sql/Finding-Most-Populated-Cities-Per-Country.html)
# MAGIC 1. [Exercise: Finding Ids of Rows with Word in Array Column](https://jaceklaskowski.github.io/spark-workshop/exercises/sql/Finding-Ids-of-Rows-with-Word-in-Array-Column.html)

# COMMAND ----------

from pyspark.sql import functions as F
ids = spark.range(5).withColumn('left_id', F.col('id'))
other_ids = spark.range(3, 6).withColumn('right_id', F.col('id'))

q_single_id = ids.join(other_ids, 'id')
display(q_single_id)

# q_multiple_ids = ids.join(other_ids, 'left_id = right_id')
join_cond = F.expr('(left_id = right_id AND right_id = left_id) AND (1 = 1)')
q_multiple_ids = ids.join(other_ids, join_cond)
display(q_multiple_ids)

# Equivalent to the following query:

join_cond = F.expr('left_id = right_id AND right_id = left_id AND 1 = 1')

q_multiple_ids = (
    ids
    .join(other_ids)
    .where('left_id = right_id')
    .where('right_id = left_id')
    .where('1 = 1')
)

display(q_multiple_ids)

# COMMAND ----------

q_multiple_ids = (
    ids.join(other_ids, 'id', 'left_outer')
)
display(q_multiple_ids)

# COMMAND ----------

q_multiple_ids = (
    ids.join(other_ids, 'id', 'l_e______ft_outer')
)
display(q_multiple_ids)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ### Exercise
# MAGIC
# MAGIC https://jaceklaskowski.github.io/spark-workshop/exercises/sql/Finding-Most-Populated-Cities-Per-Country.html

# COMMAND ----------

data = [
    ('Warsaw','Poland','1 764 615'),
    ('Cracow','Poland','769 498'),
    ('Paris','France','2 206 488'),
    ('Villeneuve-Loubet','France','15 020'),
    ('Pittsburgh, PA','United States','302 407'),
    ('Chicago, IL','United States','2 716 000'),
    ('Milwaukee, WI','United States','595 351'),
    ('Vilnius','Lithuania','580 020'),
    ('Stockholm','Sweden','972 647'),
    ('Goteborg','Sweden','580 020'),
]
headers = ['name','country','population']
cities = spark.createDataFrame(data, headers)
display(cities)

# COMMAND ----------

from pyspark.sql import functions as F

# The following query will break due to population being of type string
# "population" is not a numeric column. Aggregation function can only be applied on a numeric column.
# cities.groupBy('country').max('population').display()

print(type(cities.groupBy('country')))

# Python is OK
print(max(['a', 'b']))

# The following query is INCORRECT
# but Spark SQL is OK
cities.groupBy('country').agg(F.max('population')).display()

# COMMAND ----------

cities = cities.withColumn('population', F.regexp_replace('population', ' ', '').cast('int'))
cities.groupBy('country').agg(F.max('population')).display()

# join is required to include city

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Windowed Aggregation
# MAGIC
# MAGIC 1. [Windowed Aggregation](https://jaceklaskowski.github.io/spark-workshop/slides/spark-sql-windowed-aggregation.html#/home)
# MAGIC 1. [Window Functions](https://spark.apache.org/docs/3.5.2/sql-ref-syntax-qry-select-window.html#content)
# MAGIC 1. [Exercise: Finding 1st and 2nd Bestsellers Per Genre](https://jaceklaskowski.github.io/spark-workshop/exercises/sql/Finding-1st-and-2nd-Bestsellers-Per-Genre.html)
# MAGIC 1. [Exercise: Calculating Gap Between Current And Highest Salaries Per Department](https://jaceklaskowski.github.io/spark-workshop/exercises/sql/Calculating-Gap-Between-Current-And-Highest-Salaries-Per-Department.html)
# MAGIC 1. [Exercise: Calculating Running Total / Cumulative Sum](https://jaceklaskowski.github.io/spark-workshop/exercises/spark-sql-exercise-Calculating-Running-Total-Cumulative-Sum.html)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ### Exercise

# COMMAND ----------

# DBTITLE 1,Basic Aggregation
# 5 rows here
data = spark.range(5)
data.display()

grouping_expr = data['id'] % 2

# How many rows do we get? 2
data.groupBy(grouping_expr.alias('gid')).count().display()

grouping_expr = data['id'] % 5
data.groupBy(grouping_expr).count().display()

# COMMAND ----------

# DBTITLE 1,Window Aggregation
from pyspark.sql import Window

# equivalent to groupBy(grouping_expr) = n (based on modulo n)
grouping_expr = data['id'] % 2
by_modulo_2 = Window.partitionBy(grouping_expr)

# data.groupBy(grouping_expr).count().display()
data.withColumn('count', F.count('*').over(by_modulo_2)).display()

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ### Exercise: Finding 1st and 2nd Bestsellers Per Genre
# MAGIC
# MAGIC https://jaceklaskowski.github.io/spark-workshop/exercises/sql/Finding-1st-and-2nd-Bestsellers-Per-Genre.html

# COMMAND ----------

headers = ['id','title','genre','quantity']

data = [
    (1,'Hunter Fields','romance',15),
    (2,'Leonard Lewis','thriller',81),
    (3,'Jason Dawson','thriller',90),
    (4,'Andre Grant','thriller',25),
    (5,'Earl Walton','romance',40),
    (6,'Alan Hanson','romance',24),
    (11,'NEW Alan Hanson','romance',24),
    (7,'Clyde Matthews','thriller',31),
    (8,'Josephine Leonard','thriller',1),
    (9,'Owen Boone','sci-fi',27),
    (10,'Max McBride','romance',75),
]

books = spark.createDataFrame(data, headers)

# books.display()

# https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/window.html
from pyspark.sql import Window
from pyspark.sql.functions import row_number

by_quantity_desc = Window.partitionBy('genre').orderBy(F.col('quantity').desc())

solution = (
    books
    .withColumn('rank', F.rank().over(by_quantity_desc))
    # .where(F.col('rank') <= 2)
    .select('genre', 'rank', 'title', 'quantity')
)

solution.display()

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Pivoting
# MAGIC
# MAGIC 1. [GroupedData.pivot (PySpark)](https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/api/pyspark.sql.GroupedData.pivot.html)
# MAGIC 1. [PIVOT Clause (SQL)](https://spark.apache.org/docs/latest/sql-ref-syntax-qry-select-pivot.html)
# MAGIC 1. [Exercise: Flattening Array Columns (From Datasets of Arrays to Datasets of Array Elements)](https://jaceklaskowski.github.io/spark-workshop/exercises/spark-sql-exercise-Flattening-Array-Columns-From-Datasets-of-Arrays-to-Datasets-of-Array-Elements.html)
# MAGIC 1. [Exercise: Using pivot for Cost Average and Collecting Values](https://jaceklaskowski.github.io/spark-workshop/exercises/sql/Using-pivot-for-Cost-Average-and-Collecting-Values.html)

# COMMAND ----------

# genres with a given rank
solution.groupBy('genre').pivot('rank').agg(F.count('*')).display()

# books.groupBy('genre') => rows
# .pivot('rank')         => columns
# .agg(F.count('*'))     => values

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ### Exercise: Using pivot for Cost Average and Collecting Values 
# MAGIC
# MAGIC https://jaceklaskowski.github.io/spark-workshop/exercises/sql/Using-pivot-for-Cost-Average-and-Collecting-Values.html

# COMMAND ----------

data = [
  (0, "A", 223, "201603", "PORT"),
  (0, "A", 22, "201602", "PORT"),
  (0, "A", 422, "201601", "DOCK"),
  (1, "B", 3213, "201602", "DOCK"),
  (1, "B", 3213, "201601", "PORT"),
  (2, "C", 2321, "201601", "DOCK"),
]

headers = ["id","type", "cost", "date", "ship"]

ships = spark.createDataFrame(data, headers)
ships.display()

# COMMAND ----------

# collects all the values in a column
# pivot('date')
# groupBy(id. type)

solution = (
    ships
    .groupBy('id', 'type')
    .pivot('date')
    .agg(F.collect_list('ship'))
)

solution.display()

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Multi-Dimensional Aggregation
# MAGIC
# MAGIC 1. [Multi-Dimensional Aggregation](https://jaceklaskowski.github.io/spark-workshop/slides/spark-sql-multi-dimensional-aggregation.html#/home)
# MAGIC 1. [Window Functions](https://books.japila.pl/spark-sql-internals/window-functions/)
# MAGIC 1. [Demo: Mult-Dimensional Aggregations](https://books.japila.pl/spark-sql-internals/demo/demo-multi-dimensional-aggregations/)

# COMMAND ----------

# DBTITLE 1,rollup
data = [
    ("t1", 2015, 100),
    ("t1", 2016, 50),
    ("t2", 2016, 40),
]

headers = ["name", "year", "amount"]

inventory = spark.createDataFrame(data, headers)
inventory.display()

# rollup(x, y) = groupBy(x, y) UNION groupBy(x) UNION groupBy()
#                3 + 2 + 1 = 6
inventory.rollup("name", "year").sum("amount").display()

# Almost like the following query
df1 = inventory.groupBy("name", "year").sum("amount") # 3 cols here
df2 = inventory.groupBy("name").sum("amount") # 2 cols here
df3 = inventory.groupBy().sum("amount") # 1 cols here
# solution = df1.unionAll(df2).unionAll(df3)
# solution.display()

# COMMAND ----------

# DBTITLE 1,cube
data = [
    ("t1", 2015, 100),
    ("t1", 2016, 50),
    ("t2", 2016, 40),
]

headers = ["name", "year", "amount"]

inventory = spark.createDataFrame(data, headers)
# inventory.display()

# cube(x, y) = groupBy(x, y) UNION groupBy(x) UNION groupBy()
#              3 + 2 + 1 = 6
#              UNION groupBy(y)
#              2
# NOTE: groupBy(y, x) is already computed by groupBy(x, y)
#              6 + 2 = 8 output rows
inventory.cube("name", "year").sum("amount").display()

# COMMAND ----------

inventory.groupby('name', 'year').sum('amount').display()

# COMMAND ----------

inventory.groupby('year', 'name').sum('amount').display()

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Performance Tuning
# MAGIC
# MAGIC 1. [Performance Tuning](https://spark.apache.org/docs/latest/sql-performance-tuning.html)
