##TODO: wait for refactoring and use the test_id, so that you can directly match the auftragnummer

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
    elif "username" not in db_config.get("default").get("vineyard"):
        sys.exit("Error: missing 'username' field under 'vineyard' in config file")
    elif db_config["default"]["vineyard"].get("username") == None:
        sys.exit("Error: empty 'username' field under 'vineyard' in config file")
    elif "password" not in db_config.get("default").get("vineyard"):
        sys.exit("Error: missing 'password' field under 'vineyard' in config file")
    elif db_config["default"]["vineyard"].get("password") == None:
        sys.exit("Error: empty 'password' field under 'vineyard' in config file")
    else:
        return db_config["default"]["vineyard"]

##Connect to the database
def connect_to_db(db_config):
    db_connection = "dbname=\'" + db_config.get("dbname") + "\' user=\'" + db_config.get("username") + "\' host=\'" + db_config.get("host") + "\' password=\'" + db_config.get("password") + "\'"
    try:
        conn = psycopg2.connect(db_connection)
    except Exception as e:
        raise Exception("I am unable to connect to the database.", e)
    return(conn)

##Load the information from the database
def get_db_info(db_connection):
    DEST_TABLE_1 = "consensus_sequence"
    DEST_TABLE_2 = "viollier_test"
    # Get consensus_sequence from the database
    ## TODO: during refactoring this will need rework
    with db_connection.cursor() as cursor:
        cursor.execute("SELECT sample_name, ethid, coverage FROM " + DEST_TABLE_1)
        imported_data_1_tuples = cursor.fetchall()
    # Get the list od viollier samples
    with db_connection.cursor() as cursor:
        cursor.execute("SELECT ethid FROM " + DEST_TABLE_2)
        imported_data_2_tuples = cursor.fetchall()
    imported_data = [imported_data_1_tuples, imported_data_2_tuples]
    return imported_data 

def tuple_match(tpl, target):
    return [t for t in tpl if len(t) > len(target) and all(a == b for a, b in zip(t, target))]

##Match the data fetched from the database with the requests from viollier
def match_request(imported_data, req_file):
    with open(req_file) as fp:
        lines = fp.readlines()
    lines = [s.rstrip() for s in lines]
    #this gets the matching
    matching = {}
    for line in lines:
        matching[line] = None
        for t in imported_data[0]:
            if(line in t[0]):
                if (matching[line] == None):
                    matching[line] = [t]
                else:
                    matching[line].append(t)
    #This gets the requests without matches
    not_matching_names = [line for line in lines if matching[line] == None]
    matching_names = list(set(lines) - set(not_matching_names))
    if len(not_matching_names) > 0:
        log_warning(not_matching_names, warning_type = 'db')
        for key in not_matching_names:
            matching.pop(key, None)
    return [matching, imported_data[1]]

def filter_viollier(data_request):
    viollier_names = set([ name for name in data_request[0].keys() for db_viollier in data_request[1] if name in str(db_viollier) ])
    not_viollier = list(set(data_request[0].keys()) - viollier_names)
    if len(not_viollier) > 0:
        log_warning(not_viollier, warning_type = 'viollier')
        for key in not_viollier:
            data_request[0].pop(key, None)
    return data_request[0]

def filter_typo(viollier_data, max_matches):
    not_typo_names = [req for req in viollier_data.keys() if len(viollier_data[req]) < max_matches]
    typo_names = list(set(viollier_data.keys() - set(not_typo_names)))
    if len(typo_names) > 0:
        log_warning(typo_names, warning_type = 'typo')
        for key in typo_names:
            viollier_data.pop(key, None)
    return viollier_data

def filter_yield(clean_data):
    #Get al keys that have at least one item in values that show 0 coverage
    no_yield = []
    for key,value in clean_data.items():
        no_cov_items = 0
        for item in value:
            if item[2] == 0:
                no_cov_items = no_cov_items + 1
        if no_cov_items == len(value):
            no_yield.append(key)
    with_yield = clean_data.keys() - no_yield
    if len(no_yield) > 0:
        log_warning(no_yield, warning_type = 'yield')
    return with_yield

def create_tsv(yield_data, out_file):
    with open(out_file, 'w') as file_object:
        for item in list(yield_data):
            file_object.write('%s\n' % item)

def log_warning(samples, warning_type):
    if (warning_type == "db"):
        print('samples not in db: ' + str(samples))
    elif (warning_type == "viollier"):
        print('samples not from viollier: ' + str(samples))
    elif (warning_type == "yield"):
        print('samples with no yield: ' + str(samples))
    elif (warning_type == "typo"):
        print('samples with excessive matches: ' + str(samples))
    else:
        sys.exit('Error: unknown warning_type')

def main(args):
    db_config = read_config(args.db_config)
    db_connection = connect_to_db(db_config)
    imported_data = get_db_info(db_connection)
    try:
        db_connection.close()
    except Exception as e:
        raise Exception("I am unable to disconnect to the database.", e)
    data_request = match_request(imported_data, args.req_file)
    viollier_data = filter_viollier(data_request)
    clean_data = filter_typo(viollier_data, args$max_matches)
    yield_data = filter_yield(clean_data)
    create_tsv(yield_data, args.out_file)

parser = argparse.ArgumentParser(description='Validate Viollier raw data upload requests against the database')
parser.add_argument('--db_config', help = "File containing the yaml config with credentials to connect to the database")
parser.add_argument('--req_file', help = "File containing the requests from Viollier. One ID per line")
parser.add_argument('--out_file', help = "Filename to use to save only the ID that passed validation")
parser.add_argument('--max_matches', help = "Maximum number of allowed matches for a raw data upload request")
args = parser.parse_args()

main(args)

