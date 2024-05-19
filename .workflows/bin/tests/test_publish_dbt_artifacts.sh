#!/bin/bash 

# top level directory
export TOP_DIR=$(git rev-parse --show-toplevel)
pip install -r ${TOP_DIR}/transform/requirements.txt --no-index --find-links=${pip_download_dir}

# change directory into the adventureworks dbt project
cd ${TOP_DIR}/transform/adventureworks

# may be quite expensive with a large number of models
# other options: dbt parse
# this generates the latest manifest.json (state)
dbt deps
dbt run --target prod --profiles-dir .

# generate docs
dbt docs generate --target prod --profiles-dir .

# get docs
mkdir -p public;
cp target/index.html public/
cp target/catalog.json public/
cp target/manifest.json public/
cp target/run_results.json public/

az storage blob upload-batch \
 --destination dbtdocs \
 --connection-string ${CONNECTION_STRING} \
 --source public \
 --overwrite true

rm -rf public
