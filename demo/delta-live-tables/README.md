# Delta Live Tables Pipeline Demo

```console
$ tfi
...
Terraform has been successfully initialized!
```

```console
tfa -auto-approve
```

Check out the pipeline. This step is completely optional.

```console
$ databricks pipelines list | jq '.[] | { name, pipeline_id }'
{
  "name": "EXPECT Clause Demo",
  "pipeline_id": "a02952e6-7197-44a4-a072-5ea5124d7bce"
}
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

Run the pipeline.

```console
databricks pipelines start --pipeline-id $(tfo -raw pipeline_id)
```

Wait until the pipeline finishes (until `IDLE` comes up from the following command).

```console
while (true)
do
  databricks pipelines get --pipeline-id $(tfo -raw pipeline_id) | jq '.state'
done
```

Switch to the DLT UI. Select (_click_) the `raw_streaming_table` streaming live table and review the **Data quality** section.

Upload data again and re-run the pipeline.

```console
databricks fs cp input-data/2.csv dbfs:/FileStore/jacek_laskowski/delta-live-tables-demo-input
```

```console
databricks pipelines start --pipeline-id $(tfo -raw pipeline_id)
```

Review the events delta table (use **Data Quality Checks** cell in [Storage location](../../Delta%20Live%20Tables/Storage%20location.sql) notebook).

## Clean Up

```console
tfd -auto-approve
```

```console
databricks fs rm -r dbfs:/FileStore/jacek_laskowski/delta-live-tables-demo-input
```
