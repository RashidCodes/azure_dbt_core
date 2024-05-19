# Run DBT Core on Azure with Containerapps
In this project, I've a basic framework that can be used to run dbt in your azure environment. The project serves as a starting point for stakeholders that are looking to quickly use dbt-core in their environments.

# Reference
## Improve the build time of build pipelines
https://stackoverflow.com/questions/62420695/how-to-cache-pip-packages-within-azure-pipelines

## Service Principals
Automated tools that use Azure services should always have restricted permissions to ensure that Azure resources are secure. Therefore, instead of having applications sign in as a fully privileged user, Azure offers service principals. An Azure service principal is an identity created for use with applications, hosted services, and automated tools. This identity is used to access resources.

https://learn.microsoft.com/en-us/cli/azure/authenticate-azure-cli-service-principal

https://learn.microsoft.com/en-us/cli/azure/azure-cli-sp-tutorial-1?tabs=bash

## Logging commands
https://learn.microsoft.com/en-us/azure/devops/pipelines/scripts/logging-commands?view=azure-devops&tabs=bash
