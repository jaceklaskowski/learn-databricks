-- Databricks notebook source
-- MAGIC %md # Auto Loader and Streaming DLTs

-- COMMAND ----------

-- MAGIC %md ## Before We Start

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ### Databricks Runtime 12.2 LTS
-- MAGIC 
-- MAGIC [Databricks Runtime 12.2 LTS](https://docs.databricks.com/release-notes/runtime/12.2.html) is out and is the latest LTS with Apache Spark 3.3.2 under the covers.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC In [Delta Live Tables release notes and the release upgrade process](https://docs.databricks.com/release-notes/delta-live-tables/index.html):
-- MAGIC 
-- MAGIC > Because Delta Live Tables is versionless, both workspace and runtime changes take place automatically.
-- MAGIC 
-- MAGIC > Delta Live Tables is considered to be a versionless product, which means that Databricks automatically upgrades the Delta Live Tables runtime to support enhancements and upgrades to the platform. Databricks recommends limiting external dependencies for Delta Live Tables pipelines.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ### Delta Live Tables Release 2023.06
-- MAGIC 
-- MAGIC [Release 2023.06](https://docs.databricks.com/release-notes/delta-live-tables/2023/06/index.html):
-- MAGIC 
-- MAGIC * Databricks Runtime 11.0.12
-- MAGIC 
-- MAGIC There's an inconsistency though as the UI says 11.3 (under [Compute](/#joblist/pipelines)).

-- COMMAND ----------

-- MAGIC %md ### DLT Pipeline Dependencies
-- MAGIC 
-- MAGIC [Pipeline dependencies](https://docs.databricks.com/release-notes/delta-live-tables/index.html#pipeline-dependencies):
-- MAGIC 
-- MAGIC * Delta Live Tables supports external dependencies in your pipelines;
-- MAGIC     * any Python package using the `%pip install` command
-- MAGIC * Delta Live Tables also supports using global and cluster-scoped [init scripts](https://docs.databricks.com/clusters/init-scripts.html)
-- MAGIC 
-- MAGIC **Recommendation**: [Minimize using init scripts in your pipelines](https://docs.databricks.com/release-notes/delta-live-tables/index.html#pipeline-dependencies)

-- COMMAND ----------

-- MAGIC %md ### Files in Repos
-- MAGIC 
-- MAGIC [What are workspace files?](https://docs.databricks.com/files/workspace.html):
-- MAGIC 
-- MAGIC * Support for workspace files is in Public Preview.
-- MAGIC * Files in Repos is GA
-- MAGIC * A workspace file is any file in the Databricks workspace that is not a Databricks notebook
-- MAGIC     * But...**you cannot embed images in notebooks** :(
-- MAGIC * Workspace files are enabled everywhere by default for Databricks Runtime 11.2 and above. Files in Repos is enabled by default in Databricks Runtime 11.0 and above, and can be manually disabled or enabled.
-- MAGIC * Did you know that...you can use the command `%sh pwd` in a notebook inside a repo to check if Files in Repos is enabled.

-- COMMAND ----------

-- MAGIC %md ## Auto Loader

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC [Auto Loader](https://docs.databricks.com/ingestion/auto-loader/index.html)
-- MAGIC 
-- MAGIC * Auto Loader incrementally and efficiently processes new data files as they arrive in cloud storage
-- MAGIC * Auto Loader can load data files from AWS S3 (s3://), Azure Data Lake Storage Gen2 (ADLS Gen2, abfss://), Google Cloud Storage (GCS, gs://), Azure Blob Storage (wasbs://), ADLS Gen1 (adl://), and Databricks File System (DBFS, dbfs:/)
-- MAGIC * Auto Loader can ingest JSON, CSV, PARQUET, AVRO, ORC, TEXT, and BINARYFILE file formats.
-- MAGIC     * Just like Spark SQL and Spark Structured Streaming
-- MAGIC * Auto Loader provides a **Structured Streaming source** called `cloudFiles`
-- MAGIC * Given an input directory path on the cloud file storage, the `cloudFiles` source automatically processes new files as they arrive, with the option of also processing existing files in that directory.
-- MAGIC * Auto Loader has support for both Python and SQL in Delta Live Tables
-- MAGIC 
-- MAGIC **Recommendation:**
-- MAGIC 
-- MAGIC * Databricks recommends Auto Loader in Delta Live Tables for incremental data ingestion from cloud object storage
-- MAGIC * APIs are available in Python and Scala.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ## Ingest data into Delta Live Tables
-- MAGIC 
-- MAGIC [Ingest data into Delta Live Tables](https://docs.databricks.com/workflows/delta-live-tables/delta-live-tables-data-sources.html):
-- MAGIC 
-- MAGIC * Databricks recommends using Auto Loader for pipelines that read data from supported file formats, particularly for streaming live tables that operate on continually arriving data. Auto Loader is scalable, efficient, and supports schema inference.
-- MAGIC * SQL datasets can use Delta Live Tables file sources to read data in a batch operation from file formats not supported by Auto Loader (see [Spark SQL file sources](https://docs.databricks.com/workflows/delta-live-tables/delta-live-tables-data-sources.html#spark-sql-file-sources)).

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ```sql
-- MAGIC CREATE OR REFRESH LIVE TABLE customers
-- MAGIC AS SELECT * FROM parquet.`/databricks-datasets/samples/lending_club/parquet/`
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md ### Using Auto Loader in Delta Live Tables

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC [Using Auto Loader in Delta Live Tables](https://docs.databricks.com/ingestion/auto-loader/dlt.html)
-- MAGIC 
-- MAGIC * No need to provide a schema or checkpoint location because Delta Live Tables automatically manages these settings for your pipelines.
-- MAGIC * Delta Live Tables provides slightly modified Python syntax for Auto Loader, and adds SQL support for Auto Loader
-- MAGIC     * `cloud_files` a brand new table-valued function (TVF)
-- MAGIC * Delta Live Tables automatically configures and manages the schema and checkpoint directories when using Auto Loader to read files.
-- MAGIC 
-- MAGIC **Recommendation:** Databricks recommends using the automatically configured directories to avoid unexpected side effects during processing.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ```sql
-- MAGIC CREATE OR REFRESH STREAMING LIVE TABLE customers
-- MAGIC AS SELECT * FROM cloud_files("/databricks-datasets/retail-org/customers/", "csv")
-- MAGIC ```
-- MAGIC 
-- MAGIC ```sql
-- MAGIC CREATE OR REFRESH STREAMING LIVE TABLE sales_orders_raw
-- MAGIC AS SELECT * FROM cloud_files("/databricks-datasets/retail-org/sales_orders/", "json")
-- MAGIC ```
-- MAGIC 
-- MAGIC ```sql
-- MAGIC CREATE OR REFRESH STREAMING LIVE TABLE customers
-- MAGIC AS SELECT * FROM cloud_files("/databricks-datasets/retail-org/customers/", "csv", map("delimiter", "\t", "header", "true"))
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md ## Demo
-- MAGIC 
-- MAGIC While working on a demo (`auto_loader.sql`), I ran across the following exception:
-- MAGIC 
-- MAGIC > 'customers' was read as a stream (i.e. using `readStream` or `STREAM(...)`), but 'customers' is not a streaming table. Either add the STREAMING keyword to the CREATE clause or read the input as a table rather than a stream.
-- MAGIC 
-- MAGIC That says the following:
-- MAGIC 
-- MAGIC 1. `CREATE OR REFRESH LIVE TABLE customers AS SELECT * FROM cloud_files("/databricks-datasets/retail-org/customers/", "csv")` without `STREAMING` is not an option
-- MAGIC 1. `readStream` is Spark Structured Streaming but I haven't heard of `STREAM(...)` (!)
-- MAGIC 1. `cloud_files` marks a table as streaming (_somehow_)

-- COMMAND ----------

-- MAGIC %md ### Naming Conventions
-- MAGIC 
-- MAGIC Found in the events window:
-- MAGIC 
-- MAGIC 1. Steps (tasks) in a DLT pipeline are **flows** (_micro-pipelines_?)
-- MAGIC 1. Regular (non-streaming) flows are (defined as) COMPLETE
-- MAGIC 1. Streaming flows are INCREMENTAL and finally COMPLETE
-- MAGIC     1. Streaming updates
-- MAGIC 1. Datasets can be tables or views (incl. streaming)
-- MAGIC 1. Tables are **materialized views**
-- MAGIC 1. Streaming tables are...well...**streaming tables**

-- COMMAND ----------

-- MAGIC %md ### Exception
-- MAGIC 
-- MAGIC ```
-- MAGIC org.apache.spark.sql.AnalysisException: 'customers' was read as a stream (i.e. using `readStream` or `STREAM(...)`), but 'customers' is not a streaming table. Either add the STREAMING keyword to the CREATE clause or read the input as a table rather than a stream.
-- MAGIC at com.databricks.sql.transaction.tahoe.DeltaErrorsBase.analysisException(DeltaErrors.scala:263)
-- MAGIC at com.databricks.sql.transaction.tahoe.DeltaErrorsBase.analysisException$(DeltaErrors.scala:257)
-- MAGIC at com.databricks.sql.transaction.tahoe.DeltaErrors$.analysisException(DeltaErrors.scala:2496)
-- MAGIC at com.databricks.pipelines.graph.DataflowGraph.$anonfun$validate$31(DataflowGraph.scala:800)
-- MAGIC at com.databricks.pipelines.graph.DataflowGraph.$anonfun$validate$31$adapted(DataflowGraph.scala:774)
-- MAGIC at scala.collection.mutable.ResizableArray.foreach(ResizableArray.scala:62)
-- MAGIC at scala.collection.mutable.ResizableArray.foreach$(ResizableArray.scala:55)
-- MAGIC at scala.collection.mutable.ArrayBuffer.foreach(ArrayBuffer.scala:49)
-- MAGIC at com.databricks.pipelines.graph.DataflowGraph.$anonfun$validate$1(DataflowGraph.scala:774)
-- MAGIC at com.databricks.pipelines.graph.DltApiUsageLogging$.$anonfun$recordPipelinesOperation$2(DltApiUsageLogging.scala:33)
-- MAGIC at com.databricks.pipelines.graph.DltApiUsageLogging$.$anonfun$recordPipelinesOperation$3(DltApiUsageLogging.scala:45)
-- MAGIC at com.databricks.logging.UsageLogging.$anonfun$recordOperation$1(UsageLogging.scala:541)
-- MAGIC at com.databricks.logging.UsageLogging.executeThunkAndCaptureResultTags$1(UsageLogging.scala:636)
-- MAGIC at com.databricks.logging.UsageLogging.$anonfun$recordOperationWithResultTags$4(UsageLogging.scala:657)
-- MAGIC at com.databricks.logging.UsageLogging.$anonfun$withAttributionContext$1(UsageLogging.scala:398)
-- MAGIC at scala.util.DynamicVariable.withValue(DynamicVariable.scala:62)
-- MAGIC at com.databricks.logging.AttributionContext$.withValue(AttributionContext.scala:147)
-- MAGIC at com.databricks.logging.UsageLogging.withAttributionContext(UsageLogging.scala:396)
-- MAGIC at com.databricks.logging.UsageLogging.withAttributionContext$(UsageLogging.scala:393)
-- MAGIC at com.databricks.pipelines.graph.DltApiUsageLogging$.withAttributionContext(DltApiUsageLogging.scala:15)
-- MAGIC at com.databricks.logging.UsageLogging.withAttributionTags(UsageLogging.scala:441)
-- MAGIC at com.databricks.logging.UsageLogging.withAttributionTags$(UsageLogging.scala:426)
-- MAGIC at com.databricks.pipelines.graph.DltApiUsageLogging$.withAttributionTags(DltApiUsageLogging.scala:15)
-- MAGIC at com.databricks.logging.UsageLogging.recordOperationWithResultTags(UsageLogging.scala:631)
-- MAGIC at com.databricks.logging.UsageLogging.recordOperationWithResultTags$(UsageLogging.scala:550)
-- MAGIC at com.databricks.pipelines.graph.DltApiUsageLogging$.recordOperationWithResultTags(DltApiUsageLogging.scala:15)
-- MAGIC at com.databricks.logging.UsageLogging.recordOperation(UsageLogging.scala:541)
-- MAGIC at com.databricks.logging.UsageLogging.recordOperation$(UsageLogging.scala:511)
-- MAGIC at com.databricks.pipelines.graph.DltApiUsageLogging$.recordOperation(DltApiUsageLogging.scala:15)
-- MAGIC at com.databricks.pipelines.graph.DltApiUsageLogging$.recordPipelinesOperation(DltApiUsageLogging.scala:45)
-- MAGIC at com.databricks.pipelines.graph.DataflowGraph.validate(DataflowGraph.scala:635)
-- MAGIC at com.databricks.pipelines.graph.Expectations$.computeOrigPrefixAndReturnConnectedGraph(Expectations.scala:202)
-- MAGIC at com.databricks.pipelines.graph.DataflowGraph.$anonfun$enforceExpectations$1(DataflowGraph.scala:485)
-- MAGIC at com.databricks.pipelines.graph.DltApiUsageLogging$.$anonfun$recordPipelinesOperation$2(DltApiUsageLogging.scala:33)
-- MAGIC at com.databricks.pipelines.graph.DltApiUsageLogging$.$anonfun$recordPipelinesOperation$3(DltApiUsageLogging.scala:45)
-- MAGIC at com.databricks.logging.UsageLogging.$anonfun$recordOperation$1(UsageLogging.scala:541)
-- MAGIC at com.databricks.logging.UsageLogging.executeThunkAndCaptureResultTags$1(UsageLogging.scala:636)
-- MAGIC at com.databricks.logging.UsageLogging.$anonfun$recordOperationWithResultTags$4(UsageLogging.scala:657)
-- MAGIC at com.databricks.logging.UsageLogging.$anonfun$withAttributionContext$1(UsageLogging.scala:398)
-- MAGIC at scala.util.DynamicVariable.withValue(DynamicVariable.scala:62)
-- MAGIC at com.databricks.logging.AttributionContext$.withValue(AttributionContext.scala:147)
-- MAGIC at com.databricks.logging.UsageLogging.withAttributionContext(UsageLogging.scala:396)
-- MAGIC at com.databricks.logging.UsageLogging.withAttributionContext$(UsageLogging.scala:393)
-- MAGIC at com.databricks.pipelines.graph.DltApiUsageLogging$.withAttributionContext(DltApiUsageLogging.scala:15)
-- MAGIC at com.databricks.logging.UsageLogging.withAttributionTags(UsageLogging.scala:441)
-- MAGIC at com.databricks.logging.UsageLogging.withAttributionTags$(UsageLogging.scala:426)
-- MAGIC at com.databricks.pipelines.graph.DltApiUsageLogging$.withAttributionTags(DltApiUsageLogging.scala:15)
-- MAGIC at com.databricks.logging.UsageLogging.recordOperationWithResultTags(UsageLogging.scala:631)
-- MAGIC at com.databricks.logging.UsageLogging.recordOperationWithResultTags$(UsageLogging.scala:550)
-- MAGIC at com.databricks.pipelines.graph.DltApiUsageLogging$.recordOperationWithResultTags(DltApiUsageLogging.scala:15)
-- MAGIC at com.databricks.logging.UsageLogging.recordOperation(UsageLogging.scala:541)
-- MAGIC at com.databricks.logging.UsageLogging.recordOperation$(UsageLogging.scala:511)
-- MAGIC at com.databricks.pipelines.graph.DltApiUsageLogging$.recordOperation(DltApiUsageLogging.scala:15)
-- MAGIC at com.databricks.pipelines.graph.DltApiUsageLogging$.recordPipelinesOperation(DltApiUsageLogging.scala:45)
-- MAGIC at com.databricks.pipelines.graph.DataflowGraph.enforceExpectations(DataflowGraph.scala:482)
-- MAGIC at com.databricks.pipelines.execution.core.FlowExecution.$anonfun$addExpectationAndReturnConnectedValidateGraph$1(FlowExecution.scala:143)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.DeltaPipelinesUsageLogging.$anonfun$recordPipelinesOperation$2(DeltaPipelinesUsageLogging.scala:105)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.DeltaPipelinesUsageLogging.$anonfun$recordPipelinesOperation$5(DeltaPipelinesUsageLogging.scala:125)
-- MAGIC at com.databricks.logging.UsageLogging.$anonfun$recordOperation$1(UsageLogging.scala:541)
-- MAGIC at com.databricks.logging.UsageLogging.executeThunkAndCaptureResultTags$1(UsageLogging.scala:636)
-- MAGIC at com.databricks.logging.UsageLogging.$anonfun$recordOperationWithResultTags$4(UsageLogging.scala:657)
-- MAGIC at com.databricks.logging.UsageLogging.$anonfun$withAttributionContext$1(UsageLogging.scala:398)
-- MAGIC at scala.util.DynamicVariable.withValue(DynamicVariable.scala:62)
-- MAGIC at com.databricks.logging.AttributionContext$.withValue(AttributionContext.scala:147)
-- MAGIC at com.databricks.logging.UsageLogging.withAttributionContext(UsageLogging.scala:396)
-- MAGIC at com.databricks.logging.UsageLogging.withAttributionContext$(UsageLogging.scala:393)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.PublicLogging.withAttributionContext(DeltaPipelinesUsageLogging.scala:24)
-- MAGIC at com.databricks.logging.UsageLogging.withAttributionTags(UsageLogging.scala:441)
-- MAGIC at com.databricks.logging.UsageLogging.withAttributionTags$(UsageLogging.scala:426)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.PublicLogging.withAttributionTags(DeltaPipelinesUsageLogging.scala:24)
-- MAGIC at com.databricks.logging.UsageLogging.recordOperationWithResultTags(UsageLogging.scala:631)
-- MAGIC at com.databricks.logging.UsageLogging.recordOperationWithResultTags$(UsageLogging.scala:550)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.PublicLogging.recordOperationWithResultTags(DeltaPipelinesUsageLogging.scala:24)
-- MAGIC at com.databricks.logging.UsageLogging.recordOperation(UsageLogging.scala:541)
-- MAGIC at com.databricks.logging.UsageLogging.recordOperation$(UsageLogging.scala:511)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.PublicLogging.recordOperation(DeltaPipelinesUsageLogging.scala:24)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.PublicLogging.recordOperation0(DeltaPipelinesUsageLogging.scala:59)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.DeltaPipelinesUsageLogging.recordPipelinesOperation(DeltaPipelinesUsageLogging.scala:117)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.DeltaPipelinesUsageLogging.recordPipelinesOperation$(DeltaPipelinesUsageLogging.scala:89)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.DeltaPipelinesUsageLogging$.recordPipelinesOperation(DeltaPipelinesUsageLogging.scala:259)
-- MAGIC at com.databricks.pipelines.execution.core.FlowExecution.addExpectationAndReturnConnectedValidateGraph(FlowExecution.scala:132)
-- MAGIC at com.databricks.pipelines.execution.core.FlowExecution.<init>(FlowExecution.scala:196)
-- MAGIC at com.databricks.pipelines.execution.core.TriggeredFlowExecution.<init>(TriggeredFlowExecution.scala:40)
-- MAGIC at com.databricks.pipelines.execution.core.UpdateExecution.createFlowExecution(UpdateExecution.scala:97)
-- MAGIC at com.databricks.pipelines.execution.core.UpdateExecution.$anonfun$setupTables$5(UpdateExecution.scala:370)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.DeltaPipelinesUsageLogging.$anonfun$recordPipelinesOperation$2(DeltaPipelinesUsageLogging.scala:105)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.DeltaPipelinesUsageLogging.$anonfun$recordPipelinesOperation$5(DeltaPipelinesUsageLogging.scala:125)
-- MAGIC at com.databricks.logging.UsageLogging.$anonfun$recordOperation$1(UsageLogging.scala:541)
-- MAGIC at com.databricks.logging.UsageLogging.executeThunkAndCaptureResultTags$1(UsageLogging.scala:636)
-- MAGIC at com.databricks.logging.UsageLogging.$anonfun$recordOperationWithResultTags$4(UsageLogging.scala:657)
-- MAGIC at com.databricks.logging.UsageLogging.$anonfun$withAttributionContext$1(UsageLogging.scala:398)
-- MAGIC at scala.util.DynamicVariable.withValue(DynamicVariable.scala:62)
-- MAGIC at com.databricks.logging.AttributionContext$.withValue(AttributionContext.scala:147)
-- MAGIC at com.databricks.logging.UsageLogging.withAttributionContext(UsageLogging.scala:396)
-- MAGIC at com.databricks.logging.UsageLogging.withAttributionContext$(UsageLogging.scala:393)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.PublicLogging.withAttributionContext(DeltaPipelinesUsageLogging.scala:24)
-- MAGIC at com.databricks.logging.UsageLogging.withAttributionTags(UsageLogging.scala:441)
-- MAGIC at com.databricks.logging.UsageLogging.withAttributionTags$(UsageLogging.scala:426)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.PublicLogging.withAttributionTags(DeltaPipelinesUsageLogging.scala:24)
-- MAGIC at com.databricks.logging.UsageLogging.recordOperationWithResultTags(UsageLogging.scala:631)
-- MAGIC at com.databricks.logging.UsageLogging.recordOperationWithResultTags$(UsageLogging.scala:550)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.PublicLogging.recordOperationWithResultTags(DeltaPipelinesUsageLogging.scala:24)
-- MAGIC at com.databricks.logging.UsageLogging.recordOperation(UsageLogging.scala:541)
-- MAGIC at com.databricks.logging.UsageLogging.recordOperation$(UsageLogging.scala:511)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.PublicLogging.recordOperation(DeltaPipelinesUsageLogging.scala:24)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.PublicLogging.recordOperation0(DeltaPipelinesUsageLogging.scala:59)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.DeltaPipelinesUsageLogging.recordPipelinesOperation(DeltaPipelinesUsageLogging.scala:117)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.DeltaPipelinesUsageLogging.recordPipelinesOperation$(DeltaPipelinesUsageLogging.scala:89)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.DeltaPipelinesUsageLogging$.recordPipelinesOperation(DeltaPipelinesUsageLogging.scala:259)
-- MAGIC at com.databricks.pipelines.execution.core.UpdateExecution.$anonfun$setupTables$1(UpdateExecution.scala:370)
-- MAGIC at scala.runtime.java8.JFunction0$mcV$sp.apply(JFunction0$mcV$sp.java:23)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.DeltaPipelinesUsageLogging.$anonfun$recordPipelinesOperation$2(DeltaPipelinesUsageLogging.scala:105)
-- MAGIC at com.databricks.pipelines.common.monitoring.OperationStatusReporter.executeWithPeriodicReporting(OperationStatusReporter.scala:120)
-- MAGIC at com.databricks.pipelines.common.monitoring.OperationStatusReporter$.executeWithPeriodicReporting(OperationStatusReporter.scala:160)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.DeltaPipelinesUsageLogging.$anonfun$recordPipelinesOperation$5(DeltaPipelinesUsageLogging.scala:124)
-- MAGIC at com.databricks.logging.UsageLogging.$anonfun$recordOperation$1(UsageLogging.scala:541)
-- MAGIC at com.databricks.logging.UsageLogging.executeThunkAndCaptureResultTags$1(UsageLogging.scala:636)
-- MAGIC at com.databricks.logging.UsageLogging.$anonfun$recordOperationWithResultTags$4(UsageLogging.scala:657)
-- MAGIC at com.databricks.logging.UsageLogging.$anonfun$withAttributionContext$1(UsageLogging.scala:398)
-- MAGIC at scala.util.DynamicVariable.withValue(DynamicVariable.scala:62)
-- MAGIC at com.databricks.logging.AttributionContext$.withValue(AttributionContext.scala:147)
-- MAGIC at com.databricks.logging.UsageLogging.withAttributionContext(UsageLogging.scala:396)
-- MAGIC at com.databricks.logging.UsageLogging.withAttributionContext$(UsageLogging.scala:393)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.PublicLogging.withAttributionContext(DeltaPipelinesUsageLogging.scala:24)
-- MAGIC at com.databricks.logging.UsageLogging.withAttributionTags(UsageLogging.scala:441)
-- MAGIC at com.databricks.logging.UsageLogging.withAttributionTags$(UsageLogging.scala:426)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.PublicLogging.withAttributionTags(DeltaPipelinesUsageLogging.scala:24)
-- MAGIC at com.databricks.logging.UsageLogging.recordOperationWithResultTags(UsageLogging.scala:631)
-- MAGIC at com.databricks.logging.UsageLogging.recordOperationWithResultTags$(UsageLogging.scala:550)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.PublicLogging.recordOperationWithResultTags(DeltaPipelinesUsageLogging.scala:24)
-- MAGIC at com.databricks.logging.UsageLogging.recordOperation(UsageLogging.scala:541)
-- MAGIC at com.databricks.logging.UsageLogging.recordOperation$(UsageLogging.scala:511)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.PublicLogging.recordOperation(DeltaPipelinesUsageLogging.scala:24)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.PublicLogging.recordOperation0(DeltaPipelinesUsageLogging.scala:59)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.DeltaPipelinesUsageLogging.recordPipelinesOperation(DeltaPipelinesUsageLogging.scala:117)
-- MAGIC at com.databricks.pipelines.execution.core.monitoring.DeltaPipelinesUsageLogging.recordPipelinesOperation$(DeltaPipelinesUsageLogging.scala:89)
-- MAGIC at com.databricks.pipelines.execution.core.UpdateExecution.recordPipelinesOperation(UpdateExecution.scala:53)
-- MAGIC at com.databricks.pipelines.execution.core.UpdateExecution.executeStage(UpdateExecution.scala:241)
-- MAGIC at com.databricks.pipelines.execution.core.UpdateExecution.setupTables(UpdateExecution.scala:353)
-- MAGIC at com.databricks.pipelines.execution.core.UpdateExecution.executeUpdate(UpdateExecution.scala:318)
-- MAGIC at com.databricks.pipelines.execution.core.UpdateExecution.$anonfun$start$1(UpdateExecution.scala:116)
-- MAGIC at scala.runtime.java8.JFunction0$mcV$sp.apply(JFunction0$mcV$sp.java:23)
-- MAGIC at com.databricks.pipelines.execution.core.UCContextCompanion$OptionUCContextHelper.runWithNewUCSIfAvailable(BaseUCContext.scala:201)
-- MAGIC at com.databricks.pipelines.execution.core.UpdateExecution.start(UpdateExecution.scala:113)
-- MAGIC at com.databricks.pipelines.execution.service.ExecutionBackend$$anon$1.run(ExecutionBackend.scala:421)
-- MAGIC at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)
-- MAGIC at java.util.concurrent.FutureTask.run(FutureTask.java:266)
-- MAGIC at org.apache.spark.util.threads.SparkThreadLocalCapturingRunnable.$anonfun$run$1(SparkThreadLocalForwardingThreadPoolExecutor.scala:110)
-- MAGIC at scala.runtime.java8.JFunction0$mcV$sp.apply(JFunction0$mcV$sp.java:23)
-- MAGIC at com.databricks.unity.UCSEphemeralState$Handle.runWith(UCSEphemeralState.scala:41)
-- MAGIC at org.apache.spark.util.threads.SparkThreadLocalCapturingHelper.runWithCaptured(SparkThreadLocalForwardingThreadPoolExecutor.scala:74)
-- MAGIC at org.apache.spark.util.threads.SparkThreadLocalCapturingHelper.runWithCaptured$(SparkThreadLocalForwardingThreadPoolExecutor.scala:60)
-- MAGIC at org.apache.spark.util.threads.SparkThreadLocalCapturingRunnable.runWithCaptured(SparkThreadLocalForwardingThreadPoolExecutor.scala:107)
-- MAGIC at org.apache.spark.util.threads.SparkThreadLocalCapturingRunnable.run(SparkThreadLocalForwardingThreadPoolExecutor.scala:110)
-- MAGIC at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)
-- MAGIC at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)
-- MAGIC at java.lang.Thread.run(Thread.java:750)
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md ## Project Enzyme
-- MAGIC 
-- MAGIC Remember in the Pipeline Event Logs where Enzyme was mentioned?
-- MAGIC 
-- MAGIC > Flow dlt_two has been planned in Enzyme to be executed as COMPLETE_RECOMPUTE.
-- MAGIC 
-- MAGIC [Delta Live Tables Announces New Capabilities and Performance Optimizations](https://www.databricks.com/blog/2022/06/29/delta-live-tables-announces-new-capabilities-and-performance-optimizations.html):
-- MAGIC 
-- MAGIC > DLT announces it is developing **Enzyme**, a performance optimization purpose-built for ETL workloads, and launches several new capabilities including Enhanced Autoscaling