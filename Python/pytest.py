# Databricks notebook source
# MAGIC %md
# MAGIC # pytest
# MAGIC
# MAGIC [pytest: helps you write better programs](https://docs.pytest.org/en/stable/)

# COMMAND ----------

# MAGIC %md
# MAGIC ## Fixtures
# MAGIC
# MAGIC [About fixtures](https://docs.pytest.org/en/stable/explanation/fixtures.html)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ```text
# MAGIC E fixture 'self' not found
# MAGIC > available fixtures: cache, capfd, capfdbinary, caplog, capsys, capsysbinary, capteesys, cml_client, created_project, doctest_namespace, monkeypatch,
# MAGIC  project_name, pytestconfig, record_property, record_testsuite_property, record_xml_attribute, recwarn, subtests, tmp_path, tmp_path_factory, tmpdir, 
# MAGIC  tmpdir_factory
# MAGIC > use 'pytest --fixtures [testpath]' for help on them.
# MAGIC ```

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ```shell
# MAGIC pytest --fixtures
# MAGIC ```
