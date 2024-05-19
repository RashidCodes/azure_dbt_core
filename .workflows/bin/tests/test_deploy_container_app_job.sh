#!/bin/bash 

# secrets
snowflake_account="snowflake-account=${snowflake_username}"
snowflake_username="snowflake-username=${snowflake_password}"
snowflake_password="snowflake-password=${snowflake_account}"

# TODO: Try logging in as the SP to create a containerapp job
# Login to az
az login --service-principal -u ${SP_USER} -p ${SP_PASS} --tenant ${TENANT_ID};

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
    --secrets ${snowflake_account} ${snowflake_username} ${snowflake_password}  \
    --env-vars 'snowflake_account=secretref:snowflake-account' 'snowflake_username=secretref:snowflake-username' 'snowflake_password=secretref:snowflake-password'\
