#!/bin/bash

function main_function
{
   cd /soft/warehouse-apps-1.0/Manage-Glue2/PROD/
   time psql warehouse glue2_owner <bin/cleanup.sql
}

main_function 2>&1 | mail -s "GLUE2 weekly cleanup" "navarro@mcs.anl.gov"
