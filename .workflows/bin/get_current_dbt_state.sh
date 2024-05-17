#!/bin/bash 

# top level directory
export TOP_DIR=$(git rev-parse --show-toplevel)

# change directory into the adventureworks dbt project
cd ${TOP_DIR}/transform/adventureworks

# download the current state of our dbt project
az storage blob download \
    --file manifest.json \
    --connection-string $CONNECTION_STRING \
    --name manifest.json \
    --container-name dbtdocs \
    --account-name sampledbtprojstorageacc
