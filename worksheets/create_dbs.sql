use role accountadmin;

-- Warehouse
create or replace warehouse compute_etl
    with warehouse_size = xsmall;

-- Database
create or replace database adventureworks;
create or replace database adventureworks_preprod;
create or replace database feature_20242804_db_cicd;
