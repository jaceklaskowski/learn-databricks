-- Databricks notebook source
-- MAGIC %md
-- MAGIC
-- MAGIC # Distributed Learning on Apache Spark with LightGBM
-- MAGIC
-- MAGIC Possible other titles (just for fun and learning the new vocabulary):
-- MAGIC
-- MAGIC 1. **Distributed Training on Apache Spark with LightGBM**
-- MAGIC     * _Distributed Training_ is used in the [official documentation of Databricks](https://docs.databricks.com/machine-learning/train-model/distributed-training/index.html)
-- MAGIC     * Focus on Apache Spark as the distributed platform for ML frameworks (like LightGBM)
-- MAGIC     * Focus on _model training_ (over _machine learning_ that trains models)
-- MAGIC 1. **Distributed Learning in LightGBM on Apache Spark**
-- MAGIC     * _Distributed Learning_ is used in the [official documentation of LightGBM](https://lightgbm.readthedocs.io/en/latest/Parallel-Learning-Guide.html) (formerly _Parallel Learning_)
-- MAGIC     * Less focus on Apache Spark since it is one of the many distributed platforms to train models on (e.g. OpenMPI)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Fun Facts
-- MAGIC
-- MAGIC 1. [The same team that maintains SynapseML was also working on the major release of Microsoft Fabric, announced today at Microsoft //Build](https://github.com/microsoft/SynapseML/issues/1956#issuecomment-1560294005)
-- MAGIC     * flushing out some SynapseML issues for our major 1.0 release
-- MAGIC     * SynapseML will be a part of Fabric, so we are definitely not abandoning this project

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC # LightGBM
-- MAGIC
-- MAGIC [LightGBM](https://github.com/Microsoft/LightGBM):
-- MAGIC
-- MAGIC * An open-source, distributed, high-performance gradient boosting (GBDT, GBRT, GBM, or MART) framework that uses tree-based learning algorithms
-- MAGIC * Light Gradient Boosting Machine
-- MAGIC * Specializes in creating high-quality and GPU-enabled decision tree models for ranking, classification, and many other machine learning tasks
-- MAGIC     * GPU-enabled
-- MAGIC     * decision tree algorithms
-- MAGIC     * ranking
-- MAGIC     * classification
-- MAGIC * Support for parallel, distributed, and GPU learning
-- MAGIC     * Distributed and GPU learning can speed up model training
-- MAGIC * [3 distributed learning algorithms](https://lightgbm.readthedocs.io/en/latest/Parallel-Learning-Guide.html#choose-appropriate-parallel-algorithm)
-- MAGIC     * Data parallel (`tree_learner=data`)
-- MAGIC     * Feature parallel (`tree_learner=feature`)
-- MAGIC     * Voting parallel (`tree_learner=voting`)
-- MAGIC * Distributed learning experiments show that LightGBM can achieve a linear speed-up by using multiple machines for training in specific settings
-- MAGIC
-- MAGIC Support for distributed and GPU learning fits Apache Spark nicely (_pun intended_) ❤️
-- MAGIC
-- MAGIC ### Python Binding
-- MAGIC
-- MAGIC [LightGBM/python-package](https://github.com/microsoft/LightGBM/tree/master/python-package):
-- MAGIC * `pip install lightgbm` or `conda install -c conda-forge lightgbm` (not maintained by LightGBM maintainers)
-- MAGIC * Supports both GPU and CPU versions out of the box
-- MAGIC * available only for Windows and Linux
-- MAGIC     * No macOS?!
-- MAGIC * To use GPU version, install OpenCL Runtime libraries
-- MAGIC     * For NVIDIA and AMD GPUs they are included in the ordinary drivers for your graphics card, so no action is required
-- MAGIC     * If you would like your AMD or Intel CPU to act like a GPU (for testing and debugging), install AMD APP SDK on Windows and PoCL on Linux

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC # SynapseML
-- MAGIC
-- MAGIC [SynapseML](https://microsoft.github.io/SynapseML/):
-- MAGIC * Simple and Distributed Machine Learning
-- MAGIC * Formely known as **MMLSpark**
-- MAGIC * Among the provided machine learning algorithms is...yup, you have guessed it right...[LightGBM](https://microsoft.github.io/SynapseML/docs/features/lightgbm/about/)
-- MAGIC * Scale ML workloads to hundreds of machines on your **Apache Spark** clusters
-- MAGIC * LightGBM models can be used in existing Spark MLlib Pipelines, and used for batch, streaming, and serving workloads
-- MAGIC
-- MAGIC From [Distributed Learning Guide](https://lightgbm.readthedocs.io/en/latest/Parallel-Learning-Guide.html) (a LightGBM perspective):
-- MAGIC
-- MAGIC * Apache Spark users can use [SynapseML](https://github.com/microsoft/SynapseML) for machine learning workflows with LightGBM
-- MAGIC * SynapseML = a bridge between LightGBM and Apache Spark
-- MAGIC * SynapseML is not maintained by LightGBM's maintainers
-- MAGIC * SynapseML requires Scala 2.12, Spark 3.2+, and Python 3.8+

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## LightGBM in SynapseML
-- MAGIC
-- MAGIC Spark MLlib Estimators to use LightGBM (for distributed and GPU training):
-- MAGIC
-- MAGIC * `LightGBMClassifier` for building **classification models**
-- MAGIC     * Predicting whether a company will bankrupt or not (a binary classification)
-- MAGIC * `LightGBMRegressor` for building **regression models**
-- MAGIC     * Predicting future house prices
-- MAGIC * `LightGBMRanker` for building **ranking models**
-- MAGIC     * Predicting website searching result relevance
-- MAGIC
-- MAGIC Learn more in [LightGBM - Overview](https://microsoft.github.io/SynapseML/docs/features/lightgbm/LightGBM%20-%20Overview/).

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC # Distributed Learning in LightGBM
-- MAGIC
-- MAGIC [Distributed Learning Guide](https://lightgbm.readthedocs.io/en/latest/Parallel-Learning-Guide.html):
-- MAGIC
-- MAGIC * Introduces a new term **Distributed LightGBM** (training)
-- MAGIC * Distributed learning allows the use of multiple machines to produce a single model
-- MAGIC * You can run distributed LightGBM training in various programming languages and frameworks
-- MAGIC     * Apache Spark (using [SynapseML](https://microsoft.github.io/SynapseML/))
-- MAGIC     * Dask (maintained by LightGBM’s maintainers 🔥)
-- MAGIC     * Kubeflow
-- MAGIC     * LightGBM CLI (socket and MPI)
-- MAGIC     * Ray
-- MAGIC     * [Mars](https://mars-project.readthedocs.io/en/latest/) (never heard of this project before 🤔)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Internals
-- MAGIC
-- MAGIC [Optimization in Distributed Learning](https://lightgbm.readthedocs.io/en/latest/Features.html#optimization-in-distributed-learning) explains the internals of the three supported parallel algorithms in LightGBM
-- MAGIC * `tree_learner` configuration option

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC # Code Walkthrough (SynapseML)
-- MAGIC
-- MAGIC Let's have a quick look at the source code of `LightGBMBase`...🔍
-- MAGIC
-- MAGIC * `com.microsoft.azure.synapse.ml.lightgbm` package
-- MAGIC * The base Spark MLlib `Estimator` (to _fit models to data_)
-- MAGIC * The parent of the following LightGBM estimators:
-- MAGIC     * `LightGBMClassifier`
-- MAGIC     * `LightGBMRanker`
-- MAGIC     * `LightGBMRegressor`
-- MAGIC * Trains (_fits_) a LightGBM model
-- MAGIC * `LightGBMUtils.initializeNativeLibrary`
-- MAGIC * Can be single- or multi-batch
-- MAGIC     * splits data into separate batches during training
-- MAGIC     * `numBatches` parameter
-- MAGIC * Regardless of number of batches, `LightGBMBase.trainOneDataBatch` is called
-- MAGIC     ```scala
-- MAGIC     def trainOneDataBatch(
-- MAGIC         dataset: Dataset[_],
-- MAGIC         batchIndex: Int,
-- MAGIC         batchCount: Int): TrainedModel
-- MAGIC     ```
-- MAGIC * From `LightGBMBase.trainOneDataBatch` to `LightGBMBase.executeTraining`
-- MAGIC     * `NetworkManager` is created with `getUseBarrierExecutionMode` 🔥
-- MAGIC     * `useBarrierExecutionMode` - Barrier execution mode which uses a barrier stage, disabled (`false`) by default
-- MAGIC * Show how `useBarrierExecutionMode` argument is used in `NetworkManager`
-- MAGIC * Show the scaladoc of `LightGBMBase.prepareDataframe` (very informatory)
-- MAGIC
-- MAGIC ---
-- MAGIC
-- MAGIC The gist of Barrier Execution in SynapseML LightGBM is `LightGBMBase.executePartitionTasks` with the following line:
-- MAGIC
-- MAGIC ```scala
-- MAGIC dataframe.rdd.barrier().mapPartitions(mapPartitionsFunc).collect()
-- MAGIC ```
-- MAGIC     

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC # XGBoost and LightGBM
-- MAGIC
-- MAGIC [XGBoost](https://xgboost.readthedocs.io/en/stable/) is an optimized **distributed gradient boosting library**
-- MAGIC * Machine learning algorithms under the [Gradient Boosting](https://en.wikipedia.org/wiki/Gradient_boosting) framework
-- MAGIC * Provides a parallel tree boosting (also known as GBDT, GBM) that solve many data science problems in a fast and accurate way
-- MAGIC * Runs on major distributed environment (Hadoop, SGE, MPI) and can solve problems beyond billions of examples
-- MAGIC
-- MAGIC Thus, at a high-enough level XGBoost looks like LightGBM, does it?! But...

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Apache Spark Support
-- MAGIC
-- MAGIC XGBoost comes with its own [JVM Package](https://xgboost.readthedocs.io/en/latest/jvm/index.html) and Apache Spark is supported using [XGBoost4J-Spark](https://xgboost.readthedocs.io/en/latest/jvm/xgboost4j_spark_tutorial.html) (with and without GPU support).
-- MAGIC
-- MAGIC On the other hand, LightGBM does not support Apache Spark out of the box (only through SynapseML).

-- COMMAND ----------

-- MAGIC %md # Possible Continuations
-- MAGIC
-- MAGIC ...and ways to learn even more 🔥

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Talks and Demos
-- MAGIC
-- MAGIC 1. A talk about [Gradient boosting](https://en.wikipedia.org/wiki/Gradient_boosting)
-- MAGIC 1. Regression and classification (tasks) using Apache Spark and SynapseML (incl. Databricks)
-- MAGIC 1. XGBoost vs LightGBM

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Open Source Contributor
-- MAGIC
-- MAGIC If you've ever wanted to become an open source contributor, this is your chance 🫵
-- MAGIC
-- MAGIC Contribute to [SynapseML](https://github.com/microsoft/SynapseML) (for Apache Spark devs)
-- MAGIC * Start with the docs (due to [Documentation is very very thin](https://github.com/microsoft/SynapseML/issues/1956#issuecomment-1557879940))
-- MAGIC * Search the [Issues](https://github.com/microsoft/SynapseML/issues) to work on (e.g. with [good first issue](https://github.com/microsoft/SynapseML/labels/good%20first%20issue), [area/documentation](https://github.com/microsoft/SynapseML/labels/area%2Fdocumentation) or even [area/lightgbm](https://github.com/microsoft/SynapseML/labels/area%2Flightgbm) labels)

-- COMMAND ----------

-- MAGIC %md ## Conference Speaker
-- MAGIC
-- MAGIC In the end, present the talks and demos and open source contributions to a wider audience at our meetups or even at conferences ❤️
