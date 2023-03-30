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

**FIXME** Use Terraform

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
$ databricks pipelines list | jq '.[] | { name, pipeline_id }'
{
  "name": "EXPECT Clause Demo",
  "pipeline_id": "a02952e6-7197-44a4-a072-5ea5124d7bce"
}
```

**FIXME** Get rid of the quotes to use `$(tfo pipeline_id)` right after `--pipeline-id`.

```console
echo $(tfo pipeline_id) | xargs databricks pipelines start --pipeline-id
```

Wait until the pipeline finishes. Select (click) the `raw_streaming_table` streaming live table and review the **Data quality** section.

Upload data again and re-run the pipeline.

```console
databricks fs cp input-data/2.csv dbfs:/FileStore/jacek_laskowski/delta-live-tables-demo-input
```

```console
echo $(tfo pipeline_id) | xargs databricks pipelines start --pipeline-id
```

Enjoy!
