-- Databricks notebook source
-- MAGIC %md # Data Quality in Databricks Workflows with Pydantic
-- MAGIC
-- MAGIC ➡️ [Meetup Announcement](https://www.meetup.com/warsaw-data-engineering/events/305877678/)
-- MAGIC
-- MAGIC Agenda:
-- MAGIC
-- MAGIC 1. 5 minut rozgrzewki na luźne pomysły na ten i przyszłe meetupy
-- MAGIC     * News (new versions, new features, etc.)
-- MAGIC 1. 50 minut Live coding session, a w nim:
-- MAGIC     * Stworzysz nowy projekt dla libki w Pythonie z Pydantic (hello world itp.) i jedynie słusznym uv do zarządzania projektem
-- MAGIC     * Stworzysz Databricks job z notebookiem z naszym projektem w Pythonie wyżej (wszystko ręcznie / klikamy w UI / pełny manual)
-- MAGIC     * Automatyzacja z Databricks Asset Bundles (DAB)
-- MAGIC 1. 5 minut Q&A / Zbieranie pomysłów na kolejne edycje

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## 🌟 Praise Quote 🌟
-- MAGIC
-- MAGIC > Co zainteresowało Cię w Warsaw Data Engineering Meetup, że zdecydowałaś/-eś się przyłączyć?
-- MAGIC
-- MAGIC > I love studying everything in detail.
-- MAGIC > I'd like to learn more about Apache Spark.
-- MAGIC > I read a lot of articles by Jacek Laskowski and have started reading books on Spark internals.

-- COMMAND ----------

-- MAGIC %md # 📢 News

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## New Versions
-- MAGIC
-- MAGIC * [uv 0.5.25](https://github.com/astral-sh/uv/releases/tag/0.5.25)
-- MAGIC * [Databricks CLI 0.240.0](https://github.com/databricks/cli/releases/tag/v0.240.0)
-- MAGIC * [awscli 2.23.9](https://github.com/aws/aws-cli/releases/tag/2.23.9)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Databricks Notebook UI
-- MAGIC
-- MAGIC [Databricks notebook interface and controls](https://docs.databricks.com/en/notebooks/notebook-ui.html)
-- MAGIC
-- MAGIC **Cmd + Shift + P** for [Command palette](https://docs.databricks.com/en/notebooks/notebook-editor.html) with the following:
-- MAGIC
-- MAGIC 1. [Multicursor support](https://docs.databricks.com/en/notebooks/notebook-editor.html#multicursor-support) 🥳
-- MAGIC 1. [Use web terminal and Databricks CLI](https://docs.databricks.com/en/notebooks/notebook-editor.html#use-web-terminal-and-databricks-cli) 🤔
-- MAGIC 1. Duplicating lines as in Visual Code ❤️

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC # Live Coding Session
