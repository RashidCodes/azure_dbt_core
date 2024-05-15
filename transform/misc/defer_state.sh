#!/bin/bash

# use in ci
dbt run --state ./current_state --defer --target dev;

# use in development
dbt clone --state ./current_state --target dev;
