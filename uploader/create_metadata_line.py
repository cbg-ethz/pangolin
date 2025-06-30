#!/usr/bin/env python3

# Script to generate a single metadata line for WasteWater upload to SPSP

import os
import argparse
import sys
import re
import requests
sys.path.append("/app/uploader")
import submission_metadata as meta

# parse command line
def parse_args():
    """ Set up the parsing of command-line arguments """

    parser = argparse.ArgumentParser(description='Validate Viollier raw data upload requests against the database')
    parser.add_argument('-s', '--samplename', required=True, help = "Samplename of the sample to upload")
    parser.add_argument('-b', '--batchname', required=True, help = "Batchname of the batch to upload")
    parser.add_argument('-u', '--update', required=False, default="No", help = "If the field _is_assembly_update_ should be Yes or No")
    parser.add_argument('-o', '--outfile', required=True, help="metadata output file to write the line to")
    parser.add_argument('-t', '--wisedb_token', required=True, help="Token used for connecting to WiseDB to retrieve the dPCR values")
    parser.add_argument('-f', '--failed', required=True, help="Filename where to store the list of failed samples")
    parser.add_argument('-d', '--batchfile_dir', required=True, help="Path to the directory containing the local copy of the vpipe sampleset batch yaml files")
    return parser.parse_args()

# samplename="KLZHCov220123"
# batchname="20220204_HVFYNDRXY"
# update="No"


def get_delivery_folder_name(batchname, batchfile_dir):
    batchfiles = os.listdir(batchfile_dir)
    my_batchfile = "batch." + batchname + ".yaml"
    if my_batchfile in batchfiles:
        with open(batchfile_dir + "/" + my_batchfile) as f:
            batchfile_content = f.read()
    else:
        sys.exit("ERROR: cannot find the batch yaml file for batch " + batchname)
    match = re.search(r'^folder:\s*(.+)$', batchfile_content, re.MULTILINE)
    if match:
        folder_value = match.group(1)
        print("Extracted folder:", folder_value)
    else:
        sys.exit("ERROR: the batch yaml file " + my_batchfile + " has no folder definition.")
    return folder_value


def get_seqplatform_from_delivery(delivery_name, accepted_seqplatform):
    for platform_code in accepted_seqplatform:
        if platform_code.lower() in delivery_name.lower():
            return platform_code
    sys.exit("ERROR: found no accepted platform string in delivery name " + delivery_name)


def write_failed(samplename, reason, failed_file):
    text = samplename + "\t" + reason + "\n"
    with open(failed_file, "a") as myfile:
        myfile.write(text)


def remove_failed(samplename, failed_file):
    # Read all lines from the file
    with open(failed_file, "r") as f:
        lines = f.readlines()
    # Filter out lines where the first column matches match_str
    filtered_lines = []
    for line in lines:
        # Remove trailing newline characters
        stripped_line = line.rstrip("\n")
        # Split the line on tab delimiter
        columns = stripped_line.split("\t")
        # Check if the first column matches the target string exactly
        if columns and columns[0] == samplename:
            continue  # Skip this line
        filtered_lines.append(line)
    # Write the filtered lines back to the file
    with open(failed_file, "w") as f:
        f.writelines(filtered_lines)


