# Databricks notebook source
# MAGIC %md
# MAGIC
# MAGIC # Query JSON-Encoded Semi-Structured Data
# MAGIC
# MAGIC [Query semi-structured data in Databricks](https://docs.databricks.com/en/optimizations/semi-structured.html)

# COMMAND ----------

# MAGIC %sql
# MAGIC
# MAGIC USE CATALOG hive_metastore;
# MAGIC
# MAGIC CREATE SCHEMA IF NOT EXISTS hive_metastore.jacek_laskowski;
# MAGIC USE hive_metastore.jacek_laskowski

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC Let's first create a single-line JSON dataset.
# MAGIC
# MAGIC Let's upload it to DBFS.
# MAGIC
# MAGIC Using Databricks CLI as follows?
# MAGIC
# MAGIC <br>
# MAGIC
# MAGIC ```shell
# MAGIC databricks fs mkdir dbfs:/jacek_laskowski/ndjsons
# MAGIC ```
# MAGIC
# MAGIC <br>
# MAGIC
# MAGIC ```shell
# MAGIC databricks fs cp ndjsons/*.ndjson dbfs:/jacek_laskowski/ndjsons
# MAGIC ```

# COMMAND ----------

# MAGIC %md
# MAGIC Not really! 🥳

# COMMAND ----------

# MAGIC %fs mkdirs dbfs:/jacek_laskowski/ndjsons

# COMMAND ----------

# Unfortunately, `%fs put` doesn't work with `overwrite` argument
dbutils.fs.put('/jacek_laskowski/ndjsons/simple.ndjson', '{"id": 0,"name": "Jacek"}', overwrite=True)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC And then load it using DataFrame API? 🤨

# COMMAND ----------

simple = spark.read.json('/jacek_laskowski/ndjsons/simple.ndjson')
display(simple)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC We'll get to it...real soon! 😉

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## 💡 Mapping File
# MAGIC
# MAGIC A dict of column names and the expressions to generate values for.

# COMMAND ----------

def exprs_for_mapping_rules(mapping_rules):
    from pyspark.sql.functions import expr
    exprs = [expr(gen_expr).alias(col_name) for (col_name, gen_expr) in mapping_rules]
    return exprs

# COMMAND ----------

# MAGIC %md ## Example 1

# COMMAND ----------

simple_mapping_rules = [
    ('id', 'id'),
    ('name', 'name'),
]

# COMMAND ----------

simple_exprs = exprs_for_mapping_rules(simple_mapping_rules)

# COMMAND ----------

simple.select(simple_exprs).display()

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ### highly nested data
# MAGIC
# MAGIC [highly nested data](https://docs.databricks.com/en/optimizations/semi-structured.html#create-a-table-with-highly-nested-data)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC What a nice little trick to create a table from an inlined JSON-encoded string! 🥰

# COMMAND ----------

# MAGIC %sql
# MAGIC
# MAGIC CREATE OR REPLACE TABLE highly_nested
# MAGIC AS SELECT
# MAGIC '{
# MAGIC    "store":{
# MAGIC       "fruit": [
# MAGIC         {"weight":8,"type":"apple"},
# MAGIC         {"weight":9,"type":"pear"}
# MAGIC       ],
# MAGIC       "basket":[
# MAGIC         [1,2,{"b":"y","a":"x"}],
# MAGIC         [3,4],
# MAGIC         [5,6]
# MAGIC       ],
# MAGIC       "book":[
# MAGIC         {
# MAGIC           "author":"Nigel Rees",
# MAGIC           "title":"Sayings of the Century",
# MAGIC           "category":"reference",
# MAGIC           "price":8.95
# MAGIC         },
# MAGIC         {
# MAGIC           "author":"Herman Melville",
# MAGIC           "title":"Moby Dick",
# MAGIC           "category":"fiction",
# MAGIC           "price":8.99,
# MAGIC           "isbn":"0-553-21311-3"
# MAGIC         },
# MAGIC         {
# MAGIC           "author":"J. R. R. Tolkien",
# MAGIC           "title":"The Lord of the Rings",
# MAGIC           "category":"fiction",
# MAGIC           "reader":[
# MAGIC             {"age":25,"name":"bob"},
# MAGIC             {"age":26,"name":"jack"}
# MAGIC           ],
# MAGIC           "price":22.99,
# MAGIC           "isbn":"0-395-19395-8"
# MAGIC         }
# MAGIC       ],
# MAGIC       "bicycle":{
# MAGIC         "price":19.95,
# MAGIC         "color":"red"
# MAGIC       }
# MAGIC     },
# MAGIC     "owner":"amy",
# MAGIC     "zip code":"94025",
# MAGIC     "fb:testid":"1234"
# MAGIC  }' as raw
# MAGIC

# COMMAND ----------

# MAGIC %sql
# MAGIC
# MAGIC DESCRIBE highly_nested

# COMMAND ----------

from pyspark.sql.functions import udf

@udf('int')
def random_value() -> int:
    return 5

# required if using a custom catalog and schema
# e.g. hive_metastore.jacek_laskowski
spark.udf.register('some_random_value_fn', random_value)

# COMMAND ----------

highly_nested_mapping_rules = [
    # (col_name, gen_expr)
    ('id', 'raw:id'),
    ('owner', 'raw:owner'),
    ('fruit[0].weight', 'raw:store.fruit[0].weight'),
    ('some_random_value', 'some_random_value_fn()')
]

# COMMAND ----------

highly_nested_exprs = exprs_for_mapping_rules(highly_nested_mapping_rules)
print(highly_nested_exprs)
spark.table('highly_nested').select(highly_nested_exprs).display()

# COMMAND ----------

sql(f"""SELECT raw:id intentionally_null, raw:owner, some_random_value_fn() FROM highly_nested""").display()

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ![That's all folks!](https://i1.ytimg.com/vi/0FHEeG_uq5Y/maxresdefault.jpg)
