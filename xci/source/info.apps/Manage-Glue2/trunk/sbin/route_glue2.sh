#!/bin/bash
export PYTHONPATH=/soft/warehouse-apps-1.0/Manage-Glue2/PROD
export LD_LIBRARY_PATH=/soft/python-2.7.10-2/lib
/soft/python-2.7.10-2/bin/python /soft/warehouse-apps-1.0/Manage-Glue2/PROD/bin/route_glue2.py ${@:1}
