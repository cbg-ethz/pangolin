#!/usr/bin/env python3

#Script too validate the raw data upload requests we receive from Viollier.
#The validation comprises the following steps:
#1) check if the requested samples are in the database
#2) check if the requested samples are Viollier samples
#3) check if the requested samples have excessive matches that can be due to a broken entry or too few characters
#4) check all matches for the requested sample have 0 coverage
#The script reports any sample name filtered by the logic and creates a new request file with only the samples that pass the filter

import psycopg2
import os
import argparse
import yaml
import netrc
import sys

# parse command line
def parse_args():
    """ Set up the parsing of command-line arguments """

    parser = argparse.ArgumentParser(description='Validate Viollier raw data upload requests against the database')
    parser.add_argument('-c', '--db_config', metavar='YAML', required=True, help = "File containing the yaml config with credentials to connect to the database")
    parser.add_argument('-i', '--req_file', metavar='TSV', required=True, help = "File containing the requests from Viollier. One ID per line")
    parser.add_argument('-o', '--out_file', metavar='TSV', required=True, help = "Filename to use to save only the ID that passed validation")
    return parser.parse_args()


##Get db credentials
def read_config(configfile):
    with open(configfile) as file:
        db_config = yaml.load(file, Loader = yaml.FullLoader)
    #validating the configuration
    if "default" not in db_config:
        sys.exit("Error: missing 'default' field in config file")
    elif "vineyard" not in db_config.get("default"):
        sys.exit("Error: missing 'vineyard' field in config file")
    elif "host" not in db_config.get("default").get("vineyard"):
        sys.exit("Error: missing 'host' field under 'vineyard' in config file")
    elif db_config["default"]["vineyard"].get("host") == None:
        sys.exit("Error: empty 'host' field under 'vineyard' in config file")
    elif "dbname" not in db_config.get("default").get("vineyard"):
        sys.exit("Error: missing 'dbname' field under 'vineyard' in config file")
    elif db_config["default"]["vineyard"].get("dbname") == None:
        sys.exit("Error: empty 'dbname' field under 'vineyard' in config file")

    username=password=None
    netrc_creds=netrc.netrc().authenticators(db_config["default"]["vineyard"]["host"])
    if netrc_creds is None:
        print(f"warning: host {db_config['default']['vineyard']['host']} not in ~/.netrc", file=sys.stderr)
    else:
        username,password=netrc_creds[0::2]

    if "username" not in db_config.get("default").get("vineyard"):
        if username is not None:
            db_config["default"]["vineyard"]["username"] = username
        else:
            sys.exit(f"Error: missing 'username' field both under 'vineyard' in config file and for {db_config['default']['vineyard'].get('host')} in .netrc")
    elif db_config["default"]["vineyard"].get("username") == None:
        sys.exit("Error: empty 'username' field under 'vineyard' in config file")

    if "password" not in db_config.get("default").get("vineyard"):
        if password is not None:
            db_config["default"]["vineyard"]["password"] = password
        else:
            sys.exit(f"Error: missing 'password' field both under 'vineyard' in config file and for {db_config['default']['vineyard'].get('host')} in .netrc")
    elif db_config["default"]["vineyard"].get("password") == None:
        sys.exit("Error: empty 'password' field under 'vineyard' in config file")

    return db_config["default"]["vineyard"]

##Connect to the database
def connect_to_db(db_config):
    try:
        conn = psycopg2.connect(
            host= db_config.get("host"),
            database=db_config.get("dbname"),
            user=db_config.get("username"),
            password=db_config.get("password"),
            port=db_config.get("port", '5432'),
        )

    except Exception as e:
        raise Exception("I am unable to connect to the database.", e)
    return(conn)

##Load the information from the database
def get_db_info(db_connection):
    DEST_TABLE_1 = "viollier_metadata"
    DEST_TABLE_2 = "consensus_sequence"
    DEST_TABLE_3 = "consensus_sequence_meta"
    # Get the anonymised ethid from the sample number
    with db_connection.cursor() as cursor:
        cursor.execute("SELECT sample_number, ethid FROM " + DEST_TABLE_1)
        imported_data_1_tuples = cursor.fetchall()
    # Get the sample_name from the ethid
    with db_connection.cursor() as cursor:
        cursor.execute("SELECT sample_name, ethid FROM " + DEST_TABLE_2)
        imported_data_2_tuples = cursor.fetchall()
    # Get the coverage
    with db_connection.cursor() as cursor:
        cursor.execute("SELECT sample_name, coverage_mean FROM " + DEST_TABLE_3)
        imported_data_3_tuples = cursor.fetchall()
    imported_data = [imported_data_1_tuples, imported_data_2_tuples, imported_data_3_tuples]
    return imported_data 

def tuple_match(tpl, target):
    return [t for t in tpl if len(t) > len(target) and all(a == b for a, b in zip(t, target))]

def filter_viollier(imported_data, req_file):
    with open(req_file) as fp:
        lines = fp.readlines()
    lines = [s.rstrip() for s in lines]
    #viollier_samples has the couples: [requested, ethid] of all requested that match the viollier sample names
    viollier_samples = [ [line, name[1]] for line in lines for name in imported_data[0] if line == str(name[0]) ]
    viollier_names = [ name[0] for name in viollier_samples ]
    #This returns a list of tuple, each showing, in this order: requested, ethid, sample_name
    viollier_sample_name = [ [*ethid, name[0]] for ethid in viollier_samples for name in imported_data[1] if ethid[1] == name[1] ]
    not_viollier = list(set(lines) - set(viollier_names))
    if len(not_viollier) > 0:
        log_warning(not_viollier, warning_type = 'viollier')

     return viollier_sample_name

def filter_yield(viollier_data, imported_data):
    #Get all keys that have at least one item in values that show 0 coverage
    no_yield = []

    viollier_covs = [ (*name, coverage[1]) for name in viollier_data for coverage in imported_data[2] if name[2] == coverage[0] ]
    viollier_requested = [ name[2] for name in viollier_data ]
    viollier_with_cov = [ name[0] for name in viollier_covs ]
    
    viollier_no_cov = [x for x in viollier_requested if x not in viollier_with_cov]
    if len(viollier_no_cov) > 0:
        log_warning(viollier_no_cov, warning_type = 'missing yield')

    viollier_no_yield = [x for x in viollier_covs if x[3] == 0]
    if len(viollier_no_yield) > 0:
        log_warning(viollier_no_yield, warning_type = '0 yield')

    viollier_with_yield = [x for x in viollier_covs if x[3] > 0]
    

    return viollier_with yield

def create_tsv(yield_data, out_file):
    with open(out_file, 'w') as file_object:
        for item in list(yield_data):
            file_object.write(item[0] + '\t' + str(item[1]) + '\n')

def log_warning(samples, warning_type):
    if (warning_type == "viollier"):
        print('samples not from viollier: ' + str(samples))
    elif (warning_type == "missing yield"):
        print('samples with missing yield: ' + str(samples))
    elif (warning_type == "0 yield"):
        print('samples with no yield: ' + str(samples))
    else:
        sys.exit('Error: unknown warning_type')

def main():
    args = parse_args()
    db_config = read_config(args.db_config)
    db_connection = connect_to_db(db_config)
    imported_data = get_db_info(db_connection)
    try:
        db_connection.close()
    except Exception as e:
        raise Exception("I am unable to disconnect to the database.", e)

    viollier_data = filter_viollier(imported_data, args.req_file)
    yield_data = filter_yield(viollier_data, imported_data)
    create_tsv(yield_data, args.out_file)

if __name__ == '__main__':
    main()

