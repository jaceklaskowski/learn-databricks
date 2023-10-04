# Databricks notebook source
import dlt

@dlt.table
def five_records():
    return spark.range(5)

