-- Databricks notebook source
--- Almost like CTAS
CREATE OR REFRESH LIVE TABLE dlt_one
(
  id INTEGER COMMENT 'Identifier',
  auto_generated BIGINT GENERATED ALWAYS AS IDENTITY (START WITH 0 INCREMENT BY 1) COMMENT 'Auto-generated using GENERATED ALWAYS AS IDENTITY'
)
COMMENT "live table dlt_one with ${jacek.pipeline.message}" 
AS
  SELECT
    INT((rand() * ID) * 100) AS id
  FROM VALUES
    (1),
    (2),
    (3) t(id)
