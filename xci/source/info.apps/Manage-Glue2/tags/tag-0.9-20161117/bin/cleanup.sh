#!/bin/bash

function main_function
{
   cd /soft/warehouse-apps-1.0/Manage-Glue2/PROD/
   time psql warehouse glue2_owner <sbin/cleanup.sql
}

main_function | mail -s "GLUE2 weekly cleanup" "navarro@mcs.anl.gov" 2>&1
