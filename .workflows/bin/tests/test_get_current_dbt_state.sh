#!/bin/bash 

# top level directory
export TOP_DIR=$(git rev-parse --show-toplevel)

# change directory into the adventureworks dbt project
cd ${TOP_DIR}/transform/adventureworks

# download the current state of our dbt project
az login --service-principal -u ${SP_USER} -p ${SP_PASS} --tenant ${TF_VAR_TENANT_ID}

az storage blob download \
    --file manifest.json \
    --connection-string $CONNECTION_STRING \
    --name manifest.json \
    --container-name dbtdocs \
    --account-name sampledbtprojstorageacc
