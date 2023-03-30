# Delta Live Tables Pipeline Demo

```console
$ tfi
...
Terraform has been successfully initialized!
```

```console
tfa -auto-approve
```

**IMPORTANT** Every push to the repo is not reflected (`git pull`) by the repo after `tfa` so you have to `tfd`.

Create an input directory for the pipeline to load data from.

**FIXME** Terraform?

```console
databricks fs mkdirs dbfs:/FileStore/jacek_laskowski/delta-live-tables-demo-input
```

Upload data.

```console
databricks fs cp input-data/1.csv dbfs:/FileStore/jacek_laskowski/delta-live-tables-demo-input
```

Run the pipeline. Use `tfo` to know the pipeline ID.

```console
$ tfo
pipeline_id = "0bff248c-71a3-44dd-a1a3-474dc609aeee"
storage = "dbfs:/pipelines/0bff248c-71a3-44dd-a1a3-474dc609aeee"
```

```console
$ databricks pipelines list | jq '.[].name'
"EXPECT Clause Demo"
```

**FIXME** Get rid of the quotes to use `$(tfo pipeline_id)` right after `--pipeline-id`.

```console
echo $(tfo pipeline_id) | xargs databricks pipelines start --pipeline-id
```

Observe Data quality section of the `raw_streaming_table` streaming live table.

Upload data again.

```console
databricks fs cp input-data/2.csv dbfs:/FileStore/jacek_laskowski/delta-live-tables-demo-input
```

Enjoy!
