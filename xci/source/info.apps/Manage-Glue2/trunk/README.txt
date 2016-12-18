Setup:

setenv PYTHONPATH /Users/navarro/svn/xd/sdi/source/info.warehouse/trunk/django_xsede_warehouse
setenv DJANGO_SETTINGS_MODULE xsede_warehouse.settings

/soft/python-2.7.13-1/bin/python ./route_glue2.py --verbose --pdb -c
./route_glue2.conf -s file:/soft/jp.json
