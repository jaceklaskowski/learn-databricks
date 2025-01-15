-- Databricks notebook source
-- MAGIC %md # Meetup 2025.01.09
-- MAGIC
-- MAGIC ➡️ [Deploying Databricks Workflows with uv and Databricks Asset Bundles](https://www.meetup.com/warsaw-data-engineering/events/305473028/)
-- MAGIC
-- MAGIC Agenda:
-- MAGIC
-- MAGIC 1. 5 minut rogrzewki na luźne pomysły na ten i przyszłe meetupy
-- MAGIC     * News (new versions, etc.)
-- MAGIC 1. 50 minut Live coding session, a w nim:
-- MAGIC     * Stworzenie projektu w Pythonie z uv
-- MAGIC     * Stworzenie Databricks job z notebookiem z naszym projektem w Pythonie wyżej (wszystko ręcznie / klikamy w UI / pełny manual)
-- MAGIC     * Automatyzacja z Databricks Asset Bundles (DAB)
-- MAGIC 1. Q&A / Zbieranie pomysłów na kolejne edycje (5 minut)

-- COMMAND ----------

-- MAGIC %md # News

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## New Versions
-- MAGIC
-- MAGIC * [uv 0.5.16](https://github.com/astral-sh/uv/releases/tag/0.5.16)
-- MAGIC * [Databricks CLI 0.238.0](https://github.com/databricks/cli/releases/tag/v0.238.0)
-- MAGIC * [Delta Lake 3.3.0](https://github.com/delta-io/delta/releases/tag/v3.3.0)
-- MAGIC * [awscli 2.22.31](https://github.com/aws/aws-cli/releases/tag/2.22.31)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Open focus mode
-- MAGIC
-- MAGIC [Databricks notebook interface and controls](https://docs.databricks.com/en/notebooks/notebook-ui.html)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC # Live Coding Session

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Create DAB
-- MAGIC
-- MAGIC `databricks bundle init`
-- MAGIC
-- MAGIC * `demo/uv_workflows`
-- MAGIC * Based on `default-python` template
-- MAGIC
-- MAGIC IDEA: Create a new template with `uv` (based on `default-python` template). Sounds interesting? Anyone?
-- MAGIC
-- MAGIC Review:
-- MAGIC 1. `databricks.yml`

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Deploy DAB
-- MAGIC
-- MAGIC `databricks bundle deploy`
-- MAGIC
-- MAGIC While deploying the bundle...
-- MAGIC
-- MAGIC ---
-- MAGIC
-- MAGIC ```
-- MAGIC ❯ databricks bundle deploy
-- MAGIC Building uv_workflows...
-- MAGIC Uploading uv_workflows-0.0.1+20250109.152923-py3-none-any.whl...
-- MAGIC ...
-- MAGIC ```
-- MAGIC
-- MAGIC This `Building` step is important.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Run Job
-- MAGIC
-- MAGIC `databricks bundle run uv_workflows_job`
-- MAGIC
-- MAGIC Hint: Use auto-completion
-- MAGIC
-- MAGIC It works just fine.
-- MAGIC
-- MAGIC The notebook uses the Python code directly (they're in the same directory). All seems OK. Why bother with `uv`?! 🤔

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Motivation / Leading Idea of This Meetup
-- MAGIC
-- MAGIC Let's pause and answer the following question:
-- MAGIC
-- MAGIC > The bundle works (deploys and runs) so why care to use `uv`, `poetry` or any other Python build tool?!
-- MAGIC
-- MAGIC Possible answers:
-- MAGIC
-- MAGIC 1. Running tests before deployment (and other CI/CD-like management tasks to be executed locally)
-- MAGIC 1. More importantly, [python_wheel_task](https://docs.databricks.com/api/workspace/jobs/create#tasks-python_wheel_task) before the Python module "leaves" home (the current project) and will be published

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Create uv Project
-- MAGIC
-- MAGIC `uv init`
-- MAGIC
-- MAGIC [Develop a Python wheel file using Databricks Asset Bundles](https://docs.databricks.com/en/dev-tools/bundles/python-wheel.html) (esp. [Step 4: Update the project’s bundle to use Poetry](https://docs.databricks.com/en/dev-tools/bundles/python-wheel.html))
-- MAGIC
-- MAGIC > By default, the bundle template specifies building the Python wheel file using `setuptools` along with the files `setup.py` and `requirements-dev.txt`.
-- MAGIC
-- MAGIC [Databricks Asset Bundle configuration](https://docs.databricks.com/en/dev-tools/bundles/settings.html) (esp. [artifacts mapping](https://docs.databricks.com/en/dev-tools/bundles/settings.html#artifacts))
-- MAGIC
-- MAGIC > The top-level artifacts mapping specifies one or more artifacts that are automatically built during bundle deployments and can be used later in bundle runs.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Build Python wheel
-- MAGIC
-- MAGIC `uv build`
-- MAGIC
-- MAGIC > **build**    Build Python packages into source distributions and wheels
-- MAGIC
-- MAGIC `uv build --help` (esp. `uv build --wheel`)
-- MAGIC
-- MAGIC Learn more in [Building your package](https://docs.astral.sh/uv/guides/publish/#building-your-package)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## (Re)Deploy DAB
-- MAGIC
-- MAGIC `databricks bundle deploy` re-deploys the bundle but this time it's managed by uv ❤️
-- MAGIC
-- MAGIC Open up the workspace and review `main_task` definition. There should be our uv-built wheel under **Dependent libraries**.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ![](./uv_workflow_job.png)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC # Ideas for Future Meetups
-- MAGIC
-- MAGIC 1. [Pydantic](https://docs.pydantic.dev/latest/)
-- MAGIC 1. [Delta Live Tables](https://docs.databricks.com/en/delta-live-tables/index.html)
