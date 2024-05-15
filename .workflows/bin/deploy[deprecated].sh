#!/bin/bash

# -----------
# DEPRECATED
# -----------
# run this on the agent as part of the CI process
# build the image
CONTAINER_REGISTRY="midrangepullup.azurecr.io"
CONTAINER_JOB_NAME="test-dbt-dev-job-v1"
CONTAINER_JOB_ENV_NAME="new-environment"
CONTAINER_JOB_RG="new_rg"
IMAGE_NAME="dbt_core_dev"

# Version name (changes for each deployment - use commit hash)
version="v4"

# Build from code base and push
docker login -u ${REGISTRY_USER} -p ${REGISTRY_PASSWORD} ${CONTAINER_REGISTRY}
docker rm -f $IMAGE_NAME:$version;
docker rmi $IMAGE_NAME:$version;
docker build -t $IMAGE_NAME:$version .;
docker tag $IMAGE_NAME:$version "${CONTAINER_REGISTRY}/${IMAGE_NAME}:${version}";
docker push "${CONTAINER_REGISTRY}/${IMAGE_NAME}:${version}";

# secrets
snowflake_account="snowflake-account=${SNOWFLAKE_ACCOUNT}"
snowflake_username="snowflake-username=${SNOWFLAKE_USERNAME}"
snowflake_password="snowflake-password=${SNOWFLAKE_PASSWORD}"

# Create container app job
az containerapp job create \
    --name ${CONTAINER_APP_JOB_NAME} --resource-group ${CONTAINER_APP_JOB_RG}  --environment ${CONTAINER_APP_JOB_ENV_NAME} \
    --trigger-type "Manual" \
    --replica-timeout 1800 \
    --image "${CONTAINER_REGISTRY}/${IMAGE_NAME}:${version}" \
    --cpu "0.25" --memory "0.5Gi" \
    --registry-server ${CONTAINER_REGISTRY} \
    --registry-username ${REGISTRY_USER} \
    --registry-password ${REGISTRY_PASSWORD} \
    --secrets ${snowflake_account} ${snowflake_username} ${snowflake_password}  \
    --env-vars 'snowflake_account=secretref:snowflake-account' 'snowflake_username=secretref:snowflake-username' 'snowflake_password=secretref:snowflake-password'\


