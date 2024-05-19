#!/bin/bash 
# Terraform Vars
export TF_VAR_SNOWFLAKE_USERNAME=""
export TF_VAR_SNOWFLAKE_PASSWORD=""
export TF_VAR_TENANT_ID=""
export TF_VAR_CLIENT_ID=""
export TF_VAR_CLIENT_SECRET=""
export TF_VAR_SUBSCRIPTION_ID=""
export TF_VAR_CONTAINERAPP_JOB_SCOPE="/subscriptions/7bc876fd-c9fc-4674-a3cd-115f28068bbb/resourceGroups/new_rg/providers/Microsoft.App/jobs/midrangepullup"

# Snowflake Vars
export SNOWFLAKE_USERNAME=""
export SNOWFLAKE_PASSWORD=""
export SNOWFLAKE_ACCOUNT=""

# ACR Vars
export REGISTRY_USER=""
export REGISTRY_PASSWORD=""
export CONNECTION_STRING=""

# Service Principals Vars
export SP_USER=""
export SP_PASS=""
export TENANT_ID=""

# Env vars for deployment pipeline testing
export CONTAINER_APP_JOB_NAME=""
export CONTAINER_APP_JOB_RG=""
export CONTAINER_APP_JOB_ENV_NAME=""
export CONTAINER_REGISTRY=""
export IMAGE_NAME=""
export VERSION=""
export REGISTRY_USER=""
export REGISTRY_PASSWORD=""

