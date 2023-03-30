# https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/directory
resource "databricks_directory" "demo_input" {
  path = "/Users/jacek@japila.pl/delta-live-tables-demo-input"
}

# https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/repo
resource "databricks_repo" "learn_databricks" {
  path = "/Repos/jacek@japila.pl/delta-live-tables-demo"
  url = "https://github.com/jaceklaskowski/learn-databricks"
}

resource "databricks_pipeline" "this" {
  name = "EXPECT Clause Demo"
  library {
    notebook {
      path = "${databricks_repo.learn_databricks.path}/demo/delta-live-tables/my_streaming_table"
    }
  }
}
