-- Databricks notebook source
-- MAGIC %md # Unity Catalog
-- MAGIC 
-- MAGIC Unified Data Governance on Databricks Platform (for Data, Analytics and AI)

-- COMMAND ----------

-- MAGIC %md ## ⛔️ DISCLAIMER
-- MAGIC 
-- MAGIC Until this cell disappears, consider this notebook a very very **Work in Progress**.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC * Supported on Databricks Runtime 11.3 LTS or above

-- COMMAND ----------

-- MAGIC %md # Get started with Unity Catalog
-- MAGIC 
-- MAGIC * Unity Catalog is a fine-grained goverance solution for data and AI on the Lakehouse
-- MAGIC * An account admin can create and administer a metastore
-- MAGIC     * Add specific workspaces to this metastore
-- MAGIC     * A metastore and assigned workspaces must all be in the same region
-- MAGIC * Setting up Unity Catalog
-- MAGIC     1. Create a metastore
-- MAGIC     1. Add users and groups

-- COMMAND ----------

-- MAGIC %md # Databricks Workspace
-- MAGIC 
-- MAGIC Databricks workspace hosted on [Google Cloud Platform](https://console.cloud.google.com/) (other platforms supported yet not verified by the author so YMMV 😉)
-- MAGIC 
-- MAGIC [Databricks Account Console](https://accounts.gcp.databricks.com/)

-- COMMAND ----------

-- MAGIC %md ## Installation
-- MAGIC 
-- MAGIC [Databricks Product Details](https://console.cloud.google.com/marketplace/product/databricks-prod/databricks?project=databricks-unity-catalog)
-- MAGIC 
-- MAGIC * New Databricks subscription
-- MAGIC * [Databricks account must be on the Premium plan](https://docs.gcp.databricks.com/data-governance/unity-catalog/get-started.html#requirements)

-- COMMAND ----------

-- MAGIC %md ## Google Cloud Storage buckets
-- MAGIC 
-- MAGIC As part of creating a Databricks workspace, two Google Cloud Storage buckets will be created in the GCP project.
-- MAGIC These buckets will host the data that is put in the external DBFS storage and internal DBFS storage, respectively.
-- MAGIC Review the access controls on these buckets in the GCP console.
-- MAGIC 
-- MAGIC [Learn more](https://docs.gcp.databricks.com/administration-guide/workspace/create-workspace.html#secure-the-workspaces-gcs-buckets-in-your-project)

-- COMMAND ----------

-- MAGIC %md ## Setting Up Unity Catalog
-- MAGIC 
-- MAGIC [How do I set up Unity Catalog for my organization?](https://docs.gcp.databricks.com/data-governance/unity-catalog/index.html#how-do-i-set-up-unity-catalog-for-my-organization)
-- MAGIC 
-- MAGIC 1. Create a Databricks Workspace
-- MAGIC     * Workspace name: [learn-databricks](https://3717620220420370.0.gcp.databricks.com)
-- MAGIC     * Region: `europe-west3` (Frankfurt)
-- MAGIC     * Google cloud project ID: `databricks-unity-catalog`
-- MAGIC 1. Configure a GCS bucket for Unity Catalog (e.g., [databricks-unity-catalog-demo](https://console.cloud.google.com/storage/browser/databricks-unity-catalog-demo))
-- MAGIC 1. Create a metastore
-- MAGIC     * A metastore is the top-level container for data in Unity Catalog
-- MAGIC     * Within a metastore, Unity Catalog provides a 3-level namespace for organizing data: catalogs, schemas (_databases_), and tables / views. [Learn More](https://docs.gcp.databricks.com/data-governance/unity-catalog/index.html#metastores)
-- MAGIC     * Name: `demo_metastore`
-- MAGIC     * Region: `europe-west3` (can be different?)
-- MAGIC     * GCS bucket path: [databricks-unity-catalog-europe-west3](https://console.cloud.google.com/storage/browser/databricks-unity-catalog-europe-west3)
-- MAGIC     * Roles Required
-- MAGIC         * Storage Legacy Bucket Reader
-- MAGIC         * Storage Object Admin
-- MAGIC     * As the creator of the metastore you are automatically the **metastore admin**
-- MAGIC         * Metastore admins can create catalogs, and manage privileges for assets within a catalog including storage credentials and external locations.
-- MAGIC         * Metastore ownership can be changed to a different user or group by clicking “edit” next to the metastore owner
-- MAGIC 1. Attach workspaces to the metastore
-- MAGIC     * This happens while creating a metastore
-- MAGIC 1. Add users, groups, and service principals
-- MAGIC     * manage access to assets in Databricks
-- MAGIC     * `group_one`
-- MAGIC 1. Create and grant access to catalogs, schemas, and tables

-- COMMAND ----------

-- MAGIC %md ## Enable Unity Catalog
-- MAGIC 
-- MAGIC While creating a metastore with Unity Catalog...
-- MAGIC 
-- MAGIC Assigning the metastore will update workspaces to use Unity Catalog, meaning that:
-- MAGIC * Data can be governed and accessed across workspaces
-- MAGIC * Data access is captured automatically
-- MAGIC * Identities are managed centrally in the account console
-- MAGIC 
-- MAGIC [Learn more](https://docs.gcp.databricks.com/data-governance/unity-catalog/enable-workspaces.html)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ## Administration
-- MAGIC 
-- MAGIC [Databricks administration introduction](https://docs.gcp.databricks.com/administration-guide/index.html)
-- MAGIC 
-- MAGIC * introduction to Databricks administrator privileges and responsibilities
-- MAGIC * To fully administer your Databricks instance, you will also need administrative access to your Google Cloud account.
-- MAGIC     * [Google Cloud Console](https://console.cloud.google.com/)
-- MAGIC     * [Databricks Account Console](https://accounts.cloud.databricks.com/)
-- MAGIC * Databricks admin types
-- MAGIC     * [Account admins](https://docs.gcp.databricks.com/administration-guide/index.html#account-admins): Manage the Databricks account, including workspace creation, user management, cloud resources, and account usage monitoring.
-- MAGIC     * [Workspace admins](https://docs.gcp.databricks.com/administration-guide/index.html#workspace-admins): Manage workspace identities, access control, settings, and features for individual workspaces in the account.
-- MAGIC * [Account admins](https://docs.gcp.databricks.com/administration-guide/index.html#what-are-account-admins)
-- MAGIC     * have privileges over the entire Databricks account
-- MAGIC     * create workspaces, configure cloud resources, view usage data, and manage account identities, settings, and subscriptions.
-- MAGIC     * delegate the account admin and workspace admin roles to any other user

-- COMMAND ----------

-- MAGIC %md ## What is Unity Catalog?
-- MAGIC 
-- MAGIC [What is Unity Catalog?](https://docs.gcp.databricks.com/data-governance/unity-catalog/index.html)
-- MAGIC 
-- MAGIC * Unity Catalog provides centralized access control, auditing, and data discovery capabilities **across Databricks workspaces**
-- MAGIC * Define once, secure everywhere
-- MAGIC     * a single place to administer data access policies that apply across all workspaces and personas.
-- MAGIC * Standards-compliant security model
-- MAGIC     * Unity Catalog’s security model is based on standard **ANSI SQL**
-- MAGIC     * `GRANT` permissions at the level of catalogs, databases (also called schemas), tables, and views
-- MAGIC * Auditing
-- MAGIC     * captures user-level audit logs that record access to your data
-- MAGIC * Data Discovery
-- MAGIC     * lets you tag and document data assets
-- MAGIC     * provides a search interface to help data consumers find data.

-- COMMAND ----------

-- MAGIC %md ## The Unity Catalog object model
-- MAGIC 
-- MAGIC [The Unity Catalog object model](https://docs.gcp.databricks.com/data-governance/unity-catalog/index.html#the-unity-catalog-object-model)
-- MAGIC 
-- MAGIC * Primary data objects
-- MAGIC     * [Metastore](https://docs.gcp.databricks.com/data-governance/unity-catalog/index.html#metastores): the top-level container of objects in Unity Catalog
-- MAGIC     * Catalog
-- MAGIC     * Schema (_databases_)
-- MAGIC     * Table (tables and views)
-- MAGIC * reference all data in Unity Catalog using a [three-level namespace](https://docs.gcp.databricks.com/data-governance/unity-catalog/queries.html#three-level-namespace-notation)

-- COMMAND ----------

-- MAGIC %md # Key Concepts

-- COMMAND ----------

-- MAGIC %md ## Metastore
-- MAGIC 
-- MAGIC A **metastore** is the top-level container for data in Unity Catalog.
-- MAGIC 
-- MAGIC Within a metastore, Unity Catalog provides a 3-level namespace for organizing data:
-- MAGIC 
-- MAGIC * catalogs
-- MAGIC * schemas (_databases_)
-- MAGIC * tables and views

-- COMMAND ----------

-- MAGIC %md # SQL DDLs

-- COMMAND ----------

-- MAGIC %md ## CREATE CATALOG
-- MAGIC 
-- MAGIC DDLs:
-- MAGIC * [CREATE CATALOG](https://docs.databricks.com/sql/language-manual/sql-ref-syntax-ddl-create-catalog.html)
-- MAGIC * [DROP CATALOG](https://docs.databricks.com/sql/language-manual/sql-ref-syntax-ddl-drop-catalog.html)

-- COMMAND ----------

DROP CATALOG IF EXISTS jacek_laskowski_catalog CASCADE

-- COMMAND ----------

CREATE CATALOG IF NOT EXISTS jacek_laskowski_catalog
COMMENT 'This is a demo catalog'

-- COMMAND ----------

USE CATALOG jacek_laskowski_catalog

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

DROP SCHEMA IF EXISTS jacek_laskowski_catalog.jacek_laskowski_schema CASCADE

-- COMMAND ----------

CREATE SCHEMA IF NOT EXISTS jacek_laskowski_catalog.jacek_laskowski_schema
COMMENT 'My Schema'
WITH DBPROPERTIES (
  'demo' = true,
  -- owner is a reserved namespace property
  'owner.name' = 'Jacek Laskowski',
  'owner.email' = 'jacek@japila.pl');

-- COMMAND ----------

DESCRIBE SCHEMA EXTENDED jacek_laskowski_catalog.jacek_laskowski_schema

-- COMMAND ----------

USE jacek_laskowski_catalog.jacek_laskowski_schema

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

-- COMMAND ----------

-- MAGIC %md ## CREATE TABLE
-- MAGIC 
-- MAGIC DDLs:
-- MAGIC 
-- MAGIC * [CREATE TABLE](https://docs.databricks.com/sql/language-manual/sql-ref-syntax-ddl-create-table.html)
-- MAGIC * [CREATE TABLE [USING]](https://docs.databricks.com/sql/language-manual/sql-ref-syntax-ddl-create-table-using.html)

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS t1
AS SELECT * FROM VALUES (0, 'zero'), (1, 'one') t(id, name)

-- COMMAND ----------

-- MAGIC %md # SQL DCLs
-- MAGIC 
-- MAGIC DCL commands are used to enforce metastore security. There are two types of DCL commands:
-- MAGIC 
-- MAGIC * GRANT
-- MAGIC * REVOKE

-- COMMAND ----------

-- MAGIC %md ## GRANT

-- COMMAND ----------

GRANT SELECT ON main.default.department TO `data-consumers`;
