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

# MAGIC %md
# MAGIC
# MAGIC ## ⛔️ Heads-Up
# MAGIC
# MAGIC It's worth pointing out [this issue](https://github.com/langchain-ai/langchain/issues/2079#issuecomment-1487416187) that can lead to some issues if the project uses the same name as the name of the dependency you want to use in the project.
# MAGIC
# MAGIC > 'langchain' is not a package

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Review Me
# MAGIC
# MAGIC > **CAUTION**:
# MAGIC > 
# MAGIC > This cell is subject to many outdated content and very likely outdated in its entirety.
# MAGIC
# MAGIC ---
# MAGIC
# MAGIC ```shell
# MAGIC $ sandbox && mkdir langchain-demo && cd langchain-demo
# MAGIC ```
# MAGIC
# MAGIC > **Note**
# MAGIC >
# MAGIC > At this point, it's worth creating `.env` file in the directory so it is sourced every time you switch to it (using [autoenv](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/autoenv) plugin) and activate the conda environment.
# MAGIC
# MAGIC **UPDATE** (7/15): langchain development cycle is quite fast (with releases every couple of days) and conda-forge is outdated.
# MAGIC
# MAGIC ```shell
# MAGIC $ pip install https://github.com/hwchase17/langchain/releases/download/v0.0.234/langchain-0.0.234-py3-none-any.whl
# MAGIC ...
# MAGIC Installing collected packages: langchain
# MAGIC   Attempting uninstall: langchain
# MAGIC     Found existing installation: langchain 0.0.233
# MAGIC     Uninstalling langchain-0.0.233:
# MAGIC       Successfully uninstalled langchain-0.0.233
# MAGIC Successfully installed langchain-0.0.234
# MAGIC ```
# MAGIC
# MAGIC ---
# MAGIC
# MAGIC (Don't use `pip install 'langchain[all]'` as it downgrades langchain)
# MAGIC
# MAGIC ```console
# MAGIC $ pip install 'langchain[all]'
# MAGIC ...
# MAGIC Successfully installed MarkupSafe-2.1.3 SQLAlchemy-1.4.49 beautifulsoup4-4.12.2 blis-0.7.9 catalogue-2.0.8 click-8.1.5 confection-0.1.0 cymem-2.0.7 dill-0.3.6 elastic-transport-8.4.0 elasticsearch-8.8.2 faiss-cpu-1.7.4 filelock-3.12.2 fsspec-2023.6.0 huggingface_hub-0.16.4 jinja2-3.1.2 joblib-1.3.1 langchain-0.0.39 langcodes-3.3.0 manifest-ml-0.0.1 murmurhash-1.0.9 nltk-3.8.1 pathy-0.10.2 preshed-3.0.8 redis-4.6.0 regex-2023.6.3 safetensors-0.3.1 smart-open-6.3.0 soupsieve-2.4.1 spacy-3.6.0 spacy-legacy-3.0.12 spacy-loggers-1.0.4 sqlitedict-2.1.0 srsly-2.4.6 thinc-8.1.10 tiktoken-0.4.0 tokenizers-0.13.3 transformers-4.30.2 typer-0.9.0 urllib3-1.26.16 wasabi-1.1.2 wikipedia-1.4.0
# MAGIC ```
# MAGIC
# MAGIC > **Note**
# MAGIC >
# MAGIC > FIXME `langchain-0.0.39`?! The latest is [0.0.190](https://anaconda.org/conda-forge/langchain) (!)
# MAGIC
# MAGIC ---
# MAGIC
# MAGIC ```console
# MAGIC $ pip list | grep langchain
# MAGIC langchain               0.0.234
# MAGIC ```
# MAGIC
# MAGIC The above does not seem to work either! 😢
# MAGIC
# MAGIC ```shell
# MAGIC $ pip show langchain
# MAGIC Name: langchain
# MAGIC Version: 0.0.234
# MAGIC Summary: Building applications with LLMs through composability
# MAGIC Home-page: https://www.github.com/hwchase17/langchain
# MAGIC Author:
# MAGIC Author-email:
# MAGIC License: MIT
# MAGIC Location: /usr/local/Caskroom/miniconda/base/envs/langchain/lib/python3.11/site-packages
# MAGIC Requires: aiohttp, dataclasses-json, langsmith, numexpr, numpy, openapi-schema-pydantic, pydantic, PyYAML, requests, SQLAlchemy, tenacity
# MAGIC Required-by:
# MAGIC ```
# MAGIC
# MAGIC ### openai
# MAGIC
# MAGIC ```console
# MAGIC $ conda install -c conda-forge -n langchain --yes openai
# MAGIC ```
# MAGIC
# MAGIC ```console
# MAGIC $ pip show openai
# MAGIC Name: openai
# MAGIC Version: 0.27.8
# MAGIC Summary: Python client library for the OpenAI API
# MAGIC Home-page: https://github.com/openai/openai-python
# MAGIC Author: OpenAI
# MAGIC Author-email: support@openai.com
# MAGIC License:
# MAGIC Location: /usr/local/Caskroom/miniconda/base/envs/langchain/lib/python3.11/site-packages
# MAGIC Requires: aiohttp, requests, tqdm
# MAGIC Required-by:
# MAGIC ```
# MAGIC
# MAGIC ### Install From Github
# MAGIC
# MAGIC ```console
# MAGIC $ pip install https://github.com/hwchase17/langchain/releases/download/v0.0.233/langchain-0.0.233-py3-none-any.whl
# MAGIC ...
# MAGIC Installing collected packages: langsmith, langchain
# MAGIC   Attempting uninstall: langchain
# MAGIC     Found existing installation: langchain 0.0.190
# MAGIC     Uninstalling langchain-0.0.190:
# MAGIC       Successfully uninstalled langchain-0.0.190
# MAGIC Successfully installed langchain-0.0.39 langsmith-0.0.5
# MAGIC ```
# MAGIC
# MAGIC ```console
# MAGIC $ pip show langchain
# MAGIC Name: langchain
# MAGIC Version: 0.0.39
# MAGIC Summary: Building applications with LLMs through composability
# MAGIC Home-page: https://www.github.com/hwchase17/langchain
# MAGIC Author:
# MAGIC Author-email:
# MAGIC License: MIT
# MAGIC Location: /usr/local/Caskroom/miniconda/base/envs/langchain/lib/python3.11/site-packages
# MAGIC Requires: numpy, pydantic, PyYAML, requests, SQLAlchemy
# MAGIC Required-by:
# MAGIC ```
# MAGIC
# MAGIC **Version: 0.0.39** What?!

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC # Quickstart
# MAGIC
# MAGIC [Quickstart](https://python.langchain.com/docs/get_started/quickstart)
# MAGIC
# MAGIC * Uses OpenAI

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC [What is the difference between %sh pip, !pip, or pip?](https://docs.databricks.com/en/libraries/notebooks-python-libraries.html#can-i-use-sh-pip-pip-or-pip-what-is-the-difference)

# COMMAND ----------

import sys
print(sys.version)

# COMMAND ----------

!python --version

# COMMAND ----------

# MAGIC %pip install --force-reinstall langchain==0.1.9
# MAGIC
# MAGIC dbutils.library.restartPython()

# COMMAND ----------

# MAGIC %sh pip list | grep -i langchain

# COMMAND ----------

import langchain

# langchain.verbose = False
# langchain.debug = False

print("Running langchain version:", langchain.__version__)

# COMMAND ----------

# MAGIC %pip install --force-reinstall langchain-openai==0.0.7
# MAGIC
# MAGIC dbutils.library.restartPython()

# COMMAND ----------

# MAGIC %sh pip list | grep -i openai

# COMMAND ----------

# MAGIC %sh pip list | grep typing_extensions

# COMMAND ----------

from importlib.metadata import version

print(version("typing_extensions"))

# COMMAND ----------

import sys

sys.path

# COMMAND ----------

# MAGIC %sh ls /usr/local/lib/python3.10/dist-packages

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
