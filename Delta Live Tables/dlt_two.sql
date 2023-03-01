-- Databricks notebook source
CREATE OR REFRESH LIVE TABLE dlt_two
COMMENT "live table demo 02"
AS
SELECT * FROM live.dlt_one

-- COMMAND ----------


