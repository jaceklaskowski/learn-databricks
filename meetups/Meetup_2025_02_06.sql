-- Databricks notebook source
-- MAGIC %md # Data Quality in Databricks Workflows with Pydantic cntd.
-- MAGIC
-- MAGIC ➡️ [Meetup Announcement](https://www.meetup.com/warsaw-data-engineering/events/305995327/)
-- MAGIC
-- MAGIC Zakładamy, że mamy 2 projekty. Pierwszy projekt z pydantic (libka w Pythonie), a drugi to "hello world" Databricks Asset Bundle project z przykładowym job'em. Nic specjalnie wyrafinowanego. Od tego zaczniemy.
-- MAGIC
-- MAGIC Agenda:
-- MAGIC
-- MAGIC 1. 5 minut rozgrzewki na luźne pomysły na ten i przyszłe meetupy
-- MAGIC     * News (new versions, new features, etc.)
-- MAGIC 1. 50 minut Live coding session, a w nim:
-- MAGIC     * Za pomocą Databricks Asset Bundles (DAB), uruchomisz Databricks job z notebookiem z libką w Pythonie z Pydantic (takie tam "hello world"). Wszystko z pomocą uv do zarządzania projektem.
-- MAGIC     * Stworzymy UDFa do walidacji rekordów, którego "uzbroimy" w pydantic'a. To główny cel meetupu, którego osiągnięcie będzie naszym "najosobityczniejszym" sukcesem 🥂
-- MAGIC     * Może coś jeszcze, ale nie zdradzę teraz 🤷‍♂️
-- MAGIC 1. 5 minut Q&A / Zbieranie pomysłów na kolejne edycje

-- COMMAND ----------

-- MAGIC %md # 📢 News

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## New Versions
-- MAGIC
-- MAGIC * [uv 0.5.29](https://github.com/astral-sh/uv/releases/tag/0.5.29)
-- MAGIC * [awscli 2.24.0](https://github.com/aws/aws-cli/releases/tag/2.24.0)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC # Live Coding Session
