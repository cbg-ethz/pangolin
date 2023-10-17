#!/usr/bin/env python3

import sys
import os
import glob
import io 
import re
import configparser
import argparse
import yaml
#import datetime

# parse command line
argparser = argparse.ArgumentParser(description="Build an excluse list for folders to sync on bfabric")
argparser.add_argument('-c', '--config', metavar='CONF', required=False,
	default='config/server.conf',
	type=str, dest='config', help="configuration file to load")
argparser.add_argument('-r', '--recent', metavar='ONLYAFTER', required=True,
	type=str, dest='recent', help="Only process batches whose date is posterior to the argument")
argparser.add_argument('-o', '--output', metavar='OUTFILE', required=True,
	type=str, dest='output', help="List of exclude patterns written to file ")
args = argparser.parse_args()


# Load defaults from config file
config = configparser.ConfigParser(strict=False) # non-strict: support repeated section headers
config.SECTCRE = re.compile(r'\[ *(?P<header>[^]]+?) *\]') # support spaces in section headers
with open(args.config) as f: config.read_string(f"""
[DEFAULT]
lab={os.path.splitext(os.path.basename(args.config))[0]}
basedir={os.getcwd()}
sampleset=sampleset
download=bfabric-downloads
badlist=
[_]
""" + f.read()) # add defaults + a pseudo-section "_" right before the ini file, to support bash-style section_header-less config files

lab=config['_']['lab'].strip("\"'")
'''name of the lab, to put in the batch YAML'''
basedir=config['_']['basedir'].strip("\"'")
'''base dircetory'''
expname=config['_']['expname'].strip("\"'")
'''projects name in SFTP'''
download=config['_']['download'].strip("\"'")
'''sub-directory to hold the unsorted downloaded datasets'''
sampleset=config['_']['sampleset'].strip("\"'")
'''sub-directory to hold the sorted samples set'''
badlist=(config['_']['badlist'].strip("\"'").split(',')) if len(config['_']['badlist']) else list()
'''folders to skip'''
forcelist=(config['_']['forcelist'].strip("\"'").split(',')) if len(config['_']['forcelist']) else list()
'''folders to use even with missing order'''


rxbatchdate=re.compile('batch\.(?P<date>\d+)_[^.]+\.yaml$')
rxdatelike=re.compile('_(?P<year>2\d{3})-(?P<month>[01]?\d)-(?P<day>[0-3]?\d)--') 

# glob all projects
if re.search('/p\d+/?$', expname):
	# project name included in the SFTP path, we don't need to scan
	projects=''
	extrapath=0
else:
	# whole storage in SFTP path, we need to scan for projects
	projects='p[0-9][0-9][0-9]*' 
	extrapath=1

#
# 0. easiest part: folders that we always ignore
#

excludelist=badlist


#
# 1. gather all batches
#

for bname in glob.glob(os.path.join(basedir,sampleset,'batch.*.yaml')):
	# check date
	if args.recent < rxbatchdate.search(bname).groupdict()['date']:
		continue

	with open(bname, 'rt') as yml:
		b = yaml.safe_load(yml)
	if (b['type'] != 'bfabric') or (b['lab'] != lab):
		continue

	# folders
	excludelist += b['folder'] if type(b['folder']) is list else [b['folder']]
	# fastQC folder
	for fqc in (b['fastqcfolder'] if type(b['fastqcfolder']) is list else [b['fastqcfolder']]):
		if fqc is None:
			continue
		excludelist+= [os.path.dirname(fqc)]


#
# 2. other folders
#

for srch in glob.glob(os.path.join(basedir,download,projects,'*')):
	d=os.path.basename(srch)
	if d in excludelist:
		continue

	# look for date-like thingy
	if m := rxdatelike.search(d):
		g=m.groupdict()
		date=f"{g['year']}{g['month']}{g['day']}"
		# check date
		if args.recent < date:
			continue

		excludelist+=[d]
		continue

	print(d, file=sys.stderr)

with open(args.output, "w") as of:
	for x in excludelist:
		print(f"{x}/", file=of)
