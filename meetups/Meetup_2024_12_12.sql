-- Databricks notebook source
-- MAGIC %md # Meetup 2024-12-12
-- MAGIC
-- MAGIC ➡️ [Databricks Asset Bundles, Databricks Workflows and uv](https://www.meetup.com/warsaw-data-engineering/events/305034410/)
-- MAGIC
-- MAGIC Agenda:
-- MAGIC
-- MAGIC * 5 minut rogrzewki na luźne pomysły na ten i przyszłe meetupy
-- MAGIC * 30 minut Live coding session
-- MAGIC * Q&A / Zbieranie pomysłów na kolejne edycje (5 minut)

-- COMMAND ----------

-- MAGIC %md # News

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## brew update
-- MAGIC
-- MAGIC * pyenv 2.4.21 -> 2.4.22
-- MAGIC * hashicorp/tap/terraform 1.10.1 -> 1.10.2
-- MAGIC * yq 4.44.5 -> 4.44.6
-- MAGIC * pipx 1.7.1 -> 1.7.1_1
-- MAGIC * python@3.13 3.13.0_1 -> 3.13.1
-- MAGIC * openjpeg 2.5.2 -> 2.5.3
-- MAGIC * python@3.12 3.12.7_1 -> 3.12.8
-- MAGIC * glib 2.82.2 -> 2.82.3
-- MAGIC * llvm 19.1.4 -> 19.1.5
-- MAGIC * awscli 2.22.12 -> 2.22.15
-- MAGIC * sqlite 3.47.1 -> 3.47.2
-- MAGIC * uv 0.5.6 -> 0.5.8
-- MAGIC * curl 8.11.0_1 -> 8.11.1
-- MAGIC * scala 3.5.2 -> 3.6.2
-- MAGIC * gettext 0.22.5 -> 0.23
-- MAGIC * kubernetes-cli 1.31.3 -> 1.32.0
-- MAGIC * node 23.3.0 -> 23.4.0
-- MAGIC * poppler-qt5 24.11.0 -> 24.12.0

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC # Live Coding Session

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ### ✅ uv
-- MAGIC
-- MAGIC 1. [Working on projects](https://docs.astral.sh/uv/guides/projects/)
-- MAGIC 1. [Building your package](https://docs.astral.sh/uv/guides/publish/#building-your-package)
-- MAGIC
-- MAGIC ### Databricks Workflows
-- MAGIC
-- MAGIC ### Databricks Asset Bundles
-- MAGIC
-- MAGIC 1. [Databricks Runtime 15.4 LTS](https://docs.databricks.com/en/release-notes/runtime/15.4lts.html#system-environment)
-- MAGIC     * Python: 3.11.0
-- MAGIC 1. [Databricks Asset Bundles development](https://docs.databricks.com/en/dev-tools/bundles/work-tasks.html)
-- MAGIC 1. [Databricks Asset Bundle configuration](https://docs.databricks.com/en/dev-tools/bundles/settings.html)
-- MAGIC     * [artifacts](https://docs.databricks.com/en/dev-tools/bundles/settings.html#artifacts) mapping
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Ideas for Future Meetups
-- MAGIC
-- MAGIC 1. [Pydantic](https://docs.pydantic.dev/latest/)
-- MAGIC 1. [Delta Live Tables](https://docs.databricks.com/en/delta-live-tables/index.html)
