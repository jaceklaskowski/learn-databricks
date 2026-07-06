# Databricks notebook source
# /// script
# [tool.databricks.environment]
# base_environment = "databricks_ml_v5"
# environment_version = "5"
# ///
# MAGIC %md
# MAGIC
# MAGIC # Databricks Tutorials with dbdemos Python Module
# MAGIC
# MAGIC [dbdemos](https://pypi.org/project/dbdemos/) is a Python library that installs complete Databricks demos in your Databricks workspaces. Dbdemos will load and start notebooks, DLT pipelines, clusters, Databricks SQL dashboards, ML models, etc.
# MAGIC
# MAGIC [GitHub](https://github.com/databricks-demos/dbdemos)

# COMMAND ----------

# MAGIC %md
# MAGIC ## Tutorials
# MAGIC
# MAGIC [Tutorials](https://www.databricks.com/resources/demos/tutorials) Install demos in your Databricks workspace to quickly access best practices for data ingestion, governance, security, data science and data warehousing.

# COMMAND ----------

# MAGIC %pip install -qU "dbdemos==0.6.36"
# MAGIC %restart_python

# COMMAND ----------

import dbdemos

# COMMAND ----------

dbdemos.help()

# COMMAND ----------

dbdemos.list_demos()

# COMMAND ----------

# MAGIC %md
# MAGIC ## AI Agent System and Evaluation with Databricks AI
# MAGIC
# MAGIC Deploy your AI Agent system on Databricks AI with foundation LLM, Langchain, PDF extraction and Vector Search & Mosaic AI Agent Evaluation

# COMMAND ----------

import dbdemos
dbdemos.install('ai-agent')

# COMMAND ----------

# MAGIC %md
# MAGIC ## Agentic Systems: Deploy and Evaluate RAG Apps with Databricks AI
# MAGIC
# MAGIC [Agentic Systems: Deploy and Evaluate RAG Apps with Databricks AI](https://www.databricks.com/resources/demos/tutorials/data-science/ai-agent)
# MAGIC
# MAGIC ⚠️ **NOTE**: It could be similar if not the same as the one above, but made publicly discoverable using the official Databricks Tutorials page.

# COMMAND ----------

# MAGIC %md
# MAGIC ## Feature Store and Online Inference
# MAGIC
# MAGIC [Feature Store and Online Inference](https://www.databricks.com/resources/demos/tutorials/data-science-and-ai/feature-store-and-online-inference)
# MAGIC
# MAGIC Leverage Databricks Feature Store with streaming and online store.

# COMMAND ----------

# MAGIC %skip
# MAGIC import dbdemos
# MAGIC dbdemos.install('feature-store', catalog='main', schema='dbdemos_fs_travel')

# COMMAND ----------

# MAGIC %md
# MAGIC ## MLOps — End-to-End Pipeline
# MAGIC
# MAGIC [MLOps — End-to-End Pipeline](https://www.databricks.com/resources/demos/tutorials/data-science-and-ai/mlops-end-to-end-pipeline)
# MAGIC
# MAGIC Automate your model deployment with MLFlow and UC, end to end!

# COMMAND ----------

# MAGIC %skip
# MAGIC import dbdemos
# MAGIC dbdemos.install('mlops-end2end')

# COMMAND ----------

# MAGIC %md
# MAGIC ## AI Functions: Query LLMs With SQL
# MAGIC
# MAGIC [AI Functions: Query LLMs With SQL](databricks.com/resources/demos/tutorials/data-warehouse/query-llm-with-dbsql)

# COMMAND ----------

# MAGIC %skip
# MAGIC import dbdemos
# MAGIC dbdemos.install('sql-ai-functions', catalog='main', schema='dbdemos_ai_query')

# COMMAND ----------

# MAGIC %md
# MAGIC ## LLM Chatbot With Retrieval Augmented Generation (RAG) and DBRX
# MAGIC
# MAGIC [LLM Chatbot With Retrieval Augmented Generation (RAG) and DBRX](https://notebooks.databricks.com/demos/llm-rag-chatbot/index.html)
# MAGIC
# MAGIC ⚠️ This content will be deprecated soon, yet the content in the **GenAI & Maturity curve** section in the notebook made me explore it more.
# MAGIC Finally, the connection between RAG and model fine-tuning or pre-training has clicked for me! 🥳

# COMMAND ----------

# MAGIC %skip
# MAGIC import dbdemos
# MAGIC dbdemos.install('llm-rag-chatbot', catalog='main', schema='rag_chatbot')
