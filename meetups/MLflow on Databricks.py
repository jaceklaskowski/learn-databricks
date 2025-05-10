# Databricks notebook source
# MAGIC %md
# MAGIC
# MAGIC https://learn.microsoft.com/en-us/azure/databricks/machine-learning/manage-model-lifecycle/

# COMMAND ----------

# MAGIC %pip install --upgrade "mlflow-skinny[databricks]"

# COMMAND ----------

# MAGIC %restart_python

# COMMAND ----------

import mlflow
mlflow.get_registry_uri()

# COMMAND ----------

from sklearn import datasets
from sklearn.ensemble import RandomForestClassifier

# Train a sklearn model on the iris dataset
X, y = datasets.load_iris(return_X_y=True, as_frame=True)
clf = RandomForestClassifier(max_depth=7)
clf.fit(X, y)

# Note that the UC model name follows the pattern
# <catalog_name>.<schema_name>.<model_name>, corresponding to
# the catalog, schema, and registered model name
# in Unity Catalog under which to create the version
# The registered model will be created if it doesn't already exist
autolog_run = mlflow.last_active_run()
print(autolog_run)

# COMMAND ----------

model_run = mlflow.active_run()

# COMMAND ----------

print(model_run.info)

# COMMAND ----------

model_uri = "runs:/{}/model".format(model_run.info.run_id)
mlflow.register_model(model_uri, "iris_model")

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC # Notes
# MAGIC
# MAGIC Recommended Training: [Use MLflow in Azure Databricks](https://learn.microsoft.com/en-us/training/modules/mlflow-azure-databricks/)
# MAGIC
# MAGIC > Prerequisites
# MAGIC >
# MAGIC > Before starting this module, you should be familiar with Azure Databricks and the **machine learning model training process**.
# MAGIC
# MAGIC This "machine learning model training process" is very important.

# COMMAND ----------

# MAGIC %md
# MAGIC # Run experiments with MLflow
# MAGIC
# MAGIC [Run experiments with MLflow](https://learn.microsoft.com/en-us/training/modules/mlflow-azure-databricks/3-run-experiments)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC **MLflow experiments** allow data scientists to track training runs in a collection called an **experiment**.
# MAGIC
# MAGIC **Experiment runs** are useful for the following:
# MAGIC
# MAGIC 1. Compare changes over time.
# MAGIC 1. Compare the relative performance of models with different hyperparameter values.

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC Follow up in [Running an experiment](https://learn.microsoft.com/en-us/training/modules/mlflow-azure-databricks/3-run-experiments)

# COMMAND ----------

# MAGIC %md
# MAGIC # MLflow

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC From "Introduction" in [Use MLflow in Azure Databricks](https://learn.microsoft.com/en-us/training/modules/mlflow-azure-databricks/1-introduction) training:
# MAGIC
# MAGIC 1. MLflow is an open source platform for end-to-end machine learning operations.
# MAGIC 1. Using MLflow, data scientists can track model training experiments; logging parameters, metrics, and other assets.
# MAGIC 1. Machine learning engineers can use MLflow to deploy and manage models, enabling applications to consume the models and use them to inference predictions for new data.

# COMMAND ----------

# MAGIC %md
# MAGIC ## Capabilities of MLflow
# MAGIC
# MAGIC There are four components to MLflow:
# MAGIC
# MAGIC 1. MLflow Tracking
# MAGIC 1. MLflow Projects
# MAGIC 1. MLflow Models
# MAGIC 1. MLflow Model Registry

# COMMAND ----------

# MAGIC %md
# MAGIC ## MLflow Tracking
# MAGIC
# MAGIC * **MLflow Tracking** allows data scientists to work with experiments in which they process and analyze data or train machine learning models.
# MAGIC * For each run in an experiment, a data scientist can log parameter values, versions of libraries used, model evaluation metrics, and generated output files; including images of data visualizations and model files.
# MAGIC * This ability to log important details about experiment runs makes it possible to audit and compare the results of prior model training executions.

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## MLflow Projects
# MAGIC
# MAGIC 1. An MLflow Project is a way of packaging up code for consistent deployment and reproducibility of results.
# MAGIC 1. MLflow supports several environments for projects, including the use of Conda and Docker to define consistent Python code execution environments.

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## MLflow Models
# MAGIC
# MAGIC 1. MLflow offers a standardized format for packaging models for distribution.
# MAGIC 1. This standardized model format allows MLflow to work with models generated from several popular libraries, including Scikit-Learn, PyTorch, MLlib, and others.
# MAGIC
# MAGIC Learn more in [MLflow Models](https://mlflow.org/docs/latest/model)

# COMMAND ----------

# MAGIC %md
# MAGIC ## MLflow Model Registry
# MAGIC
# MAGIC 1. The MLflow Model Registry allows data scientists to register trained models.
# MAGIC 1. MLflow Models and MLflow Projects use the MLflow Model Registry to enable machine learning engineers to deploy and serve models for client applications to consume.
