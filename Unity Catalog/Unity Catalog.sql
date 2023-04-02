-- Databricks notebook source
-- MAGIC %md # Unity Catalog

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC 🚧 Until this cell disappears, consider this notebook a very very **Work in Progress**.

-- COMMAND ----------

-- MAGIC %md ## CREATE SCHEMA
-- MAGIC 
-- MAGIC [CREATE SCHEMA](https://docs.databricks.com/sql/language-manual/sql-ref-syntax-ddl-create-schema.html)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC Creates a schema (database) with the specified name.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ### LOCATION
-- MAGIC 
-- MAGIC `LOCATION 'schema_directory'`
-- MAGIC 
-- MAGIC * `LOCATION` is not supported in Unity Catalog. If you want to specify a storage location for a schema in Unity Catalog, use `MANAGED LOCATION`.
-- MAGIC * `schema_directory` is the path of the file system in which the specified schema is to be created.
-- MAGIC     * If the specified path does not exist in the underlying file system, creates a directory with the path
-- MAGIC     * If the location is not specified, the schema is created in the default warehouse directory (under `spark.sql.warehouse.dir`)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ### MANAGED LOCATION
-- MAGIC 
-- MAGIC `MANAGED LOCATION 'location_path'`
-- MAGIC 
-- MAGIC * `MANAGED LOCATION` is optional and requires Unity Catalog.
-- MAGIC     * If you want to specify a storage location for a schema registered in your workspace-level Hive or third-party metastore, use `LOCATION` instead
-- MAGIC * `location_path` specifies the path to a storage root location for the schema that is different than the catalog’s or metastore’s storage root location.
-- MAGIC     * This path must be defined in an external location configuration
-- MAGIC     * You must have the `CREATE MANAGED STORAGE` privilege on the external location configuration
-- MAGIC     * You can use the path that is defined in the external location configuration or a subpath (in other words, 's3://depts/finance' or 's3://depts/finance/product')
-- MAGIC     * Supported in Databricks SQL or on clusters running Databricks Runtime 11.3 and above.

-- COMMAND ----------

DROP SCHEMA IF EXISTS jacek_laskowski

-- COMMAND ----------

CREATE SCHEMA IF NOT EXISTS jacek_laskowski
COMMENT 'Contact the owner at jacek@japila.pl'
WITH DBPROPERTIES (
  'demo' = true,
  'owner_email' = 'jacek@japila.pl');

-- COMMAND ----------

DESCRIBE SCHEMA EXTENDED jacek_laskowski

-- COMMAND ----------

USE jacek_laskowski

-- COMMAND ----------

-- https://docs.databricks.com/sql/language-manual/sql-ref-syntax-aux-show-databases.html
SHOW SCHEMAS LIKE '*jacek_laskowski*'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ## Information schema
-- MAGIC 
-- MAGIC [Information schema](https://docs.databricks.com/sql/language-manual/sql-ref-information-schema.html)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC The `INFORMATION_SCHEMA` is a SQL standard based schema, provided in every catalog created on Unity Catalog.

-- COMMAND ----------

SELECT *
FROM system.information_schema.schemata
