# Databricks notebook source
# MAGIC %md
# MAGIC # Model Serving

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Mosaic AI Model Serving
# MAGIC
# MAGIC [Model serving with Databricks](https://docs.databricks.com/en/machine-learning/model-serving/index.html):
# MAGIC
# MAGIC * Mosaic AI Model Serving provides a unified interface to deploy, govern, and query AI models
# MAGIC * Each model served is available using REST API
# MAGIC * Offers a unified REST API and MLflow Deployment API for CRUD and querying tasks
# MAGIC * Provides a highly available and low-latency service for deploying models
# MAGIC * A single UI to manage all your models and their respective serving endpoints
# MAGIC * Ability to extend pre-trained models (e.g., Llama 3.1) with proprietary data to improve quality
# MAGIC   * Specialize them for specific business contexts and skills to build higher quality models
# MAGIC * Automatically scales up or down to meet demand changes
# MAGIC   * Uses [serverless compute](https://docs.databricks.com/en/getting-started/overview.html#serverless)
# MAGIC   * [Pricing](https://www.databricks.com/product/pricing/model-serving)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC Model serving supports the following language models:
# MAGIC
# MAGIC 1. [Custom models](https://docs.databricks.com/en/machine-learning/model-serving/custom-models.html)
# MAGIC     * Python models packaged in the MLflow format
# MAGIC     * Registered either in Unity Catalog or in the workspace model registry
# MAGIC     * Examples: scikit-learn, XGBoost, PyTorch, Hugging Face transformer models, [agent serving](https://docs.databricks.com/en/generative-ai/deploy-agent.html)
# MAGIC 1. State-of-the-art open models using [Foundation Model APIs]($./Foundation Models)
# MAGIC     * [Llama]($./Llama)
# MAGIC     * Curated foundation model architectures that support optimized inference
# MAGIC     * Base models (e.g., Llama-2-70B-chat, BGE-Large, and Mistral-7B) are available for immediate use with pay-per-token pricing
# MAGIC     * Workloads that require performance guarantees and fine-tuned model variants can be deployed with provisioned throughput
# MAGIC 1. [External models](https://docs.databricks.com/en/generative-ai/external-models/index.html)
# MAGIC     * Generative AI models hosted outside of Databricks
# MAGIC     * Endpoints that serve external models can be centrally governed and customers can establish rate limits and access control for them
# MAGIC     * Examples: OpenAI’s GPT-4, Anthropic’s Claude

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## SQL Access
# MAGIC
# MAGIC Models are available from SQL using [AI functions](https://docs.databricks.com/en/large-language-models/ai-functions.html) for easy integration into analytics workflows.

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Tutorials
# MAGIC
# MAGIC 1. [Tutorial: Deploy and query a custom model](https://docs.databricks.com/en/machine-learning/model-serving/model-serving-intro.html) on how to serve custom models on Databricks
# MAGIC 1. [Get started querying LLMs on Databricks](https://docs.databricks.com/en/large-language-models/llm-serving-intro.html) on how to query a foundation model on Databricks
