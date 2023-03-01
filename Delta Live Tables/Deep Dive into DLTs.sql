-- Databricks notebook source
show tables in jaceklaskowski

-- COMMAND ----------

describe extended jaceklaskowski.meetup_two

-- COMMAND ----------

-- MAGIC %fs ls dbfs:/pipelines/48afcdc3-6357-4f17-a1b2-d70dd0ad7f44/system/events

-- COMMAND ----------

select * from delta.`dbfs:/pipelines/48afcdc3-6357-4f17-a1b2-d70dd0ad7f44/system/events`

-- COMMAND ----------

-- MAGIC %fs ls dbfs:/pipelines/48afcdc3-6357-4f17-a1b2-d70dd0ad7f44/tables

-- COMMAND ----------

select * from delta.`dbfs:/pipelines/48afcdc3-6357-4f17-a1b2-d70dd0ad7f44/tables/meetup_two/`

-- COMMAND ----------

select * from delta.`dbfs:/pipelines/48afcdc3-6357-4f17-a1b2-d70dd0ad7f44/tables/meetup_two/`
