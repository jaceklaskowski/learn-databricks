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

-- MAGIC %md
-- MAGIC
-- MAGIC ## Event Question
-- MAGIC
-- MAGIC O czym chciał(a)byś usłyszeć podczas meetupu? Rzuć ciekawym pomysłem na kolejne edycje 🙏
-- MAGIC
-- MAGIC 1. staram się nadarzyć za tym co Jacek mówi i czegoś się dowiedzieć
-- MAGIC 1. framework w Python - best practices
-- MAGIC 1. DAB
-- MAGIC 1. continue exploring quality with dqx or dlt publish to different schemas as good standard for medalion
-- MAGIC 1. Plan rozwoju, doświadczenia zawodowe wymiataczy technologicznych
-- MAGIC 1. Jakieś zaawansowane data quality w DBR; może jakaś analiza wykorzystania narzędzi typu Polars/DuckDB dla jedno-node’owych klastrów?
-- MAGIC 1. Jeżeli uda mi się dołączyć, to będzie fajnie posłuchać dalszej cześci poprzedniego meetup'u :)
-- MAGIC 1. Podłączenie Master data w transformacjach Databricks
-- MAGIC 1. Pydantic
-- MAGIC 1. everything about databricks
-- MAGIC 1. Chcę rozwijać swoje umiejętności w databricks a ta seria spotkań to coś czego szukałem

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
