output "storage" {
  description = "Storage location"
  value = databricks_pipeline.this.storage
}

output "pipeline_id" {
  description = "Pipeline ID"
  value = databricks_pipeline.this.id
}

output "input_dir" {
  description = "Input directory to load CSV data from"
  value = var.input_dir
}
