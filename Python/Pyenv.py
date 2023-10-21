# Databricks notebook source
# MAGIC %md # Pyenv
# MAGIC
# MAGIC [Simple Python Version Management: pyenv](https://github.com/pyenv/pyenv)

# COMMAND ----------

# MAGIC %md ## Installation
# MAGIC
# MAGIC On macos:
# MAGIC
# MAGIC ```shell
# MAGIC brew update
# MAGIC brew install pyenv
# MAGIC ```
# MAGIC
# MAGIC or [Installation](https://github.com/pyenv/pyenv#installation)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ```
# MAGIC $ pyenv --version
# MAGIC pyenv 2.3.30
# MAGIC ```

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ```shell
# MAGIC $ pyenv install 3.12
# MAGIC python-build: use openssl@3 from homebrew
# MAGIC python-build: use readline from homebrew
# MAGIC Downloading Python-3.12.0.tar.xz...
# MAGIC -> https://www.python.org/ftp/python/3.12.0/Python-3.12.0.tar.xz
# MAGIC Installing Python-3.12.0...
# MAGIC python-build: use tcl-tk from homebrew
# MAGIC python-build: use readline from homebrew
# MAGIC python-build: use ncurses from homebrew
# MAGIC python-build: use zlib from xcode sdk
# MAGIC Installed Python-3.12.0 to /Users/jacek/.pyenv/versions/3.12.0
# MAGIC ```
# MAGIC
# MAGIC ```shell
# MAGIC $ pyenv virtualenv 3.12 databricks-cli
# MAGIC ```
# MAGIC
# MAGIC ```shell
# MAGIC $ pyenv activate databricks-cli
# MAGIC ```
# MAGIC
# MAGIC ```shell
# MAGIC $ python --version
# MAGIC Python 3.12.0
# MAGIC ```
# MAGIC
# MAGIC ```shell
# MAGIC $ pyenv deactivate
# MAGIC ```
# MAGIC
# MAGIC ```shell
# MAGIC $ python --version
# MAGIC Python 3.11.6
# MAGIC ```
# MAGIC
# MAGIC ```shell
# MAGIC $ pyenv local databricks-cli
# MAGIC ```
# MAGIC
# MAGIC ```shell
# MAGIC $ pyenv local
# MAGIC ```
# MAGIC
# MAGIC A special version name `system` means to use whatever Python is found on PATH after the shims PATH entry (in other words, whatever would be run if Pyenv shims weren't on PATH).
# MAGIC
# MAGIC ```shell
# MAGIC $ pyenv global
# MAGIC system
# MAGIC ```
