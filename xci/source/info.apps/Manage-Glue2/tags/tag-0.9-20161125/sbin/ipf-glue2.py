#!/usr/bin/env python

# Uses the python-amqp package
# Receives ipf-glue2 messages and stores them in the warehouse
import amqp
import json
import datetime
import os
import sys
import base64
import httplib, urllib
import argparse
import pdb
#import requests

default_base_dir = os.getcwd()
global parser, args

def connectAnonymous():
    return amqp.Connection(host='info1.dyn.xsede.org:5671',virtual_host='xsede')

def connectUserPass():
    #ssl_opts = {}
    # should check server CA chain
    ssl_opts = {'ca_certs': os.environ.get('X509_USER_CERT')}
    return amqp.Connection(host='info1.dyn.xsede.org:5671',virtual_host='xsede',
                          ssl=ssl_opts,userid='navarro',password='jpfnspubsub')

def connectX509():
    ssl_opts = {'ca_certs': '/path/to/pem',
               'keyfile': '/path/to/key.pem',
               'certfile': '/path/to/cert.pem'}
    return amqp.Connection(host='info1.dyn.xsede.org:5671',virtual_host='xsede',
                          ssl=ssl_opts)

def callback_print(message):
    st = datetime.datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ')
    print('%s exchange=%s, routing_key=%s, size=%s dest=PRINT' %
          (st, message.delivery_info['exchange'], message.delivery_info['routing_key'], len(message.body) ) )

def callback_file(message):
    st = datetime.datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ')
    dir = os.path.join(default_base_dir, message.delivery_info['exchange'])
    if not os.access(dir, os.W_OK):
        print('%s exchange=%s, routing_key=%s, size=%s NO WRITE to directory "%s"' %
              (st, message.delivery_info['exchange'], message.delivery_info['routing_key'], len(message.body), dir ) )
        return
    file_name = message.delivery_info['routing_key'] + '.' + st
    file = os.path.join(dir, file_name)
    print('%s exchange=%s, routing_key=%s, size=%s dest=file:%s' %
              (st, message.delivery_info['exchange'], message.delivery_info['routing_key'], len(message.body), file_name ) )
    with open(file, 'w') as fd:
        fd.write(message.body)
        fd.close()

def callback_warehouse(message):
    st = datetime.datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ')

    if message.delivery_info['exchange'] in ['glue2.computing_activity']:
        print('%s exchange=%s, routing_key=%s, size=%s dest=DROP' %
              (st, message.delivery_info['exchange'], message.delivery_info['routing_key'], len(message.body) ) )
        return

    baseurl = '/xsede-api/provider/ipf-glue2/v1/process/'
    auth = base64.standard_b64encode('test:pass')
    headers = {'Content-type': 'application/json',
        'Authorization': 'Basic %s' % auth }
    url = baseurl + 'doctype/' + message.delivery_info['exchange'] + '/resourceid/' + message.delivery_info['routing_key'] + '/'
    conn = httplib.HTTPConnection('localhost', '8000')
    conn.request('POST', url, message.body, headers)
    response = conn.getresponse()
    print('%s exchange=%s, routing_key=%s, size=%s dest=POST http_response=status(%s)/reason(%s)' %
        (st, message.delivery_info['exchange'], message.delivery_info['routing_key'], len(message.body), response.status, response.reason ) )
    data = response.read()
    if args.verbose:
        print data

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--pdb', help='Run with Python debugger', action='store_true')
    parser.add_argument('-v', '--verbose', help='Verbose output', action='store_true')
    parser.add_argument('-d', dest='dest', help='Destination for each message {print, file, or warehouse}', default='print', action='store')
    parser.add_argument('--dir', dest='dir', help='Target directory for dest=file', default='none', action='store')
    args = parser.parse_args()
    if args.pdb:
        pdb.set_trace()
    if args.dest not in ['print', 'file', 'warehouse']:
        print 'Invalid destination'
        sys.exit(2)
    if args.dest == 'file':
        if args.dir != 'none':
            default_base_dir = args.dir
        if not os.access(default_base_dir, os.W_OK):
            print 'dest=file not able to write to directory "%s"' % default_base_dir
            sys.exit(2)
        st = datetime.datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ')
        print('%s writing files to queue specific sub-directories of: %s' % (st, default_base_dir) )

    conn = connectUserPass()
    #conn = connectAnonymous()
    channel = conn.channel()
    declare_ok = channel.queue_declare()
    queue = declare_ok.queue
    channel.queue_bind(queue,'glue2.applications','#')
    channel.queue_bind(queue,'glue2.compute','#')
    channel.queue_bind(queue,'glue2.computing_activities','#')
#    channel.queue_bind(queue,'glue2.computing_activity','#')
    st = datetime.datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ')
    q = ", ".join( ('glue2.applications', 'glue2.compute', 'glue2.computing_activities') )
    print('%s binding to queues: %s' % (st, q) )
    if args.dest == 'print':
        channel.basic_consume(queue,callback=callback_print)
    elif args.dest == 'file':
        channel.basic_consume(queue,callback=callback_file)
    elif args.dest == 'warehouse':
        channel.basic_consume(queue,callback=callback_warehouse)

    while True:
        channel.wait()
