#!/usr/bin/env python3

import numpy as np
import pysam
import pandas as pd
import json
import glob
import argparse
import re

""" 
Prepare TSV file in the format which is needed for uploading data to GenSpectrum.

"""

THRESHOLD_VALUE = 0.02
RARE_MUTATION_LIMIT_DAYS = 2
COVERAGE_THRESHOLD = 30  # coverage depth below which mutation is treated as missing value


# Processing vcf files

# Iterate over multiple VCF files and use the name of the directory containing each file as the sample name
def load_convert(vcf_path, sample_name, reference):
    ''' function to load a vcf and output a Pandas dataframe'''
    # Create a VariantFile object
    vcf_file = pysam.VariantFile(vcf_path)
    # record rows for df
    rows = []

    # iterate over the records (variants) in the VCF file
    for record in vcf_file:
        if record.chrom == reference:
            # iterate over possible mutated positions
            for alt in record.alts:
                # Take allele frequences (AF) from INFO
                af = record.info.get('AF')
                # put results in rows
                row = {
                    'sample': sample_name,
                    'pos': record.pos,
                    'ref': record.ref,
                    'alt': alt,
                    'af': af
                }
                rows.append(row)
    # close the VCF file
    vcf_file.close()
    # convert to dataframe
    df_out = pd.DataFrame(rows)

    return df_out


def process_multiple_vcfs(input_directories, reference):
    vcf_files_multiple = []
    for input_dir in input_directories:
        print(input_dir)
        # get list of VCF files in the input directory
        vcf_files = glob.glob(input_dir, recursive=True)
        vcf_files_multiple.extend(vcf_files)
    print(vcf_files_multiple)
    # record rows for df
    rows = []
    # iterate over the VCF files from the list
    for vcf_file in vcf_files_multiple:
        print(vcf_file)
        # extract the sample name from the directory name
        sample_name = vcf_file.split('/')[-5]
        # load the VCF and convert to dataframe
        df = load_convert(vcf_file, sample_name, reference)
        # append the dataframe to the list of rows
        rows.append(df)

    # concatenate all dataframes
    df_out = pd.concat(rows, axis=0, ignore_index=True)

    return (df_out)


def create_mut_freq_dict(col):
    # create empty dictionary to hold the mutation proportions for this sample
    mutation_proportions = {}
    # iterate through all columns except the 'sample' column
    for mutation, frequency in col.items():
        if pd.isna(frequency):
            mutation_proportions[mutation] = None
        else:
            mutation_proportions[mutation] = frequency

    # convert dictionary to a json-formatted string with double quotes
    mutation_json = json.dumps(mutation_proportions, ensure_ascii=False)
    # print(mutation_json)
    return mutation_json


def extract_cov(coverage_tsv_file, sample_name, reference):
    # read coverage.tsv file
    coverage_file = pd.read_csv(coverage_tsv_file, sep='\t', usecols=['ref', 'pos', f'{sample_name}/date'])
    # coverage.tsv files are 1-based
    coverage_file = coverage_file[coverage_file['ref'] == reference]
    position = pd.DataFrame(coverage_file['pos'])
    coverage = pd.DataFrame(coverage_file[f'{sample_name}/date']).rename(columns={f'{sample_name}/date': 'coverage'})
    total_coverage = pd.concat([position, coverage], axis=1).set_index('pos')
    total_coverage['sample'] = sample_name
    # print(total_coverage.head())
    return total_coverage


def process_multiple_coverage_files(input_directories, reference_genome):
    coverage_files_multiple = []
    for input_dir in input_directories:

    # get list of coverage files in the input directory
        coverage_files = glob.glob(input_dir, recursive=True)
        coverage_files_multiple.extend(coverage_files)

    rows = []
    for coverage_file in coverage_files_multiple:
        # extract the sample name from the directory name
        sample_name = coverage_file.split('/')[-4]
        # print(sample_name)

        df = extract_cov(coverage_file, sample_name, reference=reference_genome)
        # append the dataframe to the list of dataframes
        rows.append(df)

    coverage_out = pd.concat(rows, axis=0, ignore_index=False)
    return coverage_out


