#!/usr/bin/env python
# Test processing a GLUE2 json file
import json
import datetime
import os
import sys
import base64
import httplib, urllib
import django
import pdb
import logging
log = loggin.getLogger(')
from datetime import datetime
from glue2_provider.process import Glue2NewDocument, StatsSummary

def test_direct(data, type, resource, ts):
    django.setup()
    doc = Glue2NewDocument(type, resource, ts)
    py_data = json.loads(data)
    result = doc.process(py_data)
    print StatsSummary(result)

def test_rest(data, type, resource, ts):
    auth = base64.standard_b64encode('test:pass')
    headers = {'Content-type': 'application/json',
               'authorization': 'Basic %s' % auth }
    url = '/xsede-api/provider/ipf-glue2/v1/process/' + \
        'doctype/' + type + '/resourceid/' + resource + '/'
    conn = httplib.HTTPConnection('localhost', '8000')
    conn.request('POST', url, data, headers)
    print '    POST %s' % url
    response = conn.getresponse()
    print '    RESP %s %s' % (response.status, response.reason)
    result = response.read()
    try:
        obj = json.loads(result)
        if isinstance(obj, dict):
            print '    STAT %s' % StatsSummary(obj)
        else:
            print '    RESPONSE %s: ' % obj
            raise ValueError('')
    except ValueError, e:
        print '    ERROR: Response not in expected format (%s)' % e

def process_file(path):
    file_name = path.split('/')[-1]
    if file_name[0] == '.':
        print 'Skipping "dot" file %s' % file_name
        return
    
    idx = file_name.rfind('.')
    resource = file_name[0:idx]
    ts = file_name[idx+1:len(file_name)]
    with open(path, 'r') as file:
        data=file.read().replace('\n','')
        file.close()

    try:
        py_data = json.loads(data)
    except ValueError, e:
        print 'While processing %s\nException: %s' % (path, e)

    if 'ApplicationEnvironment' in py_data or 'ApplicationHandle' in py_data:
        type = 'glue2.applications'
    elif 'ComputingManager' in py_data or 'ComputingService' in py_data or \
        'ExecutionEnvironment' in py_data or 'Location' in py_data or 'ComputingShare' in py_data:
        type = 'glue2.compute'
    elif 'ComputingActivity' in py_data:
        type = 'glue2.computing_activities'
    else:
        print 'Document type not recognized:', path
        return

    print 'Processing %s\n    (%s, %s, %s) via %s' % (path, type, resource, ts, mode)

    if mode == 'direct':
        test_direct(data, type, resource, ts)
    else:
        test_rest(data, type, resource, ts)

if __name__ == '__main__':
    pdb.set_trace()
    if len(sys.argv) != 3:
        print 'ERROR: Invalid argument(s)'
        print 'Usage: %s {direct|rest} <directory>|<file>' % sys.argv[0]
        sys.exit(2)
    mode = sys.argv[1]
    if mode not in {'direct', 'rest'}:
        print 'ERROR: Mode not (direct, rest)'
        sys.exit(2)

    target = sys.argv[2]
    if os.path.isfile(target):
        process_file(target)
    elif os.path.isdir(target):
        for file in os.listdir(target):
            process_file(target + '/' + file)
    else:
       print 'ERROR: First argument is not a readable file'
       sys.exit(1)

    sys.exit(0)