def load_dpcr(token, wisedb_dpcr_url, exceptions, date, eawag_id, meta):
    try:
        ara_id = meta.ara_id[eawag_id]
    except:
        sys.exit("Error: Cannot find an ARA ID associated to EAWAG ID " + eawag_id)
    if ara_id == "":
        sys.exit("Error: Empty ARA ID associated to EAWAG ID " + eawag_id)
    if len(date.split("-")) != 3:
        sys.exit("Error: the provided date does not appear to have '-' as a separator")
    url = f"{wisedb_dpcr_url}/?ara_id={ara_id}&from={date}&to={date}"
    headers = {
    "accept": "text/csv",
    "Authorization": f"Token {token}"
    }
    response = requests.get(url, headers=headers)
    output = response.text
    output = output.split("\r\n")
    dpcr_dict = {}
    for line in output:
        values = line.split(',')
        # Ensure there are enough elements (at least 23 positions)
        if len(values) >= 23:
            key = values[7].strip()
            value = values[22].strip()
            if key == "target" and value == "load":
                continue
            try:
                float_value = float(value)
            except ValueError:
                sys.exit("Error: failed to convert the dPCR value to float. Please check: ara_id:" + ara_id + "; date: " + date + "; target: ", + key)
            if key in dpcr_dict:
                existing_value = dpcr_dict[key]
                dpcr_dict[key] = (existing_value + float_value) / 2
            else:
                dpcr_dict[key] = float_value
    # Temporary dictionary to accumulate sum and count for each canonical key
    temp = {}
    for key, value in dpcr_dict.items():
    # Check if the key is in any of the exception lists
        for exception_key, additional_keys in exceptions.items():
            if key in additional_keys:
                key = exception_key
                break  # Use the first matching exception key
        # If the canonical key already exists, accumulate the value
        if key in temp:
            current_sum, current_count = temp[key]
            temp[key] = (current_sum + value, current_count + 1)
        else:
            temp[key] = (value, 1)
    # Build the updated dictionary by averaging accumulated values
    dpcr_dict = {k: total / count for k, (total, count) in temp.items()}
    return dpcr_dict

def load_locations(locationfile):
    with open(locationfile, 'r') as file:
        #locations = file.readlines()
        myline = [line.rstrip() for line in file]
        myline = [ " ".join(element.split()) for element in myline ]
    locations = [re.split(r'\t|\s', line) for line in myline]
    return locations

def load_timeline(timelinefile, samplename):
    with open(timelinefile, "r") as file:
        myline = [line.rstrip() for line in file]
        timeline = [re.split(r'\t', line) for line in myline]
        for line in timeline:
            if (samplename in line):
                timeinfo = line
    return timeinfo

def read_qa(samplename, qafile):
    with open(qafile, 'r') as file:
        myline = [line.rstrip() for line in file]
    sampleline = [re.split(r',', line) for line in myline]
    for line in sampleline:
        if (samplename in line):
            samplecov = line
    return samplecov

def verify_mandatory_fields(line, meta, samplename):
    line = line.split("\t")
    taxons = line[1].split(",")
    for tax in taxons:
        if (tax not in meta.taxon_ids.values()):
            sys.exit("Error: The metadata line for " + samplename + " has an unexpected species code (taxon id)")
    date = line[3].split("-")
    if (len(date)!=3):
        sys.exit("Error: The metadata line for " + samplename + " has a date with an unexpected format")
    if (date[0] not in meta.projyears):
        sys.exit("Error: The metadata line for " + samplename + " has a date with an unepxted year")
    cantonfull = line[4].split("/")
    if (cantonfull[2]==""):
        sys.exit("Error: The metadata line for " + samplename + " has a location general field with an empty canton")
    if (line[7]!="Wastewater treatment plant"):
        sys.exit("Error: The metadata line for " + samplename + " has an unexpected isolation source detailed")
    # line[8] is not necessary as it's built from the cantonfull we already checked
    if (line[12]!="Surveillance"):
        sys.exit("Error: The metadata line for " + samplename + " has an unexpected sequencing purpose")
    if (line[13]!="Metagenome"):
        sys.exit("Error: The metadata line for " + samplename + " has an unexpected sequencing investigation type")
    if (line[14]==""):
        sys.exit("Error: The metadata line for " + samplename + " has an empty cram file field")
    cram = line[14].split(".")
    if (cram[1]!="cram"):
        sys.exit("Error: The metadata line for " + samplename + " has a cram file with an unexpected extension")
    # line[16] is already verified inline with a try/except
    if (line[19]!=meta.assembly):
        sys.exit("Error: The metadata line for " + samplename + " has a unexpected basecaller")
    #if (line[21]!=meta.reportinglab):
    #    sys.exit("Error: The metadata line for " + samplename + " has a unexpected reporting lab name")
    if (line[20] not in meta.collectinglab.values()):
        sys.exit("Error: The metadata line for " + samplename + " has a unexpected collecting lab name")

