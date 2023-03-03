-- Databricks notebook source
-- MAGIC %md # Delta Live Tables CLI

-- COMMAND ----------

-- MAGIC %md ## Databricks CLI
-- MAGIC 
-- MAGIC [Databricks CLI setup & documentation](https://docs.databricks.com/dev-tools/cli/index.html):
-- MAGIC 
-- MAGIC 1. Databricks CLI is an interface to [Databricks REST API](https://docs.databricks.com/dev-tools/api/index.html)
-- MAGIC 1. An **open source project** hosted on [GitHub](https://github.com/databricks/databricks-cli)
-- MAGIC 1. Under active development and is released as an `Experimental` client. 
-- MAGIC 1. **Command groups** based on primary endpoints

-- COMMAND ----------

-- MAGIC %md ## Installation
-- MAGIC 
-- MAGIC [Installation](https://github.com/databricks/databricks-cli) (Gitbub):
-- MAGIC 
-- MAGIC * `pip install --upgrade databricks-cli`
-- MAGIC * Set up authentication using username/password or [authentication token](https://docs.databricks.com/dev-tools/api/latest/authentication.html#token-management). Credentials are stored at `~/.databrickscfg`
-- MAGIC 
-- MAGIC [Databricks CLI setup & documentation](https://docs.databricks.com/dev-tools/cli/index.html)

-- COMMAND ----------

-- MAGIC %md ## Demo: Using Databricks CLI

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ### Create Conda Environment
-- MAGIC 
-- MAGIC [Creating an environment with commands](https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#creating-an-environment-with-commands)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ``` console
-- MAGIC $ conda create --name databricks python=3.11
-- MAGIC Collecting package metadata (current_repodata.json): done
-- MAGIC Solving environment: failed with repodata from current_repodata.json, will retry with next repodata source.
-- MAGIC Collecting package metadata (repodata.json): done
-- MAGIC Solving environment: done
-- MAGIC 
-- MAGIC ## Package Plan ##
-- MAGIC 
-- MAGIC   environment location: /usr/local/Caskroom/miniconda/base/envs/databricks
-- MAGIC 
-- MAGIC   added / updated specs:
-- MAGIC     - python=3.11
-- MAGIC 
-- MAGIC 
-- MAGIC The following NEW packages will be INSTALLED:
-- MAGIC 
-- MAGIC   bzip2              pkgs/main/osx-64::bzip2-1.0.8-h1de35cc_0
-- MAGIC   ca-certificates    pkgs/main/osx-64::ca-certificates-2023.01.10-hecd8cb5_0
-- MAGIC   certifi            pkgs/main/osx-64::certifi-2022.9.24-py311hecd8cb5_0
-- MAGIC   libffi             pkgs/main/osx-64::libffi-3.4.2-hecd8cb5_6
-- MAGIC   ncurses            pkgs/main/osx-64::ncurses-6.4-hcec6c5f_0
-- MAGIC   openssl            pkgs/main/osx-64::openssl-1.1.1t-hca72f7f_0
-- MAGIC   pip                pkgs/main/osx-64::pip-22.2.2-py311hecd8cb5_0
-- MAGIC   python             pkgs/main/osx-64::python-3.11.0-h1fd4e5f_3
-- MAGIC   readline           pkgs/main/osx-64::readline-8.2-hca72f7f_0
-- MAGIC   setuptools         pkgs/main/osx-64::setuptools-65.5.0-py311hecd8cb5_0
-- MAGIC   sqlite             pkgs/main/osx-64::sqlite-3.40.1-h880c91c_0
-- MAGIC   tk                 pkgs/main/osx-64::tk-8.6.12-h5d9f67b_0
-- MAGIC   tzdata             pkgs/main/noarch::tzdata-2022g-h04d1e81_0
-- MAGIC   wheel              pkgs/main/noarch::wheel-0.37.1-pyhd3eb1b0_0
-- MAGIC   xz                 pkgs/main/osx-64::xz-5.2.10-h6c40b1e_1
-- MAGIC   zlib               pkgs/main/osx-64::zlib-1.2.13-h4dc903c_0
-- MAGIC 
-- MAGIC 
-- MAGIC Proceed ([y]/n)? y
-- MAGIC 
-- MAGIC 
-- MAGIC Downloading and Extracting Packages
-- MAGIC 
-- MAGIC Preparing transaction: done
-- MAGIC Verifying transaction: done
-- MAGIC Executing transaction: done
-- MAGIC #
-- MAGIC # To activate this environment, use
-- MAGIC #
-- MAGIC #     $ conda activate databricks
-- MAGIC #
-- MAGIC # To deactivate an active environment, use
-- MAGIC #
-- MAGIC #     $ conda deactivate
-- MAGIC ```
-- MAGIC 
-- MAGIC ``` console
-- MAGIC $ conda activate databricks
-- MAGIC ```
-- MAGIC 
-- MAGIC ```console
-- MAGIC $ python --version
-- MAGIC Python 3.11.0
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ### Install Databricks CLI
-- MAGIC 
-- MAGIC [conda-forge / packages / databricks-cli](https://anaconda.org/conda-forge/databricks-cli)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ```console
-- MAGIC $ conda install -c conda-forge databricks-cli                                                                                                                                         1 ↵
-- MAGIC Collecting package metadata (current_repodata.json): done
-- MAGIC Solving environment: done
-- MAGIC 
-- MAGIC ## Package Plan ##
-- MAGIC 
-- MAGIC   environment location: /usr/local/Caskroom/miniconda/base/envs/databricks
-- MAGIC 
-- MAGIC   added / updated specs:
-- MAGIC     - databricks-cli
-- MAGIC 
-- MAGIC 
-- MAGIC The following packages will be downloaded:
-- MAGIC 
-- MAGIC     package                    |            build
-- MAGIC     ---------------------------|-----------------
-- MAGIC     blinker-1.5                |     pyhd8ed1ab_0          15 KB  conda-forge
-- MAGIC     configparser-5.3.0         |     pyhd8ed1ab_0          22 KB  conda-forge
-- MAGIC     cryptography-38.0.4        |  py311h8661239_0         1.1 MB  conda-forge
-- MAGIC     databricks-cli-0.17.4      |     pyhd8ed1ab_0          84 KB  conda-forge
-- MAGIC     oauthlib-3.2.2             |     pyhd8ed1ab_0          90 KB  conda-forge
-- MAGIC     openssl-1.1.1t             |       hfd90126_0         1.7 MB  conda-forge
-- MAGIC     pyjwt-2.6.0                |     pyhd8ed1ab_0          21 KB  conda-forge
-- MAGIC     python_abi-3.11            |          2_cp311           5 KB  conda-forge
-- MAGIC     tabulate-0.9.0             |     pyhd8ed1ab_1          35 KB  conda-forge
-- MAGIC     ------------------------------------------------------------
-- MAGIC                                            Total:         3.0 MB
-- MAGIC 
-- MAGIC The following NEW packages will be INSTALLED:
-- MAGIC 
-- MAGIC   blinker            conda-forge/noarch::blinker-1.5-pyhd8ed1ab_0
-- MAGIC   brotlipy           conda-forge/osx-64::brotlipy-0.7.0-py311h5547dcb_1005
-- MAGIC   cffi               conda-forge/osx-64::cffi-1.15.1-py311ha86e640_3
-- MAGIC   charset-normalizer conda-forge/noarch::charset-normalizer-2.1.1-pyhd8ed1ab_0
-- MAGIC   click              conda-forge/noarch::click-8.1.3-unix_pyhd8ed1ab_2
-- MAGIC   configparser       conda-forge/noarch::configparser-5.3.0-pyhd8ed1ab_0
-- MAGIC   cryptography       conda-forge/osx-64::cryptography-38.0.4-py311h8661239_0
-- MAGIC   databricks-cli     conda-forge/noarch::databricks-cli-0.17.4-pyhd8ed1ab_0
-- MAGIC   idna               conda-forge/noarch::idna-3.4-pyhd8ed1ab_0
-- MAGIC   oauthlib           conda-forge/noarch::oauthlib-3.2.2-pyhd8ed1ab_0
-- MAGIC   pycparser          conda-forge/noarch::pycparser-2.21-pyhd8ed1ab_0
-- MAGIC   pyjwt              conda-forge/noarch::pyjwt-2.6.0-pyhd8ed1ab_0
-- MAGIC   pyopenssl          conda-forge/noarch::pyopenssl-23.0.0-pyhd8ed1ab_0
-- MAGIC   pysocks            conda-forge/noarch::pysocks-1.7.1-pyha2e5f31_6
-- MAGIC   python_abi         conda-forge/osx-64::python_abi-3.11-2_cp311
-- MAGIC   requests           conda-forge/noarch::requests-2.28.2-pyhd8ed1ab_0
-- MAGIC   six                conda-forge/noarch::six-1.16.0-pyh6c4a22f_0
-- MAGIC   tabulate           conda-forge/noarch::tabulate-0.9.0-pyhd8ed1ab_1
-- MAGIC   urllib3            conda-forge/noarch::urllib3-1.26.14-pyhd8ed1ab_0
-- MAGIC 
-- MAGIC The following packages will be UPDATED:
-- MAGIC 
-- MAGIC   certifi            pkgs/main/osx-64::certifi-2022.9.24-p~ --> conda-forge/noarch::certifi-2022.12.7-pyhd8ed1ab_0
-- MAGIC 
-- MAGIC The following packages will be SUPERSEDED by a higher-priority channel:
-- MAGIC 
-- MAGIC   ca-certificates    pkgs/main::ca-certificates-2023.01.10~ --> conda-forge::ca-certificates-2022.12.7-h033912b_0
-- MAGIC   openssl              pkgs/main::openssl-1.1.1t-hca72f7f_0 --> conda-forge::openssl-1.1.1t-hfd90126_0
-- MAGIC 
-- MAGIC 
-- MAGIC Proceed ([y]/n)? y
-- MAGIC 
-- MAGIC 
-- MAGIC Downloading and Extracting Packages
-- MAGIC 
-- MAGIC Preparing transaction: done
-- MAGIC Verifying transaction: done
-- MAGIC Executing transaction: done
-- MAGIC ```
-- MAGIC 
-- MAGIC ```shell
-- MAGIC $ databricks --version
-- MAGIC Version 0.17.4
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ### Generate Personal Access Token
-- MAGIC 
-- MAGIC 1. [Generate Personal Access Token (PAT)](https://docs.databricks.com/dev-tools/api/latest/authentication.html#token-management)
-- MAGIC 1. [Personal access tokens for users](https://docs.databricks.com/dev-tools/auth.html#personal-access-tokens-for-users)
-- MAGIC 1. [Authentication using Databricks personal access tokens](https://docs.databricks.com/dev-tools/api/latest/authentication.html)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ### (optional) Using Username and Password
-- MAGIC 
-- MAGIC ```console
-- MAGIC $ databricks configure
-- MAGIC Databricks Host (should begin with https://): https://xxx.cloud.databricks.com/
-- MAGIC Username: jacek@japila.pl
-- MAGIC Password:
-- MAGIC Repeat for confirmation:
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC To test that your authentication information is working, try a quick test like `databricks workspace ls`.
-- MAGIC 
-- MAGIC ```console
-- MAGIC $ databricks workspace ls
-- MAGIC Users
-- MAGIC Shared
-- MAGIC Repos
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md ### databrickscfg
-- MAGIC 
-- MAGIC Credentials are stored at `~/.databrickscfg`.

-- COMMAND ----------

-- MAGIC %md ## Delta Live Tables CLI
-- MAGIC 
-- MAGIC [CLI commands](https://docs.databricks.com/dev-tools/cli/index.html#cli-commands) with [Delta Live Tables CLI](https://docs.databricks.com/dev-tools/cli/dlt-cli.html):
-- MAGIC * `databricks pipelines`
-- MAGIC * [Delta Live Tables API guide](https://docs.databricks.com/workflows/delta-live-tables/delta-live-tables-api-guide.html)

-- COMMAND ----------

-- MAGIC %md ### List all pipelines
-- MAGIC 
-- MAGIC [List all pipelines and information on their status](https://docs.databricks.com/dev-tools/cli/dlt-cli.html#list-all-pipelines-and-information-on-their-status)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ```shell
-- MAGIC $ databricks pipelines list --help
-- MAGIC Usage: databricks pipelines list [OPTIONS]
-- MAGIC 
-- MAGIC   Lists all pipelines and their statuses.
-- MAGIC 
-- MAGIC   Usage:
-- MAGIC 
-- MAGIC   databricks pipelines list
-- MAGIC 
-- MAGIC Options:
-- MAGIC   --debug         Debug Mode. Shows full stack trace on error.
-- MAGIC   --profile TEXT  CLI connection profile to use. The default profile is
-- MAGIC                   "DEFAULT".
-- MAGIC   -h, --help      Show this message and exit.
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ```shell
-- MAGIC $ databricks pipelines list | jq '.[].name'                                                                                                                                           5 ↵
-- MAGIC "DLT Pipeline with SQL (meetup)"
-- MAGIC "DLT-Demo-81-jacek@japila.pl"
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ```shell
-- MAGIC $ databricks pipelines list | jq '.[] | {name, pipeline_id}'
-- MAGIC {
-- MAGIC   "name": "DLT Pipeline with SQL (meetup)",
-- MAGIC   "pipeline_id": "960da65b-c9df-4cb9-9456-1005ffe103a9"
-- MAGIC }
-- MAGIC {
-- MAGIC   "name": "DLT-Demo-81-jacek@japila.pl",
-- MAGIC   "pipeline_id": "d9fd0bed-5eb8-4341-ac3b-5aec55a081b3"
-- MAGIC }
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md ### Get information about a pipeline
-- MAGIC 
-- MAGIC [Get information about a pipeline](https://docs.databricks.com/dev-tools/cli/dlt-cli.html#get-information-about-a-pipeline)
-- MAGIC 
-- MAGIC ```shell
-- MAGIC $ databricks pipelines get --pipeline-id 960da65b-c9df-4cb9-9456-1005ffe103a9
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md ### Edit a pipeline
-- MAGIC 
-- MAGIC [Edit a pipeline](https://docs.databricks.com/dev-tools/cli/dlt-cli.html#edit-a-pipeline)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ```
-- MAGIC $ databricks pipelines edit --help
-- MAGIC Usage: databricks pipelines edit [OPTIONS] [SETTINGS_ARG]
-- MAGIC 
-- MAGIC   Edits a pipeline specified by the pipeline settings. The pipeline settings
-- MAGIC   are a JSON document that defines a Delta Live Tables pipeline on Databricks.
-- MAGIC   To use a file containing the pipeline settings, pass the file path to the
-- MAGIC   command as an argument or with the --settings option.
-- MAGIC 
-- MAGIC   Specification for the pipeline settings JSON can be found at
-- MAGIC   https://docs.databricks.com/data-engineering/delta-live-tables/delta-live-
-- MAGIC   tables-configuration.html
-- MAGIC 
-- MAGIC   If another pipeline with the same name exists, pipeline settings will not be
-- MAGIC   edited. This check can be disabled by adding the --allow-duplicate-names
-- MAGIC   option.
-- MAGIC 
-- MAGIC   Note that if an ID is specified in both the settings and passed with the
-- MAGIC   --pipeline-id argument, the two ids must be the same, or the command will
-- MAGIC   fail.
-- MAGIC 
-- MAGIC   Usage:
-- MAGIC 
-- MAGIC   databricks pipelines edit example.json
-- MAGIC 
-- MAGIC   OR
-- MAGIC 
-- MAGIC   databricks pipelines edit --settings example.json
-- MAGIC 
-- MAGIC Options:
-- MAGIC   --settings SETTINGS        The path to the pipelines settings file.
-- MAGIC   --pipeline-id PIPELINE_ID  The pipeline ID.
-- MAGIC   --allow-duplicate-names    Skip duplicate name check while editing pipeline.
-- MAGIC   --debug                    Debug Mode. Shows full stack trace on error.
-- MAGIC   --profile TEXT             CLI connection profile to use. The default
-- MAGIC                              profile is "DEFAULT".
-- MAGIC   -h, --help                 Show this message and exit.
-- MAGIC   ```

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC [Delta Live Tables settings](https://docs.databricks.com/workflows/delta-live-tables/delta-live-tables-configuration.html), esp. [Parameterize pipelines](https://docs.databricks.com/workflows/delta-live-tables/delta-live-tables-configuration.html#parameterize-pipelines)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC 
-- MAGIC 
-- MAGIC ```text
-- MAGIC databricks pipelines edit --settings edit-pipeline.json
-- MAGIC ```
