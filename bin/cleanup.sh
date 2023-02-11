#!/bin/bash
# DB connection relies on ~/.pgpass

function main_function
{
   cd /soft/warehouse-apps-1.0/Manage-Glue2/PROD/
   time psql warehouse glue2_owner -h information-warehouse-prod-cluster.cluster-clabf5kcvwmz.us-east-2.rds.amazonaws.com <bin/cleanup.sql
}

main_function 2>&1 | mail -r ops-support-notify@access-ci.org -s "`hostname`: GLUE2 weekly cleanup" "ops-support-notify@access-ci.org"