def verify_strain_name(strain, meta):
    pieces = strain.split("/")
    if (len(pieces)!=4):
        sys.exit("Error: strain name " + strain + " does not have 4 fields separated by /")
    #if (pieces[0] not in meta.tracked_viruses.keys()):
    #    sys.exit("Error: strain name " + strain + " does not have any accepted tracked virus as first field")
    if (pieces[1]!="Switzerland"):
        sys.exit("Error: strain name " + strain + " does not have the string Switzerland as second field")
    if (pieces[3] not in meta.projyears):
        sys.exit("Error: strain name " + strain + " does not have an accepted year as second field")
    pieces2 = pieces[2].split("-")
    if (len(pieces2)!=3):
        sys.exit("Error: strain name " + strain + " does not have 3 elements separated by - in the third field")
    if (pieces2[0] not in meta.cantons):
        sys.exit("Error: strain name " + strain + " does not have an accepted canton code")
    if (pieces2[1] not in meta.submitting):
        sys.exit("Error: strain name " + strain + " does not have an accepted submitting lab")
    if (pieces2[2] == ""):
        sys.exit("Error: strain name " + strain + " has an empty sample name")

def get_authors_by_date(meta, collectingcode, center, ethz, date):
    try:
        date = int(date)
    except:
        sys.exit("Error: found a non-numeric date in the timeline file")
    allkeys = meta.authors.keys()
    for k in allkeys:
        if (collectingcode in k):
            try:
                startdate = int(k.split("_")[1])
            except:
                sys.exit("Error: found a non-numeric date in the authors settings for " + collectingcode)
            try:
                enddate = int(k.split("_")[2])+1
            except:
                sys.exit("Error: found a non-numeric date in the authors settings for " + collectingcode)
            if (date in range(startdate, enddate)):
                collectingauthorcode = k
        if (center in k):
            try:
                startdate = int(k.split("_")[1])
            except:
                sys.exit("Error: found a non-numeric date in the authors settings for " + center)
            try:
                enddate = int(k.split("_")[2])+1
            except:
                sys.exit("Error: found a non-numeric date in the authors settings for " + center)
            if (date in range(startdate, enddate)):
                centerauthorcode = k
        if (ethz in k):
            try:
                startdate = int(k.split("_")[1])
            except:
                sys.exit("Error: found a non-numeric date in the authors settings for " + ethz)
            try:
                enddate = int(k.split("_")[2])+1
            except:
                sys.exit("Error: found a non-numeric date in the authors settings for " + ethz)
            if (date in range(startdate, enddate)):
                ethzauthorcode = k
    try:
        collectingauthorcode
    except:
        sys.exit("Error: no date range available for authors of " + collectingcode + " for date " + str(date))
    try:
        centerauthorcode
    except:
        sys.exit("Error: no date range available for authors of " + center + " for date " + str(date))
    try:
        ethzauthorcode
    except:
        sys.exit("Error: no date range available for authors of " + ethz + " for date " + str(date))
    return [collectingauthorcode, centerauthorcode, ethzauthorcode]


def string_in_file(search_str, filename):
    try:
        with open(filename, "r") as file:
            for line in file:
                if search_str in line:
                    return True
    except FileNotFoundError:
        print(f"Error: The file '{filename}' does not exist.")
        return False
    return False