def main(path_to_vcf, timeline_tsv, path_to_coverage, reference):
    # Process multiple vcfs and produce data frame
 #   print(path_to_vcf)
    output_multiple_vcfs = process_multiple_vcfs(path_to_vcf, reference)
    # print(output_multiple_vcfs)
    output_multiple_vcfs['ref_pos'] = output_multiple_vcfs['ref'] + output_multiple_vcfs['pos'].astype(str)
    output_multiple_vcfs['mut'] = output_multiple_vcfs['ref_pos'] + output_multiple_vcfs['alt']
    output_multiple_vcfs['freq_total'] = output_multiple_vcfs['af']
    output_multiple_vcfs = output_multiple_vcfs[['sample', 'mut', 'freq_total']].drop_duplicates()
    mut_freq = output_multiple_vcfs.pivot_table(values='freq_total',
                                                index='mut',
                                                columns='sample')


    # For positions where coverage is > threshold, set missing values to zeros (mutation is not present)
    collected_coverage = process_multiple_coverage_files(path_to_coverage, reference)
    collected_coverage = collected_coverage.pivot_table(values='coverage',
                                                        index='pos',
                                                        columns='sample')

    mut_freq.columns = mut_freq.columns.astype(str)
    for mut in mut_freq.index:
        position = int(re.findall(r'\d+', mut)[0])

        for sample in mut_freq.columns:
            # coverage_at_position = collected_coverage[(collected_coverage.index == position) & (collected_coverage["sample"] == sample)]
            if (collected_coverage.loc[position, sample] >= COVERAGE_THRESHOLD):
                if (pd.isna(mut_freq.loc[mut, sample])):
                    mut_freq.loc[mut, sample] = 0.0
            # if coverage at the position is below the COVERAGE_THRESHOLD -> missing value
            else:
                mut_freq.loc[mut,sample] = np.nan

        # We keep only mutations that appear above THRESHOLD_VALUE for at least RARE_MUTATION_LIMIT_DAYS days
    nonzero_counts = ((mut_freq > THRESHOLD_VALUE) & pd.notna(mut_freq)).sum(axis=1)
    rare_mutations = nonzero_counts[nonzero_counts < RARE_MUTATION_LIMIT_DAYS]
    # Drop the rows with rare mutations from the DataFrame
    rare_mutations.index = rare_mutations.index.astype(str)
    mut_freq.drop(index=rare_mutations.index, inplace=True)


    tsv_samples_locations = pd.read_csv(timeline_tsv, sep='\t',
                                        usecols=["submissionId", "date", "location", "primerProtocol", "reference"])

    nucleotide_mut_freq = mut_freq.apply(create_mut_freq_dict, axis=0)

    tsv_samples_locations['nucleotideMutationFrequency'] = tsv_samples_locations["submissionId"].map(
        nucleotide_mut_freq)

    tsv_samples_locations['aminoAcidMutationFrequency'] = None
    tsv_samples_locations['lineageFrequencyEstimates'] = None

    tsv_samples_locations.to_csv(
        f'timeline_mutation_multiple_batches_{reference}.tsv', sep='\t',
        index=False, quoting=3)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Process VCF file and tsv files and prepare datamatrix')
    parser.add_argument('--path_to_vcf', nargs='+',
                        help='input directory containing VCF files: it should be e.g. /cluster/work/bewi/members/arimaite/alignments_rsv/vp-analysis/rsv_a_wastewater_24_10_25/results/*/date/variants/SNVs/snvs.vcf')
    parser.add_argument('--timeline_tsv', help='path to timeline.tsv file')
    parser.add_argument('--path_to_coverage', nargs='+',
                        help='input directory containing coverage tsv files: it should be e.g. /cluster/work/bewi/members/arimaite/alignments_rsv/vp-analysis/rsv_a_wastewater_24_10_25/results/*/date/alignments/coverage.tsv.gz')
    parser.add_argument('--reference',
                        help='reference: it should be e.g. (for RSV-A:) EPI_ISL_412866; (for RSV-B:) EPI_ISL_1653999')

    args = parser.parse_args()

    main(args.path_to_vcf, args.timeline_tsv, args.path_to_coverage, args.reference)