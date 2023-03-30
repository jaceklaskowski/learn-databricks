output "storage" {
  description = "Storage location"
  depends_on = [
    databricks_pipeline.this
  ]
  value = databricks_pipeline.this.storage
}

output "pipeline_id" {
  description = "Pipeline ID"
  depends_on = [
    databricks_pipeline.this
  ]
  value = databricks_pipeline.this.id
}