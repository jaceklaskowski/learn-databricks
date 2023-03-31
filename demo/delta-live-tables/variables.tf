variable "input_dir" {
  description = "The input directory for Auto Loader to load CSV files from"
  type        = string
  nullable    = false
  default     = "/FileStore/jacek_laskowski/delta-live-tables-demo-input"
}
