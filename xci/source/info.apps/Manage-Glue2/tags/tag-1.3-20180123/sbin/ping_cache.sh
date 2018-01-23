#!/bin/bash

# Description:       Touch cache to keep it fresh

CACHE_1=https://info.xsede.org/wh1/warehouse-views/v1/software-cached/
OUT=/soft/warehouse-apps-1.0/Manage-Glue2/var/ping_cache.log


do_ping () {
    echo -n "Ping at: "
    date
    /usr/bin/time -f "%E" wget -q -O /dev/null $CACHE_1 
}

do_ping >>$OUT 2>&1

#exit $RETVAL
