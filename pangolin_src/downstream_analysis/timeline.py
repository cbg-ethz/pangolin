#!/usr/bin/env python3

import numpy as np
import pysam
import pandas as pd
import json
import glob
import argparse
import re
from datetime import datetime


"""
Prepare timeline.tsv file from samples.tsv
"""

def find_location(code):
    location = {
        '05': 'Lugano',
        '10': 'Zurich',
        '15': 'Basel',
        '16': 'Geneva',
        '17': 'Chur',
        '25': 'Laupen'
    }

    return location.get(code, 'Unknown')


def main(path_to_samples_tsv, path_to_output):
    timeline_tsv = []
    for path_single_sample_tsv in path_to_samples_tsv:
        sample_tsv = pd.read_csv(path_single_sample_tsv, sep='\t', header=None)
        for index, row in sample_tsv.iterrows():
            submission_Id = row[0]
            batch = path_single_sample_tsv.split('/')[-2]
            reads = row[2]
            reference = row[3]
            primerProtocol = f'Eawag-2024-{row[3]}'
            location_code = submission_Id.split('_')[1]
            date_string = '-'.join(submission_Id.split('_')[2:])
            date = datetime.strptime(date_string, "%Y-%m-%d")
            location = find_location(location_code)

            single_row = {
                "submissionId" : submission_Id,
                "batch" : batch,
                "reads" : reads,
                "reference" : reference,
                "primerProtocol" : primerProtocol,
                "location_code" : location_code,
                "date" :date,
                "location" :location

            }
            timeline_tsv.append(single_row)
    timeline_tsv_output = pd.DataFrame(timeline_tsv)

    timeline_tsv_output.to_csv(
        f'{path_to_output}/timeline.tsv', sep='\t',
        index=False)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Process samples.tsv files and produce timeline.tsv')
    parser.add_argument('--path_to_samples_tsv', nargs='+',
                        help='input directory containing samples.tsv files')
    parser.add_argument('--path_to_output', nargs='+',
                        help='input directory containing samples.tsv files')
    args = parser.parse_args()

    main(args.path_to_samples_tsv, args.path_to_output)