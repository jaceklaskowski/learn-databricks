-- Databricks notebook source
-- MAGIC %md
-- MAGIC
-- MAGIC # Git Credentials

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC [Set up Databricks Git folders (Repos)](https://docs.databricks.com/en/repos/repos-setup.html):
-- MAGIC
-- MAGIC * You can clone public remote repositories without Git credentials (a personal access token and a username). 
-- MAGIC * To modify a public remote repository or to clone or modify a private remote repository, you must have a Git provider username and PAT with **Write** (or greater) permissions for the remote repository.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC Learn/explore more:
-- MAGIC
-- MAGIC * [REST API reference](https://docs.databricks.com/api/workspace/gitcredentials)
-- MAGIC * [Configure Git credentials & connect a remote repo to Databricks](https://docs.databricks.com/en/repos/get-access-tokens-from-git-provider.html)
-- MAGIC * [CI/CD techniques with Git and Databricks Git folders (Repos)](https://docs.databricks.com/en/repos/ci-cd-techniques-with-repos.html)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC `git-credentials` endpoint manages Git credentials for the calling user.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ```console
-- MAGIC $ databricks git-credentials
-- MAGIC Registers personal access token for Databricks to do operations on behalf of
-- MAGIC   the user.
-- MAGIC
-- MAGIC   See [more info].
-- MAGIC
-- MAGIC   [more info]: https://docs.databricks.com/repos/get-access-tokens-from-git-provider.html
-- MAGIC
-- MAGIC Usage:
-- MAGIC   databricks git-credentials [command]
-- MAGIC
-- MAGIC Available Commands
-- MAGIC   create      Create a credential entry.
-- MAGIC   delete      Delete a credential.
-- MAGIC   get         Get a credential entry.
-- MAGIC   list        Get Git credentials.
-- MAGIC   update      Update a credential.
-- MAGIC ...
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC > ⚠️ **Important!**
-- MAGIC >
-- MAGIC > **Only one** git credential per user, per workspace is supported
-- MAGIC >
-- MAGIC > * any attempts to create credentials if an entry already exists will fail
-- MAGIC > * Use the PATCH endpoint to update existing credentials, or the DELETE endpoint to delete existing credentials

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Create a credential entry
-- MAGIC
-- MAGIC [Create a credential entry](https://docs.databricks.com/api/workspace/gitcredentials/create)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ```json
-- MAGIC $ databricks git-credentials create --json @jalaskowski_github_pat.json
-- MAGIC {
-- MAGIC   "credential_id":961393256420754,
-- MAGIC   "git_provider":"gitHub",
-- MAGIC   "git_username":"jalaskowski"
-- MAGIC }
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ```json
-- MAGIC $ databricks git-credentials list
-- MAGIC [
-- MAGIC   {
-- MAGIC     "credential_id": 961393256420754,
-- MAGIC     "git_provider": "gitHub",
-- MAGIC     "git_username": "jalaskowski"
-- MAGIC   }
-- MAGIC ]
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Update
-- MAGIC
-- MAGIC [Update a credential](https://docs.databricks.com/api/workspace/gitcredentials/update)
-- MAGIC
-- MAGIC Given that the only one credential per user is supported, you should be using `databricks git-credentials update CREDENTIAL_ID` (possibly with `--json` flag) to replace the one active credential.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ```console
-- MAGIC databricks git-credentials update 961393256420754 --json @jaceklaskowski_github_pat.json
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ```json
-- MAGIC $ databricks git-credentials list
-- MAGIC [
-- MAGIC   {
-- MAGIC     "credential_id": 961393256420754,
-- MAGIC     "git_provider": "gitHub",
-- MAGIC     "git_username": "jacek@japila.pl"
-- MAGIC   }
-- MAGIC ]
-- MAGIC ```
