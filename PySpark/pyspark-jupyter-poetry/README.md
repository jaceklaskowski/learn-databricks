# PySpark with Jupyter

This project shows how to run Apache Spark (PySpark) with Jupyter.

Run PySpark as follows:

```bash
poetry run pyspark
```

Start Spark Connect server.

```bash
./sbin/start-connect-server.sh
```

Review the logs of this Spark Connect server.

```bash
tail -f /Users/jacek/dev/oss/spark/logs/spark-jacek-org.apache.spark.sql.connect.service.SparkConnectServer-1-Jaceks-Mac-mini.local.out
```

At the end of the logs, you should see the following INFO message that says the URL of this Spark Connect instance.

```text
...
[main] INFO  org.apache.spark.sql.connect.service.SparkConnectServer:60 - Spark Connect server started at: 0:0:0:0:0:0:0:0:15002
```

Run PySpark within Jupyter as follows:

```bash
poetry run jupyter lab
```
