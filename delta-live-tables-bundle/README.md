# Delta Live Tables DAB Bundle

This is a [Databricks asset bundle (DAB)](https://docs.databricks.com/dev-tools/bundles/index.html) with a [Delta Live Tables (DLT)](https://docs.databricks.com/en/delta-live-tables/index.html) pipeline.

This DLT pipeline uses SQL files (beside Python notebooks) which is a fairly new feature in Delta Live Tables.

Use [Databricks CLI](https://docs.databricks.com/en/dev-tools/cli/index.html) to manage the project.

> **NOTE**
>
> Use `databricks auth profiles` to verify your deployment targets.

## Getting started

1. Install the [Databricks CLI](https://docs.databricks.com/dev-tools/cli/databricks-cli.html)

2. Authenticate to your Databricks workspace

    ```
    $ databricks configure
    ```

3. To deploy a development copy of this project, type:

    ```
    $ databricks bundle deploy --target dev
    ```
    (Note that "dev" is the default target, so the `--target` parameter
    is optional here.)

    This deploys everything that's defined for this project.
    For example, the default template would deploy a job called
    `[dev yourname] my_project_job` to your workspace.
    You can find that job by opening your workpace and clicking on **Workflows**.

4. Similarly, to deploy a production copy, type:

   ```
   $ databricks bundle deploy --target prod
   ```

   Note that the default job from the template has a schedule that runs every day
   (defined in resources/my_project_job.yml). The schedule
   is paused when deploying in development mode (see
   https://docs.databricks.com/dev-tools/bundles/deployment-modes.html).

5. To run a job or pipeline, use the "run" command:

   ```
   $ databricks bundle run
   ```

6. Optionally, install developer tools such as the Databricks extension for Visual Studio Code from https://docs.databricks.com/dev-tools/vscode-ext.html.

    Don't forget to activate the JSON schema from the Databricks extension while working with the DAB config file.