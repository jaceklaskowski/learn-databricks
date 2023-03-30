-- Databricks notebook source
CREATE OR REFRESH LIVE TABLE dlt_two
COMMENT "live table dlt_two"
AS
SELECT * FROM live.dlt_one

-- COMMAND ----------


