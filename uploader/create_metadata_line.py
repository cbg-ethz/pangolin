#!/usr/bin/env python3

# Script to generate a single metadata line for WasteWater upload to SPSP

import os
import argparse
import sys
import re
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
    return parser.parse_args()

# samplename="KLZHCov220123"
# batchname="20220204_HVFYNDRXY"
# update="No"

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
    if (line[1]!="2697049"):
        sys.exit("Error: The metadata line for " + samplename + " has an unexpected species code")
    date = line[3].split("-")
    if (len(date)!=3):
        sys.exit("Error: The metadata line for " + samplename + " has a date with an unexpected format")
    if (date[0] not in meta.projyears):
        sys.exit("Error: The metadata line for " + samplename + " has a date with an unepxted year")
    cantonfull = line[4].split("/")
    if (cantonfull[2]==""):
        sys.exit("Error: The metadata line for " + samplename + " has a location general field with an empty canton")
    if (line[7]!="Environment"):
        sys.exit("Error: The metadata line for " + samplename + " has an unexpected isolation source description")
    # line[8] is not necessary as it's built from the cantonfull we already checked
    if (line[13]!="Surveillance"):
        sys.exit("Error: The metadata line for " + samplename + " has an unexpected sequencing purpose")
    if (line[14]!="Metagenome"):
        sys.exit("Error: The metadata line for " + samplename + " has an unexpected sequencing investigation type")
    if (line[15]==""):
        sys.exit("Error: The metadata line for " + samplename + " has an empty cram file field")
    cram = line[15].split(".")
    if (cram[1]!="cram"):
        sys.exit("Error: The metadata line for " + samplename + " has a cram file with an unexpected extension")
    # line[16] is already verified inline with a try/except
    if (line[18]!=meta.seqplatform):
        sys.exit("Error: The metadata line for " + samplename + " has a unexpected sequencing platform")
    if (line[19]!=meta.assembly):
        sys.exit("Error: The metadata line for " + samplename + " has a unexpected assembly method")
    if (line[21]!=meta.reportinglab):
        sys.exit("Error: The metadata line for " + samplename + " has a unexpected reporting lab name")
    if (line[22] not in meta.collectinglab.values()):
        sys.exit("Error: The metadata line for " + samplename + " has a unexpected collecting lab name")

def verify_strain_name(strain, meta):
    pieces = strain.split("/")
    if (len(pieces)!=4):
        sys.exit("Error: strain name " + strain + " does not have 4 fields separated by /")
    if (pieces[0]!="hCoV-19"):
        sys.exit("Error: strain name " + strain + " does not have the string hCoV-19 as first field")
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

def main():
    args = parse_args()
    if (args.samplename == "" or args.batchname == "" or args.outfile == ""):
        sys.exit("Error, empty sample name")

    if (args.update != "Yes" and args.update != "No"):
        sys.exit("Error: wrong value for option --update")

    try:
        locations = load_locations(meta.locations)
    except:
        sys.exit("Error: cannot load the locations file")
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
    if (len(mydata) == 5) and (mydata[4] == "624801"):
        mydata.append("Sierre/Noes (VS)")
    else:
        if (mydata[6] == "Basel (catchment area ARA Basel)"):
            mydata[6] = "Basel (BS)"
        if (mydata[6] == "Kanton Zürich"):
            mydata[6] = "Zürich (ZH)"
        if (mydata[6] == "Kanton Zürich/Promega"):
            mydata[6] = "Zürich (ZH)"

    cram = args.samplename+".cram"

    strain = 'hCoV-19/Switzerland/'+mydata[6].split(" ")[1].replace("(","").replace(")","")+"-ETHZ-"+mydata[0].replace("_","")+"/"+mydata[5].split("-")[0]
    verify_strain_name(strain, meta)
    sourcename = mydata[6]
    try:
        sampleinfo = meta.kit[mydata[3]]
    except:
        sys.exit("Error: cannot recognise the primer kit code:" + mydata[3])

    try:
        samplecov = str(round(float(read_qa(args.samplename, meta.qafile)[34])))
    except:
        sys.exit("Error: cannot load the qa file")

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

    fullline = args.update+"\t2697049\t"+strain+"\t"+mydata[5]+"\tEurope/Switzerland/"+mydata[6].split(" ")[1].replace("(","").replace(")","")+"\t"+mydata[6]+"\t\tEnvironment\tWastewater treatment plant\t"+sourcename+"\t"+catchment_size+"\t"+meta.population[mydata[4]]+"\t"+meta.region[mydata[4]]+"\tSurveillance\tMetagenome\t"+cram+"\t"+sampleinfo+"\t"+meta.seqcenter[meta.centerused]+"\t"+meta.seqplatform+"\t"+meta.assembly+"\t"+samplecov+"\t"+meta.reportinglab+"\t"+collectinglab+"\t"+authors+"\t"+meta.embargo+"\t\t\n"
    verify_mandatory_fields(fullline, meta, args.samplename)

    try:
        with open(args.outfile, "a") as file_object:
            file_object.write(fullline)
    except:
        sys.ext("Error: failed to write the metadata line for sample ", args.samplename, " in output file ", args.outfile)

if __name__ == '__main__':
    main()