def main():
    args = parse_args()
    if (args.samplename == "" or args.batchname == "" or args.outfile == ""):
        sys.exit("ERROR: empty sample name")

    if (args.update != "Yes" and args.update != "No"):
        sys.exit("ERROR: wrong value for option --update")

    if not os.path.exists(args.failed):
        open(args.failed, 'a').close()

    try:
        locations = load_locations(meta.locations)
    except:
        sys.exit("ERROR: cannot load the locations file")
    try:
        locations[locations.index(['KLZHCov', 'Kanton', 'Zürich'])] = ['KLZHCov', 'Zürich', "(ZH)"]
        locations[locations.index(['KLZHCov_Promega', 'Kanton', 'Zürich/Promega'])] = ['KLZHCov_Promega', 'Zürich', "(ZH)"]
        #locations[locations.index(['Ba', 'Basel', '(catchment', 'area', 'ARA', 'Basel)'])] = ['Ba', 'Basel', '(BS)']
    except:
        sys.exit("We have exceptions in place for KLZHCov, KLZHCov_Promega. It looks like one of them is not anymore in the location list")
    try:
        mydata = load_timeline(meta.timelinefile, args.samplename)
    except:
        sys.exit("Error: cannot load the timeline file")
    if (len(mydata) == 6) and (mydata[4] in meta.exceptions.keys()):
        mydata.append(meta.exceptions[mydata[4]])
    elif (len(mydata) == 4) and (mydata[0].split("_")[0] in meta.exceptions.keys()):
        name = mydata[0].split("_")[0]
        date_list = list(args.batchname.split("_")[0])
        date = ""
        for i in range(0, len(date_list)):
            if i in [4, 6]:
                date = date + "-" + date_list[i]
            else:
                date = date + date_list[i]
        mydata.extend([name, date, meta.exceptions[name]])
    else:
        if (mydata[6] == "Basel (catchment area ARA Basel)"):
            mydata[6] = "Basel (BS)"
        if (mydata[6] == "Kanton Zürich"):
            mydata[6] = "Zürich (ZH)"
        if (mydata[6] == "Kanton Zürich/Promega"):
            mydata[6] = "Zürich (ZH)"
    sourcename = mydata[6]
    try:
        sampleinfo = meta.kit[mydata[3]]
    except:
        sys.exit("Error: cannot recognise the primer kit code:" + mydata[3])

    #try:
    #    samplecov = str(round(float(read_qa(args.samplename, meta.qafile)[34])))
    #except:
    #    sys.exit("Error: cannot load the qa file")

    try:
        collectingcode = meta.collecting_lab[mydata[4]]
    except:
        sys.exit("Error: the provided plant " + mydata[4] + " has no associated collecting lab code in the configuration")

    try:
        collectinglab = meta.collectinglab[collectingcode]
    except:
        sys.exit("Error: the provided lab code " + collectingcode + " has no associated collecting lab name in the configuration")

    authorscode = get_authors_by_date(meta, collectingcode, meta.centerused, "ethz", mydata[5].replace("-",""))

    try:
        authors = meta.authors[authorscode[0]] + ", " + meta.authors[authorscode[1]] + ", " + meta.authors[authorscode[2]]
    except:
        sys.exit("Error: the authors list cannot be completed, either for a missing collecting lab code (" + collectingcode + "), a missing sequencing center (" + meta["centerused"] + ") or a missing entry for ETHZ")

    try:
        catchment_size = str(round(float(meta.size[mydata[4]])))
    except ValueError:
        catchment_size = ""

    # Get all viruses that are present in the sample by checking if the wisedb has dPCR values or not for the sample
    load = load_dpcr(args.wisedb_token, meta.wisedb_dpcr_url, meta.exceptions_dpcr, mydata[5], mydata[4], meta)
    if len(load) == 0:
        print("No load values on wisedb for sample " + mydata[0])
        if not string_in_file(mydata[0], args.failed):
            write_failed(mydata[0], "no load", args.failed)
        sys.exit(200)
    all_tracked_viruses_present = all(element in load.keys() for element in meta.tracked_viruses.keys())
    if not all_tracked_viruses_present:
        print("No load values for at least one tracked virus on wisedb for sample " + mydata[0])
        if not string_in_file(mydata[0], args.failed):
            write_failed(mydata[0], "Missing load for a tracked virus", args.failed)
        sys.exit(200)
    all_subtypes = []
    all_taxids = []
    for virus in load.keys():
        if virus not in meta.tracked_viruses.keys():
            print("Skipping virus " + virus + " because not in the list of tracked viruses for upload")
            continue
        else:
            virus_shortname = [meta.tracked_viruses[virus]]
            if virus_shortname == ["rsv"]:
                print("Found exception: rsv may include RSVA or RSVB for sequencing. Retrieving which")
                for key, value in meta.rsv_kits.items():
                    if mydata[3] in value:
                        virus_shortname = [key]
            # If the above code cannot find if we are talking about RSVA or RSVB, it means that virus_shortname stays "rsv". Below we test that to throw the error.
            if virus_shortname == ["rsv"]:
                print("Error: could not find if the detected rsv is RSVA or RSVB from the library prep kit of sample " + mydata[0])
                if not string_in_file(mydata[0], args.failed):
                    write_failed(mydata[0], "RSVA-B not specified", args.failed)
                sys.exit(200)
            if virus_shortname == ["rsva_and_b"]:
                virus_shortname = ["rsva", "rsvb"]
        if load[virus] > 0:
            for subtype in virus_shortname:
                print("Found viral load for virus " + subtype + " in sample " + mydata[0] + ". Adding the metadata line")
                all_subtypes.append(subtype)
                try:
                    taxid = meta.taxon_ids[subtype]
                except:
                    print("Error: could not find the taxon id associated to subtype " + subtype)
                    if not string_in_file(mydata[0], args.failed):
                        write_failed(mydata[0], "Can't find the taxon id of the subtype", args.failed)
                    sys.exit(200)
                all_taxids.append(taxid)
        else:
            if virus_shortname == ["rsva", "rsvb"]:
                v = "rsv"
            else:
                v = virus_shortname[0]
            print("Info: Viral load zero for virus " + v + " in sample " + mydata[0] + ". The virus will not be reported")
            
    delivery_name = get_delivery_folder_name(args.batchname, args.batchfile_dir)
    platform = get_seqplatform_from_delivery(delivery_name, meta.accepted_seqplatform)
    platform = meta.seqplatform_match[platform.lower()]

    cram = args.samplename+".cram"
    strain = "-".join(all_subtypes)+'/Switzerland/'+mydata[6].split(" ")[1].replace("(","").replace(")","")+"-ETHZ-"+mydata[0].replace("_","").replace("-","")+"/"+mydata[5].split("-")[0]
    verify_strain_name(strain, meta)
    fullline = args.update+"\t"+",".join(all_taxids)+"\t"+strain+"\t"+mydata[5]+"\tEurope/Switzerland/"+mydata[6].split(" ")[1].replace("(","").replace(")","")+"\t"+mydata[6]+"\t\tWastewater treatment plant\t"+sourcename+"\t"+catchment_size+"\t"+meta.population[mydata[4]]+"\t"+meta.region[mydata[4]]+"\tSurveillance\tMetagenome\t"+cram+"\t\t"+sampleinfo+"\t"+meta.seqcenter[meta.centerused]+"\t"+platform+"\t"+meta.assembly+"\t"+collectinglab+"\t"+authors+"\t"+meta.embargo+"\t"+meta.projnum+"\t\t\t\t\n"
    verify_mandatory_fields(fullline, meta, args.samplename)
    try:
        with open(args.outfile, "a") as file_object:
            file_object.write(fullline)
        if string_in_file(mydata[0], args.failed):
            print("Successfully created metadata line for previously-failed sample " + mydata[0]+ ". Removing from failed file")
            remove_failed(mydata[0], args.failed)
    except:
        sys.exit("Error: failed to write the metadata line for sample " + args.samplename + ", virus " + virus_shortname + ", in output file ", args.outfile)
if __name__ == '__main__':
    main()

