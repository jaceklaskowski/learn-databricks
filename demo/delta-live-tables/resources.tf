# https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/dbfs_file
# Deploy a single file for the demo to have something to consume
resource "databricks_dbfs_file" "this" {
  source = "${path.module}/input-data/1.csv"
  path   = "${var.input_dir}/1.csv"
}

# https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/repo
resource "databricks_repo" "learn_databricks" {
  path = "/Repos/jacek@japila.pl/delta-live-tables-demo"
  url = "https://github.com/jaceklaskowski/learn-databricks"
}

resource "databricks_pipeline" "this" {
  name = "EXPECT Clause Demo"
  development = true
  library {
    notebook {
      path = "${databricks_repo.learn_databricks.path}/demo/delta-live-tables/my_streaming_table"
    }
  }
  configuration = {
    cloud_files_input_path = var.input_dir
  }
}
