# Databricks notebook source
# MAGIC %md # LangChain
# MAGIC
# MAGIC [LangChain](https://python.langchain.com) is a framework for developing applications powered by language models (LLMs) through composability.
# MAGIC Using LangChain will usually require integrations with one or more model providers, data stores, APIs, etc.

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC # Installation
# MAGIC
# MAGIC [Installation](https://python.langchain.com/docs/get_started/installation.html)

# COMMAND ----------

import sys
print(sys.version)

# COMMAND ----------

!python --version

# COMMAND ----------

import langchain

# langchain.verbose = False
# langchain.debug = False

print("Running langchain version:", langchain.__version__)

# COMMAND ----------

from importlib.metadata import version

print(version("typing_extensions"))

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## OPENAI_API_KEY and Databricks Secrets

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ### Secret scopes
# MAGIC
# MAGIC [Secret scopes](https://docs.databricks.com/en/security/secrets/secret-scopes.html):
# MAGIC
# MAGIC * Managing secrets begins with creating a secret scope.
# MAGIC * A **secret scope** is collection of secrets identified by a name.
# MAGIC * A workspace is limited to a maximum of 100 secret scopes.
# MAGIC * A Databricks-backed secret scope is stored in (backed by) an encrypted database owned and managed by Databricks
# MAGIC * Secret scope is created using the Databricks CLI or [Secrets API](https://docs.databricks.com/api/workspace/secrets)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC Instead of directly entering your credentials into a notebook, use Databricks secrets to store your credentials and reference them in notebooks and jobs.

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC You create secrets using the REST API or CLI, but you must use the Secrets utility ([dbutils.secrets](https://docs.databricks.com/en/dev-tools/databricks-utils.html#dbutils-secrets)) in a notebook or job to read a secret.

# COMMAND ----------

# MAGIC %sh ls /databricks/python3/bin

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ```sh
# MAGIC databricks auth profiles
# MAGIC ```
# MAGIC
# MAGIC [Create a Databricks-backed secret scope](https://docs.databricks.com/en/security/secrets/secret-scopes.html#create-a-databricks-backed-secret-scope)
# MAGIC
# MAGIC ```sh
# MAGIC databricks secrets list-scopes
# MAGIC ```
# MAGIC
# MAGIC ---
# MAGIC
# MAGIC ```sh
# MAGIC databricks secrets create-scope langchain_jaceklaskowski
# MAGIC ```
# MAGIC
# MAGIC [View secret ACLs](https://docs.databricks.com/en/security/auth-authz/access-control/secret-acl.html#view-secret-acls)
# MAGIC
# MAGIC ```sh
# MAGIC $ databricks secrets list-acls langchain_jaceklaskowski
# MAGIC [
# MAGIC   {
# MAGIC     "permission":"MANAGE",
# MAGIC     "principal":"jacek@japila.pl"
# MAGIC   }
# MAGIC ]
# MAGIC ```
# MAGIC
# MAGIC ---
# MAGIC
# MAGIC ```sh
# MAGIC databricks secrets delete-scope langchain_jaceklaskowski
# MAGIC ```

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ### Secrets
# MAGIC
# MAGIC [Secrets](https://docs.databricks.com/en/security/secrets/secrets.html):
# MAGIC
# MAGIC * A **secret** is a key-value pair that stores secret material, with a key name unique within a secret scope.
# MAGIC * Each scope is limited to 1000 secrets.
# MAGIC * The maximum allowed secret value size is 128 KB.

# COMMAND ----------

dbutils.secrets.listScopes()

# COMMAND ----------

dbutils.secrets.list('langchain_jaceklaskowski')

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ```console
# MAGIC $ databricks secrets --help
# MAGIC The Secrets API allows you to manage secrets, secret scopes, and access
# MAGIC   permissions.
# MAGIC
# MAGIC   Sometimes accessing data requires that you authenticate to external data
# MAGIC   sources through JDBC. Instead of directly entering your credentials into a
# MAGIC   notebook, use Databricks secrets to store your credentials and reference them
# MAGIC   in notebooks and jobs.
# MAGIC
# MAGIC   Administrators, secret creators, and users granted permission can read
# MAGIC   Databricks secrets. While Databricks makes an effort to redact secret values
# MAGIC   that might be displayed in notebooks, it is not possible to prevent such users
# MAGIC   from reading secrets.
# MAGIC
# MAGIC Usage:
# MAGIC   databricks secrets [command]
# MAGIC
# MAGIC Available Commands
# MAGIC   create-scope  Create a new secret scope.
# MAGIC   delete-acl    Delete an ACL.
# MAGIC   delete-scope  Delete a secret scope.
# MAGIC   delete-secret Delete a secret.
# MAGIC   get-acl       Get secret ACL details.
# MAGIC   get-secret    Get a secret.
# MAGIC   list-acls     Lists ACLs.
# MAGIC   list-scopes   List all scopes.
# MAGIC   list-secrets  List secret keys.
# MAGIC   put-acl       Create/update an ACL.
# MAGIC   put-secret    Add a secret.
# MAGIC ...
# MAGIC ```

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ```console
# MAGIC $ databricks secrets put-secret --help
# MAGIC Add a secret.
# MAGIC
# MAGIC   Inserts a secret under the provided scope with the given name. If a secret
# MAGIC   already exists with the same name, this command overwrites the existing
# MAGIC   secret's value. The server encrypts the secret using the secret scope's
# MAGIC   encryption settings before storing it.
# MAGIC
# MAGIC   You must have WRITE or MANAGE permission on the secret scope. The secret
# MAGIC   key must consist of alphanumeric characters, dashes, underscores, and periods,
# MAGIC   and cannot exceed 128 characters. The maximum allowed secret value size is 128
# MAGIC   KB. The maximum number of secrets in a given scope is 1000.
# MAGIC
# MAGIC   The arguments "string-value" or "bytes-value" specify the type of the secret,
# MAGIC   which will determine the value returned when the secret value is requested.
# MAGIC
# MAGIC   You can specify the secret value in one of three ways:
# MAGIC   * Specify the value as a string using the --string-value flag.
# MAGIC   * Input the secret when prompted interactively (single-line secrets).
# MAGIC   * Pass the secret via standard input (multi-line secrets).
# MAGIC
# MAGIC Usage:
# MAGIC   databricks secrets put-secret SCOPE KEY [flags]
# MAGIC ...
# MAGIC ```

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ```text
# MAGIC --json JSON
# MAGIC     either inline JSON string or @path/to/file.json with request body (default JSON (0 bytes))
# MAGIC ```

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC openai_token.json
# MAGIC
# MAGIC ```console
# MAGIC {
# MAGIC   "scope": "langchain_jaceklaskowski",
# MAGIC   "key": "openai_token",
# MAGIC   "string_value": "sk-FIXME"
# MAGIC }
# MAGIC ```

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ```console
# MAGIC databricks secrets put-secret --json @openai_token.json
# MAGIC ```

# COMMAND ----------

dbutils.secrets.list('langchain_jaceklaskowski')

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## The Code

# COMMAND ----------

# DBTITLE 1,dbutils.secrets.get
OPENAI_API_KEY = dbutils.secrets.get(scope = "langchain_jaceklaskowski", key = "openai_token")

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ### BaseChatModel
# MAGIC
# MAGIC * Base class for Chat models
# MAGIC     * `openai-chat` = type of chat model
# MAGIC * `Callbacks` to add to the run trace
# MAGIC     * `tags`
# MAGIC     * `metadata`
# MAGIC * Examples: Pure text completion models vs chat models

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ### ChatOpenAI
# MAGIC
# MAGIC * There are two, one is deprecated
# MAGIC
# MAGIC _More in a separate cell below with the same title_

# COMMAND ----------

# DBTITLE 1,ChatOpenAI
from langchain_openai import ChatOpenAI

# Use `OPENAI_API_KEY` env var or `openai_api_key` named parameter
# llm = ChatOpenAI(openai_api_key='fixme')
# gpt-3.5-turbo is the default model
# gpt-4
# cl100k_base
llm = ChatOpenAI(model_name="gpt-4", openai_api_key=OPENAI_API_KEY)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC Uses a user-specified `client` if provided or defaults to `openai.OpenAI(**client_params).chat.completions`

# COMMAND ----------

llm.client

# COMMAND ----------

# Whether to print out response text
llm.verbose

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ### Prompt
# MAGIC
# MAGIC * `LanguageModelInput`
# MAGIC     * `BaseChatModel.invoke(input: LanguageModelInput)`

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ### PromptValue
# MAGIC
# MAGIC * `prompts: List[PromptValue]` (in `BaseChatModel.generate_prompt`)
# MAGIC * inputs to any language model
# MAGIC * can be converted to both LLM (pure text-generation) inputs and `ChatModel` inputs

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC Pass a sequence of prompts to a model and return model generations
# MAGIC
# MAGIC Batched calls for models that expose a batched API

# COMMAND ----------

# DBTITLE 1,LLM.invoke
prompt = 'What is Databricks good at?'
answer = llm.invoke(prompt)
print(answer.content)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ### Clean Up

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC `databricks secrets delete-scope langchain_jaceklaskowski`

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC # ChatOpenAI
# MAGIC
# MAGIC * `ChatOpenAI` is a chat LLM model
# MAGIC     * `class ChatOpenAI(BaseChatModel)`
# MAGIC * Uses `OPENAI_API_KEY` environment variable with your API key (secret token)
# MAGIC * `langchain-openai` is the LangChain x OpenAI integration package
# MAGIC     * [The OpenAI Python API library](https://github.com/openai/openai-python)
# MAGIC * Uses `client` if defined or defaults to `openai.OpenAI(**client_params).chat.completions`
# MAGIC     * could be async
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ### OpenAPI
# MAGIC
# MAGIC #### Completions
# MAGIC
# MAGIC In `Completions` found the following [models](https://github.com/openai/openai-python/blob/7a0cfb9acf136f62ec2b3edda9d8c607cf9dd5ea/src/openai/resources/chat/completions.py#L46-L67):
# MAGIC
# MAGIC * "gpt-4-0125-preview"
# MAGIC * "gpt-4-turbo-preview"
# MAGIC * "gpt-4-1106-preview"
# MAGIC * "gpt-4-vision-preview"
# MAGIC * "gpt-4"
# MAGIC * "gpt-4-0314"
# MAGIC * "gpt-4-0613"
# MAGIC * "gpt-4-32k"
# MAGIC * "gpt-4-32k-0314"
# MAGIC * "gpt-4-32k-0613"
# MAGIC * "gpt-3.5-turbo"
# MAGIC * "gpt-3.5-turbo-16k"
# MAGIC * "gpt-3.5-turbo-0301"
# MAGIC * "gpt-3.5-turbo-0613"
# MAGIC * "gpt-3.5-turbo-1106"
# MAGIC * "gpt-3.5-turbo-0125"
# MAGIC * "gpt-3.5-turbo-16k-0613"
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## (Sampling) Temperature
# MAGIC
# MAGIC What's this?
# MAGIC
# MAGIC Default: `0.7`

# COMMAND ----------

llm.temperature

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Attributes
# MAGIC
# MAGIC Found in `ChatOpenAI` class. What are they used for?
# MAGIC
# MAGIC * `openai_organization`
# MAGIC * `openai_api_base`
# MAGIC * `openai_proxy`
# MAGIC

# COMMAND ----------

# DBTITLE 1,🚧 Work in progress
# llm.client.create(messages=iter(['aaa']), model='gpt-4')

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC Name | Alias | Env Var | Description
# MAGIC -|-|-|-
# MAGIC openai_api_key | api_key
# MAGIC openai_api_base | base_url | OPENAI_API_BASE | Base URL path for API requests, leave blank if not using a proxy or service emulator
# MAGIC openai_organization | organization | OPENAI_ORG_ID |
# MAGIC openai_proxy | | OPENAI_PROXY | explicit proxy for OpenAI

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Serializable Models
# MAGIC
# MAGIC * A model can be serialized by Langchain
# MAGIC * `Serializable.is_lc_serializable`
