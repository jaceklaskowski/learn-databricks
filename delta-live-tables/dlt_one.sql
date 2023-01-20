-- Databricks notebook source
--- Almost like CTAS
CREATE OR REFRESH LIVE TABLE dlt_one
COMMENT "live table demo 01" 
AS
  SELECT
    INT((rand() * ID) * 100) AS id
  FROM VALUES
    (1),
    (2),
    (3) t(id)
