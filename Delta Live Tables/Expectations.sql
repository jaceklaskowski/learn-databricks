-- Databricks notebook source
-- MAGIC %md # Delta Live Tables Expectations

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ## Introduction
-- MAGIC 
-- MAGIC [Manage data quality with Delta Live Tables](https://docs.databricks.com/delta-live-tables/expectations.html):
-- MAGIC 
-- MAGIC 1. **Expectations** define data quality constraints (_requirements_, _assertions_)
-- MAGIC 1. Optional
-- MAGIC 1. Data quality checks on each record passing through a query (before they land in a delta table)
-- MAGIC     ```
-- MAGIC     expectation: record => Boolean
-- MAGIC     ```
-- MAGIC 1. Provide insights into data quality for each pipeline update
-- MAGIC 1. Applied to queries using Python decorators or SQL `CONSTRAINT` clauses

-- COMMAND ----------

-- MAGIC %md ## CREATE OR REFRESH Statement
-- MAGIC 
-- MAGIC [Delta Live Tables SQL language reference](https://docs.databricks.com/delta-live-tables/sql-ref.html)
-- MAGIC 
-- MAGIC ```sql
-- MAGIC CREATE OR REFRESH [TEMPORARY] { STREAMING TABLE | LIVE TABLE } table_name
-- MAGIC   [(
-- MAGIC     [
-- MAGIC     col_name1 col_type1 [ GENERATED ALWAYS AS generation_expression1 ] [ COMMENT col_comment1 ],
-- MAGIC     col_name2 col_type2 [ GENERATED ALWAYS AS generation_expression2 ] [ COMMENT col_comment2 ],
-- MAGIC     ...
-- MAGIC     ]
-- MAGIC     [
-- MAGIC     CONSTRAINT expectation_name_1 EXPECT (expectation_expr1) [ON VIOLATION { FAIL UPDATE | DROP ROW }],
-- MAGIC     CONSTRAINT expectation_name_2 EXPECT (expectation_expr2) [ON VIOLATION { FAIL UPDATE | DROP ROW }],
-- MAGIC     ...
-- MAGIC     ]
-- MAGIC   )]
-- MAGIC   [USING DELTA]
-- MAGIC   [PARTITIONED BY (col_name1, col_name2, ... )]
-- MAGIC   [LOCATION path]
-- MAGIC   [COMMENT table_comment]
-- MAGIC   [TBLPROPERTIES (key1 [ = ] val1, key2 [ = ] val2, ... )]
-- MAGIC   AS select_statement
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md ## CONSTRAINT Clause
-- MAGIC 
-- MAGIC ```sql
-- MAGIC CONSTRAINT expectation_name EXPECT (expectation_expr) [ON VIOLATION { FAIL UPDATE | DROP ROW }]
-- MAGIC ```
-- MAGIC 
-- MAGIC An expectation (`CONSTRAINT`) consists of three properties:
-- MAGIC 
-- MAGIC Property | SQL |Meaning
-- MAGIC ---------|-----|-------
-- MAGIC Identifier | `expectation_name` | a unique identifier and allows you to track metrics for the constraint
-- MAGIC Condition | `expectation_expr` | A boolean expression
-- MAGIC Action | `ON VIOLATION` | (optional) What to do when a record fails the expectation (the condition is `false`)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ```sql
-- MAGIC CONSTRAINT expectation_name               -- Name / Identifier
-- MAGIC EXPECT (expectation_expr)                 -- Data Quality Assertion
-- MAGIC [ON VIOLATION { DROP ROW | FAIL UPDATE }] -- Action
-- MAGIC ```
-- MAGIC 
-- MAGIC [SQL properties](https://docs.databricks.com/delta-live-tables/sql-ref.html#sql-properties-1)
-- MAGIC 
-- MAGIC Action | Result
-- MAGIC -------|-------
-- MAGIC No `ON VIOLATION` (_warn_) | **(default)** Invalid records are written to the target table; failure is reported as a metric for the dataset. (_accept violation_)
-- MAGIC  `ON VIOLATION DROP ROW` | Invalid records are dropped (not written to the target table) and a pipeline continues processing; failure is reported as a metrics for the dataset
-- MAGIC  `ON VIOLATION FAIL UPDATE` | An invalid record immediately stops pipeline execution; Manual intervention is required before re-processing

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC [What are Delta Live Tables expectations?](https://docs.databricks.com/delta-live-tables/expectations.html#what-are-delta-live-tables-expectations)
