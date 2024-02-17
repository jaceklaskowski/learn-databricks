-- Databricks notebook source
-- MAGIC %md # Unity Catalog
-- MAGIC
-- MAGIC Unified Data Governance on Databricks Platform (for Data, Analytics and AI)
-- MAGIC
-- MAGIC Databricks Runtime 11.3 LTS or above

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC > ⚠️ **DISCLAIMER**
-- MAGIC >
-- MAGIC > What's included in the notebook is still mainly a bunch of excerpts from the official Databricks documentation for the supported cloud provider (mainly [Google Cloud Platform](https://docs.gcp.databricks.com/index.html) and [Azure Databricks](https://learn.microsoft.com/en-us/azure/databricks/)).

-- COMMAND ----------

-- MAGIC %md ## A bit of History (Context)
-- MAGIC
-- MAGIC * Back then Apache Hive used Hadoop MapReduce and HDFS
-- MAGIC * Back then cloud was not a thing. Hive deployments mostly on-prem(ise)
-- MAGIC * Spark SQL tries to move people off of Apache Hive
-- MAGIC * Deployments move to the cloud. Cloud adoption grows
-- MAGIC * Many Managed Spark in Cloud offerings by various vendors
-- MAGIC * One of the main competitors of Databricks, Snowflake offers [Snowpark](https://www.snowflake.com/en/data-cloud/snowpark/)
-- MAGIC
-- MAGIC ---
-- MAGIC
-- MAGIC * [Why is Spark SQL so obsessed with Hive?! (after just a single day with Hive)](https://jaceklaskowski.medium.com/why-is-spark-sql-so-obsessed-with-hive-after-just-a-single-day-with-hive-289e75fa6f2b)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Open Questions / TODOs
-- MAGIC
-- MAGIC 1. How to access Unity Catalog's Access log?
-- MAGIC 1. How is Unity Catalog mapped to catalogs in Catalog view in a Databricks workspace? When does table data land in the underlying bucket?
-- MAGIC 1. Is it possible to attach multiple Unity Catalog's metastores to a single Databricks workspace?
-- MAGIC

-- COMMAND ----------

-- MAGIC %md # Introduction to Unity Catalog
-- MAGIC
-- MAGIC * **Unity Catalog** is a unified governance solution for data, analytics and AI on the lakehouse
-- MAGIC * An enterprise-wide **data catalog** for data & governance teams
-- MAGIC * A centralized **metadata layer** to catalog data assets across your lakehouse
-- MAGIC * A single interface to manage permissions, centralize auditing, and share data across platforms, clouds and regions
-- MAGIC * An account admin can create and administer a metastore
-- MAGIC     * Add specific Databricks workspaces to this metastore
-- MAGIC     * You can share a single metastore across multiple Databricks workspaces in an account
-- MAGIC     * A metastore and assigned workspaces must all be in the same region
-- MAGIC * Multiple Databricks workspaces and a single shared Unity Catalog
-- MAGIC     * Create one metastore per region and attach it to any number of workspaces in that region
-- MAGIC     * Each linked workspace has the same view of the data in the metastore
-- MAGIC     * Manage data access control across workspaces
-- MAGIC     * A metastore in UC should have the same region as your bucket and workspace
-- MAGIC     * It's a common practice to have 1 metastore per region (with many workspaces attached)
-- MAGIC * Setting up Unity Catalog
-- MAGIC     1. Create a metastore
-- MAGIC     1. Add users and groups

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC [What is Unity Catalog?](https://docs.gcp.databricks.com/data-governance/unity-catalog/index.html)
-- MAGIC
-- MAGIC * Unity Catalog provides centralized access control, auditing, and data discovery capabilities **across Databricks workspaces**
-- MAGIC * Define once, secure everywhere
-- MAGIC     * a single place to administer data access policies that apply across all workspaces and personas.
-- MAGIC * Standards-compliant security model
-- MAGIC     * Unity Catalog’s security model is based on standard **ANSI SQL**
-- MAGIC     * **Data Control Language** ([DCL](https://en.wikipedia.org/wiki/Data_control_language))
-- MAGIC     * `GRANT` permissions at the level of catalogs, databases (also called schemas), tables, and views
-- MAGIC     * `REVOKE` permissions
-- MAGIC * Auditing
-- MAGIC     * captures user-level audit logs that record access to your data
-- MAGIC * Data Discovery
-- MAGIC     * lets you tag and document data assets
-- MAGIC     * provides a search interface to help data consumers find data.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC [About enabling workspaces for Unity Catalog](https://learn.microsoft.com/en-us/azure/databricks/data-governance/unity-catalog/enable-workspaces)
-- MAGIC
-- MAGIC * To enable an Azure Databricks workspace for Unity Catalog, you assign the workspace to a Unity Catalog metastore.
-- MAGIC * Users in that workspace can potentially access the same data that users in other workspaces in your account can access, and data stewards can manage that data access centrally, across workspaces
-- MAGIC * Identity federation is enabled for the workspace, allowing admins to manage identities centrally using the account console and other account-level interfaces. This includes assigning users to workspaces.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC # Unity Catalog Metastore
-- MAGIC
-- MAGIC * The top-level container for data in Unity Catalog
-- MAGIC * Uses a 3-level namespace (`catalog.schema.table`) by which data can be organized
-- MAGIC * A schema is formerly known as a database

-- COMMAND ----------

-- MAGIC %md ## Assign Metastore to Workspaces
-- MAGIC
-- MAGIC Also known as **Enable Workspaces for Unity Catalog**
-- MAGIC
-- MAGIC Assigning the metastore will update workspaces to use Unity Catalog, meaning that:
-- MAGIC * Data can be governed and accessed across workspaces
-- MAGIC * Data access is captured automatically
-- MAGIC * Identities are managed centrally in the account console
-- MAGIC
-- MAGIC ## Learn More
-- MAGIC
-- MAGIC * [Azure Databricks](https://learn.microsoft.com/en-us/azure/databricks/data-governance/unity-catalog/enable-workspaces)
-- MAGIC * [Databricks on Google Cloud](https://docs.gcp.databricks.com/data-governance/unity-catalog/enable-workspaces.html)
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Metastore Admin
-- MAGIC
-- MAGIC * Only admins can create catalogs
-- MAGIC * Assign a group to be a metastore admin

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Metastore Owner
-- MAGIC
-- MAGIC * Only Metastore Owners can create catalogs
-- MAGIC * Assign a group as Owner in your Metastore configuration

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Delta Sharing
-- MAGIC
-- MAGIC * [Delta sharing](https://delta.io/sharing/) lets you share your data with external organizations
-- MAGIC * An open sharing standard, integrated with Databricks Unity Catalog

-- COMMAND ----------

-- MAGIC %md # Databricks on Google Cloud
-- MAGIC
-- MAGIC A Databricks workspace hosted on [Google Cloud Platform](https://console.cloud.google.com/) (other platforms supported yet not verified by the author so YMMV 😉)
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

-- MAGIC %md # Unity Catalog Setup (Databricks on GCP)
-- MAGIC
-- MAGIC [How do I set up Unity Catalog for my organization?](https://docs.gcp.databricks.com/data-governance/unity-catalog/index.html#how-do-i-set-up-unity-catalog-for-my-organization)

-- COMMAND ----------

-- MAGIC %md ## Create Databricks Workspace
-- MAGIC
-- MAGIC 1. Open up Databricks Account Console ([GCP](https://accounts.gcp.databricks.com), [Azure](https://accounts.azuredatabricks.net/))
-- MAGIC 1. Click [Workspaces](https://accounts.gcp.databricks.com/workspaces) and then click [Create workspace](https://accounts.gcp.databricks.com/workspaces/create) button
-- MAGIC 1. [Create a Databricks Workspace](https://accounts.gcp.databricks.com/workspaces/create)
-- MAGIC     * Workspace name: `learn-databricks`
-- MAGIC     * Region: `europe-west3` (Frankfurt)
-- MAGIC     * Google cloud project ID: `databricks-unity-catalog` (this is how Databricks is attached to a GCP project)
-- MAGIC     * There is **Advanced configurations** section (but it's advanced and so beyond my current interest 😎)
-- MAGIC     * Click **Save** button
-- MAGIC
-- MAGIC You should receive an email **Your Databricks workspace is ready** once the workspace is provisioned.
-- MAGIC
-- MAGIC **NOTE** You may have up to 20 workspaces in a single Databricks account.

-- COMMAND ----------

-- MAGIC
-- MAGIC %md
-- MAGIC
-- MAGIC ## Resource Quotas (Optional)
-- MAGIC
-- MAGIC **NOTE:**
-- MAGIC This is an optional step while setting up a Databricks workspace with Unity Catalog for demo purposes
-- MAGIC
-- MAGIC While setting up a workspace, you should ensure that your project has the [required resource quotas](https://docs.gcp.databricks.com/administration-guide/account-settings-gcp/quotas.html) for running Databricks at scale (to support your jobs and clusters).
-- MAGIC
-- MAGIC When you create a Databricks workspace, you specify a Google Cloud project, which Databricks uses to create new resources such as virtual machine instances for clusters.
-- MAGIC
-- MAGIC Check out the [Quotas page in the Cloud Console](https://console.cloud.google.com/iam-admin/quotas).
-- MAGIC
-- MAGIC ### Learn More
-- MAGIC
-- MAGIC * [Review and set Google Cloud resource quotas for a workspace](https://docs.gcp.databricks.com/administration-guide/account-settings-gcp/quotas.html)

-- COMMAND ----------

-- MAGIC %md ## GCP Storage Buckets
-- MAGIC
-- MAGIC As part of a workspace creation, two Google Cloud Storage buckets are going to be created in your GCP project.
-- MAGIC
-- MAGIC These buckets host the data that is put in the external DBFS storage and internal DBFS storage, respectively.
-- MAGIC
-- MAGIC Please review the access controls on these buckets in the GCP console. [Inspect your buckets in GCP Console](https://console.cloud.google.com/storage/browser?project=databricks-unity-catalog).
-- MAGIC
-- MAGIC ### Learn More
-- MAGIC
-- MAGIC * [Secure the workspace’s GCS buckets in your project](https://docs.gcp.databricks.com/administration-guide/account-settings-gcp/workspaces.html#secure-the-workspaces-gcs-buckets-in-your-project)

-- COMMAND ----------

-- MAGIC %md ## GCS Bucket for Unity Catalog
-- MAGIC
-- MAGIC Configure a GCS bucket for Unity Catalog
-- MAGIC
-- MAGIC 1. Click [Cloud Storage](https://console.cloud.google.com/storage/browser?project=databricks-unity-catalog) and then click [CREATE](https://console.cloud.google.com/storage/create-bucket?project=databricks-unity-catalog) button
-- MAGIC     * Name: [databricks-unity-catalog-demo](https://console.cloud.google.com/storage/browser/databricks-unity-catalog-demo)
-- MAGIC     * Region: `europe-west3` (Location type can be as wide as **Multi-region** or as tiny as **Region**)
-- MAGIC     * Leave the other settings as-is. Click CREATE button.
-- MAGIC
-- MAGIC Once created, you can access the bucket using the [Storage Browser](https://console.cloud.google.com/storage/browser/databricks-unity-catalog-demo;tab=objects?project=databricks-unity-catalog).
-- MAGIC
-- MAGIC The bucket is going to be used as the default storage location for managed tables and metadata associated with a UC metastore.
-- MAGIC
-- MAGIC Roles Required:
-- MAGIC * Storage Legacy Bucket Reader
-- MAGIC * Storage Object Admin
-- MAGIC
-- MAGIC The roles are checked right after a metastore is created for a principal that is created automatically while setting up a metastore.
-- MAGIC
-- MAGIC The creator of the metastore is automatically the **metastore admin**
-- MAGIC * Metastore admins can create catalogs, and manage privileges for assets within a catalog including storage credentials and external locations.
-- MAGIC * Metastore ownership can be changed to a different user or group by clicking “edit” next to the metastore owner

-- COMMAND ----------

-- MAGIC %md ## Create Metastore
-- MAGIC
-- MAGIC While in Databricks Account Console...
-- MAGIC
-- MAGIC 1. Click [Data](https://accounts.gcp.databricks.com/data) (in the menu on the left) and then click [Create metastore](https://accounts.gcp.databricks.com/data/create) button
-- MAGIC     * Name: `demo_metastore`
-- MAGIC     * Region: `europe-west3` (Select a region where the cloud storage account and most of your workspaces are located)
-- MAGIC     * GCS bucket path: [databricks-unity-catalog-demo](https://console.cloud.google.com/storage/browser/databricks-unity-catalog-demo)

-- COMMAND ----------

-- MAGIC %md ### Storage Access
-- MAGIC
-- MAGIC In the [Google Cloud Console](https://console.cloud.google.com/), navigate to the GCS bucket and grant the below service account the following roles by clicking on the "Permissions" tab.
-- MAGIC
-- MAGIC **Roles Required**
-- MAGIC * Storage Legacy Bucket Reader
-- MAGIC * Storage Object Admin
-- MAGIC
-- MAGIC **GCS Bucket Path**
-- MAGIC * [databricks-unity-catalog-demo](https://console.cloud.google.com/storage/browser/databricks-unity-catalog-demo)
-- MAGIC
-- MAGIC **Service Account Name**
-- MAGIC * `db-uc-storage-...@uc-europewest3.iam.gserviceaccount.com`
-- MAGIC
-- MAGIC Click **Permissions granted** button to trigger the check.

-- COMMAND ----------

-- MAGIC %md ### Assign to workspaces
-- MAGIC
-- MAGIC This is Step 2 in **Create metastore** procedure.
-- MAGIC
-- MAGIC Select at least one workspace to proceed. Click **Assign** button.
-- MAGIC
-- MAGIC Read the instructions in **Enable Unity Catalog?** popup window. Click **Enable** button.

-- COMMAND ----------

-- MAGIC %md ### Metadata Created! 🎉
-- MAGIC
-- MAGIC Metastore `demo_metastore` has been created.
-- MAGIC
-- MAGIC To add data to the metastore, open a workspace assigned to this metastore, and import the example notebook.
-- MAGIC
-- MAGIC You can also enable Delta Sharing to securely share read-only access to the data outside your organization.
-- MAGIC
-- MAGIC As the creator of the metastore you are automatically the metastore admin.
-- MAGIC
-- MAGIC Metastore admins can create catalogs, and manage privileges for assets within a catalog including storage credentials and external locations. Metastore ownership can be changed to a different user or group by clicking “edit” next to the metastore owner
-- MAGIC
-- MAGIC Click **Close** button.

-- COMMAND ----------

-- MAGIC %md ## Metastore Admin

-- COMMAND ----------

-- MAGIC %md ## Account Users
-- MAGIC
-- MAGIC **Account users** can use the account console to view and connect to their workspaces

-- COMMAND ----------

-- MAGIC %md ## Workspace Permissions
-- MAGIC
-- MAGIC Add users, groups, and service principals to the Databricks workspace.
-- MAGIC
-- MAGIC Open up the workspace in [Workspaces](https://accounts.gcp.databricks.com/workspaces).
-- MAGIC
-- MAGIC There should be **Metastore** tile (after **Google Cloud project ID** and **Region**).
-- MAGIC
-- MAGIC Click [Permissions](https://accounts.gcp.databricks.com/workspaces/6892394481391645/permissions) tab to assign users, groups, and service principals to this workspace.

-- COMMAND ----------

-- MAGIC %md ## Metadata Permissions (Optional)
-- MAGIC
-- MAGIC **NOTE:** This is an optional step and can be done using `GRANT` and `REVOKE` commands.
-- MAGIC
-- MAGIC Open up the workspace and select **Data** (in the menu on the left).
-- MAGIC
-- MAGIC Open metastore details and set permissions
-- MAGIC 1. Click the link next to `demo_metastore` metastore name (next to **Data Explorer** title)
-- MAGIC 1. Click **Permissions** tab

-- COMMAND ----------

-- MAGIC %md # Demo

-- COMMAND ----------

-- MAGIC %md ## Current User

-- COMMAND ----------

SELECT current_user()

-- COMMAND ----------

-- MAGIC %md ## Create Catalog

-- COMMAND ----------

-- https://docs.databricks.com/sql/language-manual/sql-ref-syntax-ddl-drop-catalog.html
DROP CATALOG IF EXISTS demo_catalog CASCADE;

-- https://docs.databricks.com/sql/language-manual/sql-ref-syntax-ddl-create-catalog.html
CREATE CATALOG demo_catalog
COMMENT 'For Unity Catalog demo purposes';

-- COMMAND ----------

-- MAGIC %md ## Create Schema

-- COMMAND ----------

-- https://docs.databricks.com/sql/language-manual/sql-ref-syntax-ddl-create-schema.html
CREATE SCHEMA IF NOT EXISTS demo_catalog.demo_schema;

-- COMMAND ----------

-- MAGIC %md ## Create Table

-- COMMAND ----------

USE SCHEMA demo_schema;
CREATE TABLE IF NOT EXISTS names (
  id BIGINT GENERATED ALWAYS AS IDENTITY,
  name STRING NOT NULL
)
USING delta;
INSERT INTO names (name) VALUES ("it works!");

-- COMMAND ----------

DESC EXTENDED names

-- COMMAND ----------

-- MAGIC %md ## Grant Privileges

-- COMMAND ----------

GRANT SELECT ON demo_catalog.demo_schema.names TO `jacek@japila.pl`;

-- COMMAND ----------

SHOW GRANTS ON demo_catalog.demo_schema.names

-- COMMAND ----------

SELECT * FROM demo_catalog.information_schema.table_privileges
WHERE table_name = 'names'

-- COMMAND ----------

GRANT USE CATALOG ON CATALOG demo_catalog TO `eljotpl@gmail.com`;
GRANT USE SCHEMA ON SCHEMA demo_schema TO `eljotpl@gmail.com`;

-- COMMAND ----------

GRANT SELECT ON names TO `eljotpl@gmail.com`;

-- COMMAND ----------

SHOW GRANTS ON demo_catalog.demo_schema.names

-- COMMAND ----------

-- MAGIC %md ## SELECT as Non Table Owner
-- MAGIC
-- MAGIC Execute `SELECT * FROM demo_catalog.demo_schema.names` as the other user (i.e., `eljotpl@gmail.com`).
-- MAGIC
-- MAGIC It should work fine.

-- COMMAND ----------

-- MAGIC %md ## Revoke All Privileges

-- COMMAND ----------

REVOKE ALL PRIVILEGES ON demo_catalog.demo_schema.names FROM `eljotpl@gmail.com`

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC Executing `SELECT * FROM demo_catalog.demo_schema.names` as the other user (i.e., `eljotpl@gmail.com`) will fail with the following exception:
-- MAGIC
-- MAGIC > AnalysisException: User does not have SELECT on Table 'demo_catalog.demo_schema.names'.

-- COMMAND ----------

SHOW GRANTS ON demo_catalog.demo_schema.names

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC The owner should be fine to execute `SELECT` statements.

-- COMMAND ----------

SELECT * FROM demo_catalog.demo_schema.names

-- COMMAND ----------

-- MAGIC %md ## Alter Table Owner

-- COMMAND ----------

ALTER TABLE demo_catalog.demo_schema.names SET OWNER TO `eljotpl@gmail.com`

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC Executing `SELECT * FROM demo_catalog.demo_schema.names` as the other user (i.e., eljotpl@gmail.com) will no longer fail since it's the owner of the table.

-- COMMAND ----------

-- MAGIC %md ## Revoke All From All
-- MAGIC
-- MAGIC Revoke all privileges from all workspace users (except the owner).

-- COMMAND ----------

-- users special principal cannot be used with securable objects in Unity Catalog
-- users is a Hive Metastore principal
REVOKE ALL PRIVILEGES ON demo_catalog.demo_schema.names FROM `account users`;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC # Administration
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

-- MAGIC %md # The Unity Catalog Object Model
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

-- MAGIC %md ## Metastore
-- MAGIC
-- MAGIC A **metastore** is the top-level container for data in Unity Catalog.
-- MAGIC
-- MAGIC Within a metastore, Unity Catalog provides a 3-level namespace for organizing data:
-- MAGIC
-- MAGIC * catalogs
-- MAGIC * schemas (_databases_)
-- MAGIC * tables and views
-- MAGIC
-- MAGIC Learn more [here](https://docs.gcp.databricks.com/data-governance/unity-catalog/index.html#metastores).

-- COMMAND ----------

-- MAGIC %md # Privileges
-- MAGIC
-- MAGIC A **privilege** is a right granted to a **principal** to operate on a **securable object** in a metastore.
-- MAGIC
-- MAGIC Securable objects in Unity Catalog are hierarchical, and privileges are inherited downward.
-- MAGIC * `GRANT`ing a privilege on a catalog automatically grants the privilege to all the current and future schemas in the catalog
-- MAGIC * Privileges `GRANT`ed on a schema are inherited by all the current and future tables and views in that schema

-- COMMAND ----------

-- MAGIC %md ## Securable objects
-- MAGIC
-- MAGIC A [securable object](https://docs.databricks.com/sql/language-manual/sql-ref-privileges.html#securable-objects) is an object in a Unity Catalog metastore on which privileges can be `GRANT`ed to or `REVOKE`d from a principal.
-- MAGIC
-- MAGIC * `CATALOG` [ catalog_name ]
-- MAGIC * `EXTERNAL LOCATION` location_name (Delta Sharing)
-- MAGIC * `FUNCTION` function_name
-- MAGIC * `METASTORE`
-- MAGIC * `SHARE` share_name (Delta Sharing)
-- MAGIC * `SCHEMA` schema_name (also `DATABASE`)
-- MAGIC * `STORAGE CREDENTIAL` credential_name
-- MAGIC * [ `TABLE` ] table_name
-- MAGIC * `VIEW` view_name

-- COMMAND ----------

-- MAGIC %md ## Principals
-- MAGIC
-- MAGIC [Principals](https://docs.databricks.com/sql/language-manual/sql-ref-principal.html):
-- MAGIC
-- MAGIC * Users
-- MAGIC * Service principals
-- MAGIC * Groups
-- MAGIC
-- MAGIC Principals can be `GRANT`ed or `REVOKE`d privileges and may own (be the owner of) securable objects.
-- MAGIC
-- MAGIC * `<user>@<domain-name>` (an individual user back-ticked due to `@`)
-- MAGIC * `<sp-application-id>` (a service principal back-ticked due to `-`s)
-- MAGIC * group_name
-- MAGIC * `USERS` (all users in a workspace)
-- MAGIC * `ACCOUNT USERS` (all users in an account)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC # Information schema
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

-- MAGIC %md # SQL DCLs
-- MAGIC
-- MAGIC DCL commands are used to enforce metastore security. There are two types of DCL commands:
-- MAGIC
-- MAGIC * [GRANT](https://docs.databricks.com/sql/language-manual/security-grant.html)
-- MAGIC * [REVOKE](https://docs.databricks.com/sql/language-manual/security-revoke.html)

-- COMMAND ----------

-- MAGIC %md ## GRANT
-- MAGIC
-- MAGIC [GRANT](https://docs.databricks.com/sql/language-manual/security-grant.html)

-- COMMAND ----------

-- MAGIC %md ## REVOKE
-- MAGIC
-- MAGIC [REVOKE](https://docs.databricks.com/sql/language-manual/security-revoke.html)
-- MAGIC
-- MAGIC ```sql
-- MAGIC REVOKE privilege_types
-- MAGIC ON securable_object
-- MAGIC FROM principal
-- MAGIC ```
-- MAGIC
-- MAGIC where `privilege_types` are:
-- MAGIC
-- MAGIC * `ALL PRIVILEGES`
-- MAGIC * Comma-separated privilege types

-- COMMAND ----------

-- MAGIC %md ## SHOW GRANTS
-- MAGIC
-- MAGIC [SHOW GRANTS](https://docs.databricks.com/sql/language-manual/security-show-grant.html)
-- MAGIC
-- MAGIC * Not really a DCL but important to mention while discussing ACLs
-- MAGIC
-- MAGIC ```sql
-- MAGIC SHOW GRANTS [ principal ] ON securable_object
-- MAGIC ```

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

-- MAGIC %md ## CREATE TABLE
-- MAGIC
-- MAGIC DDLs:
-- MAGIC
-- MAGIC * [CREATE TABLE](https://docs.databricks.com/sql/language-manual/sql-ref-syntax-ddl-create-table.html)
-- MAGIC * [CREATE TABLE [USING]](https://docs.databricks.com/sql/language-manual/sql-ref-syntax-ddl-create-table-using.html)

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS t1
AS SELECT * FROM VALUES (0, 'zero'), (1, 'one') t(id, name)
