-- Databricks notebook source
-- CTAS = Create Table As Select
-- CTE = Common Table Expressions (WITH)
CREATE LIVE TABLE book_ranks
AS SELECT
  *,
  RANK() over (
    PARTITION BY genre
    ORDER BY
      quantity DESC
  ) as book_rank
FROM LIVE.books
