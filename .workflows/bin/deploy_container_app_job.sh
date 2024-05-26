#!/bin/bash

# secrets
SNOWFLAKE_ACCOUNT="snowflake-account=${SNOWFLAKE_ACCOUNT}"
SNOWFLAKE_USERNAME="snowflake-username=${SNOWFLAKE_USERNAME}"
SNOWFLAKE_PASSWORD="snowflake-password=${SNOWFLAKE_PASSWORD}"

# Login to az 
if [[ -z "${TF_BUILD}" ]];then
    az login
else
    az login --service-principal -u ${SP_USER} -p ${SP_PASS} --tenant ${TENANT_ID};
fi

# Create container app job
az containerapp job create \
    --name ${CONTAINER_APP_JOB_NAME} --resource-group ${CONTAINER_APP_JOB_RG}  --environment ${CONTAINER_APP_JOB_ENV_NAME} \
    --trigger-type "Manual" \
    --replica-timeout 1800 --replica-retry-limit 3 --replica-completion-count 5 --parallelism 5 \
    --image "${CONTAINER_REGISTRY}/${IMAGE_NAME}:${VERSION}" \
    --cpu "0.25" --memory "0.5Gi" \
    --registry-server ${CONTAINER_REGISTRY} \
    --registry-username ${REGISTRY_USER} \
    --registry-password ${REGISTRY_PASSWORD} \
    --secrets ${SNOWFLAKE_ACCOUNT} ${SNOWFLAKE_USERNAME} ${SNOWFLAKE_PASSWORD}  \
    --env-vars 'SNOWFLAKE_ACCOUNT=secretref:snowflake-account' 'SNOWFLAKE_USERNAME=secretref:snowflake-username' 'SNOWFLAKE_PASSWORD=secretref:snowflake-password'\
