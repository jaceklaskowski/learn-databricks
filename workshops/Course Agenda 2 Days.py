# Databricks notebook source
# MAGIC %md # Databricks Workshop » Agenda
# MAGIC
# MAGIC This notebook is a sample agenda of a Databricks workshop that can be used as a guidance for further customization.
# MAGIC
# MAGIC This agenda has been used in a 2-day workshop format for a group of data engineers, architects, data analysts and testers (with some automation skills).
# MAGIC
# MAGIC Duration: 2 days (8 hours / day)
# MAGIC
# MAGIC Recommended number of participants: 8-12 people

# COMMAND ----------

# MAGIC %md ## Agenda

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC The idea is to go over all the different types of artifacts that can be built using "New" menu:
# MAGIC
# MAGIC 1. Notebook
# MAGIC 1. Repo
# MAGIC 1. Data
# MAGIC     * File upload
# MAGIC     * Add data
# MAGIC 1. Compute
# MAGIC     * Cluster
# MAGIC     * SQL Warehouse
# MAGIC 1. SQL
# MAGIC     * Query
# MAGIC     * Dashoboard
# MAGIC     * Lakeview Dashboard
# MAGIC     * Alert
# MAGIC 1. Data Engineering
# MAGIC     * Job
# MAGIC     * DLT Pipeline
# MAGIC 1. Machine Learning (not covered)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC 1. Overview of Databricks Workspace for Data Engineers
# MAGIC 1. Data Engineering with Spark SQL
# MAGIC 1. Managing Data in Delta Lake Tables
# MAGIC     * DLT Pipelines
# MAGIC     * `dbfs` magic command
# MAGIC 1. Databricks Workflows and Jobs
# MAGIC 1. Developing Data Pipelines using Delta Live Tables
# MAGIC     * Converting Spark exercises to Databricks tools' mindset
# MAGIC 1. Databricks SQL for Data Analytics
# MAGIC 1. Unity Catalog
# MAGIC 1. Setting up Development Environment
# MAGIC     * IntelliJ IDEA / PyCharm
# MAGIC     * Visual Studio Code
# MAGIC     * Databricks JDBC Driver
# MAGIC     * Databricks CLI
# MAGIC     * Databricks SQL Connector for Python
# MAGIC 1. (optional) Databricks CI/CD
# MAGIC     * REST APIs
# MAGIC     * Terraform / Databricks Terraform Provider

# COMMAND ----------

# MAGIC %md ## Preprequisites

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC It is assumed that the course participants have got the following skills:
# MAGIC
# MAGIC 1. Familiarity with Apache Spark and/or PySpark
# MAGIC 1. Familiarity with one of the following programming languages:
# MAGIC     * Python
# MAGIC     * Scala
# MAGIC     * SQL

# COMMAND ----------

# MAGIC %md ## Schedule

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC A class is split into 1-hour blocks with a 12-minute break each
# MAGIC
# MAGIC A day starts at 9am and ends at 4pm to let students have an extra 1 hour at the end of a day to work alone on exercises and have enough room for some cognitive work at its own pace and perhaps even ask questions
# MAGIC
# MAGIC Lunch breaks at 1pm for 1 hour

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC * 9:00 – 9:48 (12’ break)
# MAGIC * 10:00 – 10:48 (12’ break)
# MAGIC * 11:00 – 11:48 (12’ break)
# MAGIC * Lunch break (1h)
# MAGIC * 13:00 – 13:48 (12’ break)
# MAGIC * 14:00 – 14:48 (12’ break)
# MAGIC * 15:00 – 15:48 (12’ break)
# MAGIC * 16:00 – 17:00 a quiet working hour

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Databricks Workspace

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC * A Databricks Workspace with Unity Catalog enabled
# MAGIC * Myself as a workspace admin
# MAGIC * An extra (fake) non-admin user account for testing and demo
# MAGIC * DLT pipelines and workflows (jobs)
