# Run DBT-Core in Production on Azure
The goal of this PoC is to check whether terraform can be used to run `dbt-core` in production.

# Tools
- Terraform v1.7.5
- Docker version 20.10.17, build 100c701

# How to run the project
```bash
# Navigate to the IaC dir
cd IaC
# and run the build script
. ./build.sh
```

# Clean up
```bash
terraform destroy -auto-approve
```

# Issues
1. dbt-core uses environment variables in the `profiles.yml` file. When a container is created in an azure container job, the environment variables are exposed in plain text - on the azure portal. A potential way to solve this might be to use to secrets or hide the env vars in a file mounted in azure files (unsure).

1. When a service is created with the `azurerm_resource_group_template_deployment` resource, the deployment gets stuck in the "creating" state even after the service has been successfully provisioned.

    ![terraform run](./assets/terraform_run.png)

    ***Fig 1***: *Resource Group Deployment of a container job*

    In the figure above, the deployment runs for **6** minutes even though the service (container job) was provisioned in under a minute.

1. Using ARM templates requires the use of parameters. Parameters are usually stored in `json` format and may contain sensitive data like environment variables. See [parameters.json](./templates/container-job-deploy-params.json). You might be able to get away with using terraform to pass in variables in a json encoded `parameters_content`.

    For example
    ```terraform
    resource "azurerm_resource_group_template_deployment" "container_job_deploy" {
        name                = "container-job-v5"
        resource_group_name = azurerm_resource_group.new_rg.name
        deployment_mode     = "Complete"
        parameters_content  = jsonencode({
            "subscriptionId": {
                "value": "${var.subscription_id}"
            },
            "name": {
                "value": "test-dbt-dev-job-v1"
            },
            "location": {
                "value": "australiaeast"
            },
            "environmentId": {
                "value": "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group}/providers/Microsoft.App/managedEnvironments/new-environment"
            },
            "containers": {
                "value": [
                    {
                        "name": "dbt-dev-job",
                        "image": "${image_name}",
                        "command": [],
                        "resources": {
                            "cpu": 0.25,
                            "memory": ".5Gi"
                        },
                        # TODO: Store in secrets or Azure Files
                        "env": [
                            {
                                "name": "SNOWFLAKE_USERNAME",
                                "value": "${var.SNOWFLAKE_USERNAME}"
                            },
                            {
                                "name": "SNOWFLAKE_PASSWORD",
                                "value": "${var.SNOWFLAKE_PASSWORD}"
                            }
                        ]
                    }
                ]
            },
            "registries": {
                "value": [
                    {
                        "server": "midrangepullup.azurecr.io",
                        "username": "${var.registry_username}",
                        "passwordSecretRef": "reg-pswd-ab880cd4-b637"
                    }
                ]
            },
            "secrets": {
                "value": {
                    "arrayValue": [
                        {
                            "name": "reg-pswd-ab880cd4-b637",
                            "value": "${var.registry_password}"
                        }
                    ]
                }
            }
        })
        template_content    = file("templates/container-job-deploy-template.json")
    }
    ```

    ARM deployments are a pain at the end of day.
