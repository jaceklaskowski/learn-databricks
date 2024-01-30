-- Databricks notebook source
-- MAGIC %md # Delta Lake 3.1.0
-- MAGIC
-- MAGIC [DeltaLake 3.1.0 RC3](https://github.com/delta-io/delta/releases/tag/v3.1.0rc3) just hit the shelves! 🚀
-- MAGIC
-- MAGIC Learn more in the [LinkedIn post](https://www.linkedin.com/feed/update/urn:li:activity:7157783263820861441?updateEntityUrn=urn%3Ali%3Afs_updateV2%3A%28urn%3Ali%3Aactivity%3A7157783263820861441%2CFEED_DETAIL%2CEMPTY%2CDEFAULT%2Cfalse%29), too.

-- COMMAND ----------

-- MAGIC %md ## Auto Compaction
-- MAGIC
-- MAGIC **Auto compaction** to address the small files problem during table writes. Auto compaction which runs at the end of the write query combines small files within partitions to large files to reduce the metadata size and improve query performance.
-- MAGIC
-- MAGIC ### Learn More
-- MAGIC
-- MAGIC 1. [The official documentation of Delta Lake](https://docs.delta.io/3.1.0/optimizations-oss.html#auto-compaction)
-- MAGIC 1. [The Internals of Delta Lake](https://books.japila.pl/delta-lake-internals/auto-compaction/)

-- COMMAND ----------

-- MAGIC %md ## Liquid Clustering
-- MAGIC
-- MAGIC That's really really huge! 🔥 It is still marked as Experimental, but at least let people have a peek under the hood at how it really works.
-- MAGIC
-- MAGIC From the [announcement](https://github.com/delta-io/delta/releases/tag/v3.1.0rc3):
-- MAGIC
-- MAGIC > (Experimental) Liquid clustering for better table layout Now Delta allows clustering the data in a Delta table for better data skipping. Currently this is an experimental feature. See [documentation](https://docs.delta.io/3.1.0/delta-clustering.html) and [example](https://github.com/delta-io/delta/blob/branch-3.1/examples/scala/src/main/scala/example/Clustering.scala) for how to try out this feature.
