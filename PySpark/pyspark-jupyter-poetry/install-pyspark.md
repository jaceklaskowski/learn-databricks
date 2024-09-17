# Install PySpark

1. The official [Apache Spark docs](https://spark.apache.org/docs/latest/api/python/getting_started/install.html)
1. [Getting Started](https://spark.apache.org/docs/latest/api/python/getting_started/index.html)

## Spark Connect

[Spark Connect](https://spark.apache.org/docs/latest/api/python/getting_started/quickstart_connect.html)

Start Spark Connect server.

```bash
./sbin/start-connect-server.sh
```

Open http://localhost:4040/connect/ to review the Spark Connect server application UI.

```bash
poetry run pyspark --remote sc://localhost:15002
```

In the other terminal, `tail -f` the logs to learn more about the connection.

```bash
tail -f /Users/jacek/dev/oss/spark/logs/spark-jacek-org.apache.spark.sql.connect.service.SparkConnectServer-1-Jaceks-Mac-mini.local.out
```

Refresh the Spark Connect server application UI.

## JupyterLab

[JupyterLab: A Next-Generation Notebook Interface](https://jupyter.org/)

```bash
poetry run jupyter lab
```
