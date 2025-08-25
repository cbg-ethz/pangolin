
link='--link'
mode='' # e.g.: --mode=0770

# Helper
fail() {
	printf '\e[31;1mArgh: %s\e[0m\n'	"$1"	1>&2
	[[ -n "$2" ]] && echo "$2" 1>&2
	exit 1
}

warn() {
	printf '\e[33;1mArgh: %s\e[0m\n'	"$1"	1>&2
	[[ -n "$2" ]] && echo "$2" 1>&2
}

ALLOK=1
X() {
	ALLOK=0
}

# sanity checks
[[ -d '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset' ]] || fail 'No sampleset directory:' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset'
[[ -d '/cluster/project/pangolin/folder_cleanup/bfabric-downloads' ]] || fail 'No download directory:' '/cluster/project/pangolin/folder_cleanup/bfabric-downloads'

[[ -d '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101' ]] || fail 'Not a directory:' '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101'
echo -ne '\r[················]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"A1_05_2025_05_21/"{,"20250613_2427498204/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/A1_05_2025_05_21_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/A1_05_2025_05_21/20250613_2427498204/raw_data/A1_05_2025_05_21_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/A1_05_2025_05_21_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/A1_05_2025_05_21/20250613_2427498204/raw_data/A1_05_2025_05_21_R2.fastq.gz'||X
echo -ne '\r[▏···············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"A2_15_2025_05_22/"{,"20250613_2427498204/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/A2_15_2025_05_22_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/A2_15_2025_05_22/20250613_2427498204/raw_data/A2_15_2025_05_22_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/A2_15_2025_05_22_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/A2_15_2025_05_22/20250613_2427498204/raw_data/A2_15_2025_05_22_R2.fastq.gz'||X
echo -ne '\r[▎···············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"A3_17_2025_05_29/"{,"20250613_2427498204/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/A3_17_2025_05_29_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/A3_17_2025_05_29/20250613_2427498204/raw_data/A3_17_2025_05_29_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/A3_17_2025_05_29_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/A3_17_2025_05_29/20250613_2427498204/raw_data/A3_17_2025_05_29_R2.fastq.gz'||X
echo -ne '\r[▍···············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"B1_05_2025_05_25/"{,"20250613_2427498204/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/B1_05_2025_05_25_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/B1_05_2025_05_25/20250613_2427498204/raw_data/B1_05_2025_05_25_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/B1_05_2025_05_25_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/B1_05_2025_05_25/20250613_2427498204/raw_data/B1_05_2025_05_25_R2.fastq.gz'||X
echo -ne '\r[▋···············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"B2_15_2025_05_26/"{,"20250613_2427498204/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/B2_15_2025_05_26_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/B2_15_2025_05_26/20250613_2427498204/raw_data/B2_15_2025_05_26_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/B2_15_2025_05_26_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/B2_15_2025_05_26/20250613_2427498204/raw_data/B2_15_2025_05_26_R2.fastq.gz'||X
echo -ne '\r[▊···············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"B3_17_2025_05_30/"{,"20250613_2427498204/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/B3_17_2025_05_30_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/B3_17_2025_05_30/20250613_2427498204/raw_data/B3_17_2025_05_30_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/B3_17_2025_05_30_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/B3_17_2025_05_30/20250613_2427498204/raw_data/B3_17_2025_05_30_R2.fastq.gz'||X
echo -ne '\r[▉···············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"C1_10_2025_05_21/"{,"20250613_2427498204/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/C1_10_2025_05_21_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/C1_10_2025_05_21/20250613_2427498204/raw_data/C1_10_2025_05_21_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/C1_10_2025_05_21_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/C1_10_2025_05_21/20250613_2427498204/raw_data/C1_10_2025_05_21_R2.fastq.gz'||X
echo -ne '\r[█▏··············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"C2_16_2025_05_21/"{,"20250613_2427498204/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/C2_16_2025_05_21_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/C2_16_2025_05_21/20250613_2427498204/raw_data/C2_16_2025_05_21_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/C2_16_2025_05_21_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/C2_16_2025_05_21/20250613_2427498204/raw_data/C2_16_2025_05_21_R2.fastq.gz'||X
echo -ne '\r[█▎··············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"C3_25_2025_05_28/"{,"20250613_2427498204/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/C3_25_2025_05_28_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/C3_25_2025_05_28/20250613_2427498204/raw_data/C3_25_2025_05_28_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/C3_25_2025_05_28_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/C3_25_2025_05_28/20250613_2427498204/raw_data/C3_25_2025_05_28_R2.fastq.gz'||X
echo -ne '\r[█▍··············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"D1_10_2025_05_25/"{,"20250613_2427498204/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/D1_10_2025_05_25_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/D1_10_2025_05_25/20250613_2427498204/raw_data/D1_10_2025_05_25_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/D1_10_2025_05_25_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/D1_10_2025_05_25/20250613_2427498204/raw_data/D1_10_2025_05_25_R2.fastq.gz'||X
echo -ne '\r[█▌··············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"D2_16_2025_05_25/"{,"20250613_2427498204/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/D2_16_2025_05_25_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/D2_16_2025_05_25/20250613_2427498204/raw_data/D2_16_2025_05_25_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/D2_16_2025_05_25_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/D2_16_2025_05_25/20250613_2427498204/raw_data/D2_16_2025_05_25_R2.fastq.gz'||X
echo -ne '\r[█▊··············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"D3_25_2025_05_30/"{,"20250613_2427498204/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/D3_25_2025_05_30_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/D3_25_2025_05_30/20250613_2427498204/raw_data/D3_25_2025_05_30_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/D3_25_2025_05_30_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/D3_25_2025_05_30/20250613_2427498204/raw_data/D3_25_2025_05_30_R2.fastq.gz'||X
echo -ne '\r[█▉··············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"E1_17_2025_05_21/"{,"20250613_2427498204/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/E1_17_2025_05_21_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/E1_17_2025_05_21/20250613_2427498204/raw_data/E1_17_2025_05_21_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/E1_17_2025_05_21_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/E1_17_2025_05_21/20250613_2427498204/raw_data/E1_17_2025_05_21_R2.fastq.gz'||X
echo -ne '\r[██··············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"E2_05_2025_05_29/"{,"20250613_2427498204/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/E2_05_2025_05_29_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/E2_05_2025_05_29/20250613_2427498204/raw_data/E2_05_2025_05_29_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/E2_05_2025_05_29_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/E2_05_2025_05_29/20250613_2427498204/raw_data/E2_05_2025_05_29_R2.fastq.gz'||X
echo -ne '\r[██▎·············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"E3_15_2025_05_27/"{,"20250613_2427498204/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/E3_15_2025_05_27_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/E3_15_2025_05_27/20250613_2427498204/raw_data/E3_15_2025_05_27_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/E3_15_2025_05_27_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/E3_15_2025_05_27/20250613_2427498204/raw_data/E3_15_2025_05_27_R2.fastq.gz'||X
echo -ne '\r[██▍·············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"F1_17_2025_05_25/"{,"20250613_2427498204/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/F1_17_2025_05_25_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/F1_17_2025_05_25/20250613_2427498204/raw_data/F1_17_2025_05_25_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/F1_17_2025_05_25_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/F1_17_2025_05_25/20250613_2427498204/raw_data/F1_17_2025_05_25_R2.fastq.gz'||X
echo -ne '\r[██▌·············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"F2_05_2025_05_30/"{,"20250613_2427498204/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/F2_05_2025_05_30_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/F2_05_2025_05_30/20250613_2427498204/raw_data/F2_05_2025_05_30_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/F2_05_2025_05_30_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/F2_05_2025_05_30/20250613_2427498204/raw_data/F2_05_2025_05_30_R2.fastq.gz'||X
echo -ne '\r[██▋·············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"F3_15_2025_05_30/"{,"20250613_2427498204/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/F3_15_2025_05_30_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/F3_15_2025_05_30/20250613_2427498204/raw_data/F3_15_2025_05_30_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/F3_15_2025_05_30_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/F3_15_2025_05_30/20250613_2427498204/raw_data/F3_15_2025_05_30_R2.fastq.gz'||X
echo -ne '\r[██▉·············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"G1_25_2025_05_21/"{,"20250613_2427498204/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/G1_25_2025_05_21_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/G1_25_2025_05_21/20250613_2427498204/raw_data/G1_25_2025_05_21_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/G1_25_2025_05_21_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/G1_25_2025_05_21/20250613_2427498204/raw_data/G1_25_2025_05_21_R2.fastq.gz'||X
echo -ne '\r[███·············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"G2_10_2025_05_29/"{,"20250613_2427498204/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/G2_10_2025_05_29_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/G2_10_2025_05_29/20250613_2427498204/raw_data/G2_10_2025_05_29_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/G2_10_2025_05_29_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/G2_10_2025_05_29/20250613_2427498204/raw_data/G2_10_2025_05_29_R2.fastq.gz'||X
echo -ne '\r[███▏············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"G3_16_2025_05_29/"{,"20250613_2427498204/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/G3_16_2025_05_29_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/G3_16_2025_05_29/20250613_2427498204/raw_data/G3_16_2025_05_29_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/G3_16_2025_05_29_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/G3_16_2025_05_29/20250613_2427498204/raw_data/G3_16_2025_05_29_R2.fastq.gz'||X
echo -ne '\r[███▍············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"H1_25_2025_05_25/"{,"20250613_2427498204/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/H1_25_2025_05_25_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/H1_25_2025_05_25/20250613_2427498204/raw_data/H1_25_2025_05_25_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/H1_25_2025_05_25_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/H1_25_2025_05_25/20250613_2427498204/raw_data/H1_25_2025_05_25_R2.fastq.gz'||X
echo -ne '\r[███▌············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"H2_10_2025_05_30/"{,"20250613_2427498204/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/H2_10_2025_05_30_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/H2_10_2025_05_30/20250613_2427498204/raw_data/H2_10_2025_05_30_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/H2_10_2025_05_30_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/H2_10_2025_05_30/20250613_2427498204/raw_data/H2_10_2025_05_30_R2.fastq.gz'||X
echo -ne '\r[███▋············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"H3_16_2025_05_31/"{,"20250613_2427498204/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/H3_16_2025_05_31_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/H3_16_2025_05_31/20250613_2427498204/raw_data/H3_16_2025_05_31_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38832_Aviti_250613_AV101/H3_16_2025_05_31_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/H3_16_2025_05_31/20250613_2427498204/raw_data/H3_16_2025_05_31_R2.fastq.gz'||X
[[ -d '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103' ]] || fail 'Not a directory:' '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103'
echo -ne '\r[███▉············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"A1_05_2025_06_02/"{,"20250630_2427515972/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/A1_05_2025_06_02_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/A1_05_2025_06_02/20250630_2427515972/raw_data/A1_05_2025_06_02_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/A1_05_2025_06_02_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/A1_05_2025_06_02/20250630_2427515972/raw_data/A1_05_2025_06_02_R2.fastq.gz'||X
echo -ne '\r[████············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"A2_15_2025_06_04/"{,"20250630_2427515972/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/A2_15_2025_06_04_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/A2_15_2025_06_04/20250630_2427515972/raw_data/A2_15_2025_06_04_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/A2_15_2025_06_04_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/A2_15_2025_06_04/20250630_2427515972/raw_data/A2_15_2025_06_04_R2.fastq.gz'||X
echo -ne '\r[████▏···········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"A3_17_2025_06_10/"{,"20250630_2427515972/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/A3_17_2025_06_10_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/A3_17_2025_06_10/20250630_2427515972/raw_data/A3_17_2025_06_10_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/A3_17_2025_06_10_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/A3_17_2025_06_10/20250630_2427515972/raw_data/A3_17_2025_06_10_R2.fastq.gz'||X
echo -ne '\r[████▎···········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"B1_05_2025_06_07/"{,"20250630_2427515972/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/B1_05_2025_06_07_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/B1_05_2025_06_07/20250630_2427515972/raw_data/B1_05_2025_06_07_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/B1_05_2025_06_07_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/B1_05_2025_06_07/20250630_2427515972/raw_data/B1_05_2025_06_07_R2.fastq.gz'||X
echo -ne '\r[████▌···········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"B2_15_2025_06_08/"{,"20250630_2427515972/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/B2_15_2025_06_08_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/B2_15_2025_06_08/20250630_2427515972/raw_data/B2_15_2025_06_08_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/B2_15_2025_06_08_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/B2_15_2025_06_08/20250630_2427515972/raw_data/B2_15_2025_06_08_R2.fastq.gz'||X
echo -ne '\r[████▋···········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"B3_17_2025_06_15/"{,"20250630_2427515972/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/B3_17_2025_06_15_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/B3_17_2025_06_15/20250630_2427515972/raw_data/B3_17_2025_06_15_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/B3_17_2025_06_15_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/B3_17_2025_06_15/20250630_2427515972/raw_data/B3_17_2025_06_15_R2.fastq.gz'||X
echo -ne '\r[████▊···········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"C1_10_2025_06_02/"{,"20250630_2427515972/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/C1_10_2025_06_02_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/C1_10_2025_06_02/20250630_2427515972/raw_data/C1_10_2025_06_02_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/C1_10_2025_06_02_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/C1_10_2025_06_02/20250630_2427515972/raw_data/C1_10_2025_06_02_R2.fastq.gz'||X
echo -ne '\r[█████···········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"C2_16_2025_06_06/"{,"20250630_2427515972/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/C2_16_2025_06_06_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/C2_16_2025_06_06/20250630_2427515972/raw_data/C2_16_2025_06_06_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/C2_16_2025_06_06_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/C2_16_2025_06_06/20250630_2427515972/raw_data/C2_16_2025_06_06_R2.fastq.gz'||X
echo -ne '\r[█████▏··········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"C3_25_2025_06_10/"{,"20250630_2427515972/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/C3_25_2025_06_10_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/C3_25_2025_06_10/20250630_2427515972/raw_data/C3_25_2025_06_10_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/C3_25_2025_06_10_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/C3_25_2025_06_10/20250630_2427515972/raw_data/C3_25_2025_06_10_R2.fastq.gz'||X
echo -ne '\r[█████▎··········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"D1_10_2025_06_07/"{,"20250630_2427515972/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/D1_10_2025_06_07_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/D1_10_2025_06_07/20250630_2427515972/raw_data/D1_10_2025_06_07_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/D1_10_2025_06_07_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/D1_10_2025_06_07/20250630_2427515972/raw_data/D1_10_2025_06_07_R2.fastq.gz'||X
echo -ne '\r[█████▍··········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"D2_16_2025_06_08/"{,"20250630_2427515972/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/D2_16_2025_06_08_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/D2_16_2025_06_08/20250630_2427515972/raw_data/D2_16_2025_06_08_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/D2_16_2025_06_08_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/D2_16_2025_06_08/20250630_2427515972/raw_data/D2_16_2025_06_08_R2.fastq.gz'||X
echo -ne '\r[█████▋··········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"D3_25_2025_06_15/"{,"20250630_2427515972/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/D3_25_2025_06_15_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/D3_25_2025_06_15/20250630_2427515972/raw_data/D3_25_2025_06_15_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/D3_25_2025_06_15_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/D3_25_2025_06_15/20250630_2427515972/raw_data/D3_25_2025_06_15_R2.fastq.gz'||X
echo -ne '\r[█████▊··········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"E1_17_2025_06_02/"{,"20250630_2427515972/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/E1_17_2025_06_02_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/E1_17_2025_06_02/20250630_2427515972/raw_data/E1_17_2025_06_02_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/E1_17_2025_06_02_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/E1_17_2025_06_02/20250630_2427515972/raw_data/E1_17_2025_06_02_R2.fastq.gz'||X
echo -ne '\r[█████▉··········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"E2_05_2025_06_10/"{,"20250630_2427515972/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/E2_05_2025_06_10_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/E2_05_2025_06_10/20250630_2427515972/raw_data/E2_05_2025_06_10_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/E2_05_2025_06_10_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/E2_05_2025_06_10/20250630_2427515972/raw_data/E2_05_2025_06_10_R2.fastq.gz'||X
echo -ne '\r[██████▏·········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"E3_15_2025_06_12/"{,"20250630_2427515972/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/E3_15_2025_06_12_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/E3_15_2025_06_12/20250630_2427515972/raw_data/E3_15_2025_06_12_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/E3_15_2025_06_12_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/E3_15_2025_06_12/20250630_2427515972/raw_data/E3_15_2025_06_12_R2.fastq.gz'||X
echo -ne '\r[██████▎·········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"F1_17_2025_06_07/"{,"20250630_2427515972/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/F1_17_2025_06_07_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/F1_17_2025_06_07/20250630_2427515972/raw_data/F1_17_2025_06_07_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/F1_17_2025_06_07_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/F1_17_2025_06_07/20250630_2427515972/raw_data/F1_17_2025_06_07_R2.fastq.gz'||X
echo -ne '\r[██████▍·········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"F2_05_2025_06_15/"{,"20250630_2427515972/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/F2_05_2025_06_15_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/F2_05_2025_06_15/20250630_2427515972/raw_data/F2_05_2025_06_15_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/F2_05_2025_06_15_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/F2_05_2025_06_15/20250630_2427515972/raw_data/F2_05_2025_06_15_R2.fastq.gz'||X
echo -ne '\r[██████▋·········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"F3_15_2025_06_16/"{,"20250630_2427515972/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/F3_15_2025_06_16_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/F3_15_2025_06_16/20250630_2427515972/raw_data/F3_15_2025_06_16_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/F3_15_2025_06_16_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/F3_15_2025_06_16/20250630_2427515972/raw_data/F3_15_2025_06_16_R2.fastq.gz'||X
echo -ne '\r[██████▊·········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"G1_25_2025_06_02/"{,"20250630_2427515972/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/G1_25_2025_06_02_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/G1_25_2025_06_02/20250630_2427515972/raw_data/G1_25_2025_06_02_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/G1_25_2025_06_02_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/G1_25_2025_06_02/20250630_2427515972/raw_data/G1_25_2025_06_02_R2.fastq.gz'||X
echo -ne '\r[██████▉·········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"G2_10_2025_06_10/"{,"20250630_2427515972/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/G2_10_2025_06_10_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/G2_10_2025_06_10/20250630_2427515972/raw_data/G2_10_2025_06_10_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/G2_10_2025_06_10_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/G2_10_2025_06_10/20250630_2427515972/raw_data/G2_10_2025_06_10_R2.fastq.gz'||X
echo -ne '\r[███████·········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"G3_16_2025_06_10/"{,"20250630_2427515972/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/G3_16_2025_06_10_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/G3_16_2025_06_10/20250630_2427515972/raw_data/G3_16_2025_06_10_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/G3_16_2025_06_10_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/G3_16_2025_06_10/20250630_2427515972/raw_data/G3_16_2025_06_10_R2.fastq.gz'||X
echo -ne '\r[███████▎········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"H1_25_2025_06_07/"{,"20250630_2427515972/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/H1_25_2025_06_07_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/H1_25_2025_06_07/20250630_2427515972/raw_data/H1_25_2025_06_07_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/H1_25_2025_06_07_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/H1_25_2025_06_07/20250630_2427515972/raw_data/H1_25_2025_06_07_R2.fastq.gz'||X
echo -ne '\r[███████▍········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"H2_10_2025_06_15/"{,"20250630_2427515972/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/H2_10_2025_06_15_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/H2_10_2025_06_15/20250630_2427515972/raw_data/H2_10_2025_06_15_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/H2_10_2025_06_15_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/H2_10_2025_06_15/20250630_2427515972/raw_data/H2_10_2025_06_15_R2.fastq.gz'||X
echo -ne '\r[███████▌········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"H3_16_2025_06_16/"{,"20250630_2427515972/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/H3_16_2025_06_16_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/H3_16_2025_06_16/20250630_2427515972/raw_data/H3_16_2025_06_16_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250630_AV103/H3_16_2025_06_16_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/H3_16_2025_06_16/20250630_2427515972/raw_data/H3_16_2025_06_16_R2.fastq.gz'||X
[[ -d '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104' ]] || fail 'Not a directory:' '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104'
echo -ne '\r[███████▊········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"A1_05_2025_06_02/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/A1_05_2025_06_02_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/A1_05_2025_06_02/20250701_2427506364/raw_data/A1_05_2025_06_02_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/A1_05_2025_06_02_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/A1_05_2025_06_02/20250701_2427506364/raw_data/A1_05_2025_06_02_R2.fastq.gz'||X
echo -ne '\r[███████▉········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"A2_15_2025_06_04/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/A2_15_2025_06_04_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/A2_15_2025_06_04/20250701_2427506364/raw_data/A2_15_2025_06_04_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/A2_15_2025_06_04_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/A2_15_2025_06_04/20250701_2427506364/raw_data/A2_15_2025_06_04_R2.fastq.gz'||X
echo -ne '\r[████████········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"A3_17_2025_06_10/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/A3_17_2025_06_10_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/A3_17_2025_06_10/20250701_2427506364/raw_data/A3_17_2025_06_10_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/A3_17_2025_06_10_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/A3_17_2025_06_10/20250701_2427506364/raw_data/A3_17_2025_06_10_R2.fastq.gz'||X
echo -ne '\r[████████▏·······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"B1_05_2025_06_07/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/B1_05_2025_06_07_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/B1_05_2025_06_07/20250701_2427506364/raw_data/B1_05_2025_06_07_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/B1_05_2025_06_07_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/B1_05_2025_06_07/20250701_2427506364/raw_data/B1_05_2025_06_07_R2.fastq.gz'||X
echo -ne '\r[████████▍·······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"B2_15_2025_06_08/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/B2_15_2025_06_08_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/B2_15_2025_06_08/20250701_2427506364/raw_data/B2_15_2025_06_08_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/B2_15_2025_06_08_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/B2_15_2025_06_08/20250701_2427506364/raw_data/B2_15_2025_06_08_R2.fastq.gz'||X
echo -ne '\r[████████▌·······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"B3_17_2025_06_15/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/B3_17_2025_06_15_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/B3_17_2025_06_15/20250701_2427506364/raw_data/B3_17_2025_06_15_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/B3_17_2025_06_15_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/B3_17_2025_06_15/20250701_2427506364/raw_data/B3_17_2025_06_15_R2.fastq.gz'||X
echo -ne '\r[████████▋·······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"C1_10_2025_06_02/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/C1_10_2025_06_02_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/C1_10_2025_06_02/20250701_2427506364/raw_data/C1_10_2025_06_02_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/C1_10_2025_06_02_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/C1_10_2025_06_02/20250701_2427506364/raw_data/C1_10_2025_06_02_R2.fastq.gz'||X
echo -ne '\r[████████▉·······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"C2_16_2025_06_06/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/C2_16_2025_06_06_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/C2_16_2025_06_06/20250701_2427506364/raw_data/C2_16_2025_06_06_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/C2_16_2025_06_06_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/C2_16_2025_06_06/20250701_2427506364/raw_data/C2_16_2025_06_06_R2.fastq.gz'||X
echo -ne '\r[█████████·······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"C3_25_2025_06_10/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/C3_25_2025_06_10_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/C3_25_2025_06_10/20250701_2427506364/raw_data/C3_25_2025_06_10_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/C3_25_2025_06_10_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/C3_25_2025_06_10/20250701_2427506364/raw_data/C3_25_2025_06_10_R2.fastq.gz'||X
echo -ne '\r[█████████▏······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"D1_10_2025_06_07/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/D1_10_2025_06_07_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/D1_10_2025_06_07/20250701_2427506364/raw_data/D1_10_2025_06_07_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/D1_10_2025_06_07_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/D1_10_2025_06_07/20250701_2427506364/raw_data/D1_10_2025_06_07_R2.fastq.gz'||X
echo -ne '\r[█████████▎······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"D2_16_2025_06_08/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/D2_16_2025_06_08_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/D2_16_2025_06_08/20250701_2427506364/raw_data/D2_16_2025_06_08_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/D2_16_2025_06_08_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/D2_16_2025_06_08/20250701_2427506364/raw_data/D2_16_2025_06_08_R2.fastq.gz'||X
echo -ne '\r[█████████▌······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"D3_25_2025_06_15/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/D3_25_2025_06_15_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/D3_25_2025_06_15/20250701_2427506364/raw_data/D3_25_2025_06_15_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/D3_25_2025_06_15_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/D3_25_2025_06_15/20250701_2427506364/raw_data/D3_25_2025_06_15_R2.fastq.gz'||X
echo -ne '\r[█████████▋······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"E1_17_2025_06_02/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/E1_17_2025_06_02_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/E1_17_2025_06_02/20250701_2427506364/raw_data/E1_17_2025_06_02_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/E1_17_2025_06_02_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/E1_17_2025_06_02/20250701_2427506364/raw_data/E1_17_2025_06_02_R2.fastq.gz'||X
echo -ne '\r[█████████▊······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"E2_05_2025_06_10/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/E2_05_2025_06_10_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/E2_05_2025_06_10/20250701_2427506364/raw_data/E2_05_2025_06_10_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/E2_05_2025_06_10_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/E2_05_2025_06_10/20250701_2427506364/raw_data/E2_05_2025_06_10_R2.fastq.gz'||X
echo -ne '\r[██████████······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"E3_15_2025_06_12/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/E3_15_2025_06_12_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/E3_15_2025_06_12/20250701_2427506364/raw_data/E3_15_2025_06_12_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/E3_15_2025_06_12_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/E3_15_2025_06_12/20250701_2427506364/raw_data/E3_15_2025_06_12_R2.fastq.gz'||X
echo -ne '\r[██████████▏·····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"F1_17_2025_06_07/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/F1_17_2025_06_07_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/F1_17_2025_06_07/20250701_2427506364/raw_data/F1_17_2025_06_07_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/F1_17_2025_06_07_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/F1_17_2025_06_07/20250701_2427506364/raw_data/F1_17_2025_06_07_R2.fastq.gz'||X
echo -ne '\r[██████████▎·····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"F2_05_2025_06_15/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/F2_05_2025_06_15_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/F2_05_2025_06_15/20250701_2427506364/raw_data/F2_05_2025_06_15_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/F2_05_2025_06_15_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/F2_05_2025_06_15/20250701_2427506364/raw_data/F2_05_2025_06_15_R2.fastq.gz'||X
echo -ne '\r[██████████▌·····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"F3_15_2025_06_16/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/F3_15_2025_06_16_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/F3_15_2025_06_16/20250701_2427506364/raw_data/F3_15_2025_06_16_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/F3_15_2025_06_16_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/F3_15_2025_06_16/20250701_2427506364/raw_data/F3_15_2025_06_16_R2.fastq.gz'||X
echo -ne '\r[██████████▋·····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"G1_25_2025_06_02/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/G1_25_2025_06_02_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/G1_25_2025_06_02/20250701_2427506364/raw_data/G1_25_2025_06_02_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/G1_25_2025_06_02_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/G1_25_2025_06_02/20250701_2427506364/raw_data/G1_25_2025_06_02_R2.fastq.gz'||X
echo -ne '\r[██████████▊·····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"G2_10_2025_06_10/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/G2_10_2025_06_10_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/G2_10_2025_06_10/20250701_2427506364/raw_data/G2_10_2025_06_10_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/G2_10_2025_06_10_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/G2_10_2025_06_10/20250701_2427506364/raw_data/G2_10_2025_06_10_R2.fastq.gz'||X
echo -ne '\r[██████████▉·····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"G3_16_2025_06_10/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/G3_16_2025_06_10_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/G3_16_2025_06_10/20250701_2427506364/raw_data/G3_16_2025_06_10_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/G3_16_2025_06_10_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/G3_16_2025_06_10/20250701_2427506364/raw_data/G3_16_2025_06_10_R2.fastq.gz'||X
echo -ne '\r[███████████▏····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"H1_25_2025_06_07/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/H1_25_2025_06_07_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/H1_25_2025_06_07/20250701_2427506364/raw_data/H1_25_2025_06_07_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/H1_25_2025_06_07_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/H1_25_2025_06_07/20250701_2427506364/raw_data/H1_25_2025_06_07_R2.fastq.gz'||X
echo -ne '\r[███████████▎····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"H2_10_2025_06_15/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/H2_10_2025_06_15_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/H2_10_2025_06_15/20250701_2427506364/raw_data/H2_10_2025_06_15_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/H2_10_2025_06_15_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/H2_10_2025_06_15/20250701_2427506364/raw_data/H2_10_2025_06_15_R2.fastq.gz'||X
echo -ne '\r[███████████▍····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"H3_16_2025_06_16/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/H3_16_2025_06_16_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/H3_16_2025_06_16/20250701_2427506364/raw_data/H3_16_2025_06_16_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/H3_16_2025_06_16_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/H3_16_2025_06_16/20250701_2427506364/raw_data/H3_16_2025_06_16_R2.fastq.gz'||X
[[ -d '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105' ]] || fail 'Not a directory:' '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105'
echo -ne '\r[███████████▋····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"A1_05_2025_06_18/"{,"20250711_2443602573/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/A1_05_2025_06_18_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/A1_05_2025_06_18/20250711_2443602573/raw_data/A1_05_2025_06_18_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/A1_05_2025_06_18_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/A1_05_2025_06_18/20250711_2443602573/raw_data/A1_05_2025_06_18_R2.fastq.gz'||X
echo -ne '\r[███████████▊····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"A2_15_2025_06_17/"{,"20250711_2443602573/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/A2_15_2025_06_17_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/A2_15_2025_06_17/20250711_2443602573/raw_data/A2_15_2025_06_17_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/A2_15_2025_06_17_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/A2_15_2025_06_17/20250711_2443602573/raw_data/A2_15_2025_06_17_R2.fastq.gz'||X
echo -ne '\r[███████████▉····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"A3_17_2025_06_26/"{,"20250711_2443602573/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/A3_17_2025_06_26_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/A3_17_2025_06_26/20250711_2443602573/raw_data/A3_17_2025_06_26_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/A3_17_2025_06_26_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/A3_17_2025_06_26/20250711_2443602573/raw_data/A3_17_2025_06_26_R2.fastq.gz'||X
echo -ne '\r[████████████····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"B1_05_2025_06_20/"{,"20250711_2443602573/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/B1_05_2025_06_20_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/B1_05_2025_06_20/20250711_2443602573/raw_data/B1_05_2025_06_20_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/B1_05_2025_06_20_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/B1_05_2025_06_20/20250711_2443602573/raw_data/B1_05_2025_06_20_R2.fastq.gz'||X
echo -ne '\r[████████████▎···]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"B2_15_2025_06_20/"{,"20250711_2443602573/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/B2_15_2025_06_20_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/B2_15_2025_06_20/20250711_2443602573/raw_data/B2_15_2025_06_20_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/B2_15_2025_06_20_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/B2_15_2025_06_20/20250711_2443602573/raw_data/B2_15_2025_06_20_R2.fastq.gz'||X
echo -ne '\r[████████████▍···]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"B3_17_2025_06_28/"{,"20250711_2443602573/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/B3_17_2025_06_28_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/B3_17_2025_06_28/20250711_2443602573/raw_data/B3_17_2025_06_28_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/B3_17_2025_06_28_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/B3_17_2025_06_28/20250711_2443602573/raw_data/B3_17_2025_06_28_R2.fastq.gz'||X
echo -ne '\r[████████████▌···]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"C1_10_2025_06_18/"{,"20250711_2443602573/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/C1_10_2025_06_18_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/C1_10_2025_06_18/20250711_2443602573/raw_data/C1_10_2025_06_18_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/C1_10_2025_06_18_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/C1_10_2025_06_18/20250711_2443602573/raw_data/C1_10_2025_06_18_R2.fastq.gz'||X
echo -ne '\r[████████████▊···]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"C2_16_2025_06_18/"{,"20250711_2443602573/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/C2_16_2025_06_18_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/C2_16_2025_06_18/20250711_2443602573/raw_data/C2_16_2025_06_18_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/C2_16_2025_06_18_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/C2_16_2025_06_18/20250711_2443602573/raw_data/C2_16_2025_06_18_R2.fastq.gz'||X
echo -ne '\r[████████████▉···]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"C3_25_2025_06_26/"{,"20250711_2443602573/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/C3_25_2025_06_26_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/C3_25_2025_06_26/20250711_2443602573/raw_data/C3_25_2025_06_26_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/C3_25_2025_06_26_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/C3_25_2025_06_26/20250711_2443602573/raw_data/C3_25_2025_06_26_R2.fastq.gz'||X
echo -ne '\r[█████████████···]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"D1_10_2025_06_20/"{,"20250711_2443602573/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/D1_10_2025_06_20_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/D1_10_2025_06_20/20250711_2443602573/raw_data/D1_10_2025_06_20_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/D1_10_2025_06_20_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/D1_10_2025_06_20/20250711_2443602573/raw_data/D1_10_2025_06_20_R2.fastq.gz'||X
echo -ne '\r[█████████████▎··]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"D2_16_2025_06_21/"{,"20250711_2443602573/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/D2_16_2025_06_21_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/D2_16_2025_06_21/20250711_2443602573/raw_data/D2_16_2025_06_21_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/D2_16_2025_06_21_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/D2_16_2025_06_21/20250711_2443602573/raw_data/D2_16_2025_06_21_R2.fastq.gz'||X
echo -ne '\r[█████████████▍··]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"D3_25_2025_06_28/"{,"20250711_2443602573/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/D3_25_2025_06_28_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/D3_25_2025_06_28/20250711_2443602573/raw_data/D3_25_2025_06_28_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/D3_25_2025_06_28_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/D3_25_2025_06_28/20250711_2443602573/raw_data/D3_25_2025_06_28_R2.fastq.gz'||X
echo -ne '\r[█████████████▌··]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"E1_17_2025_06_18/"{,"20250711_2443602573/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/E1_17_2025_06_18_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/E1_17_2025_06_18/20250711_2443602573/raw_data/E1_17_2025_06_18_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/E1_17_2025_06_18_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/E1_17_2025_06_18/20250711_2443602573/raw_data/E1_17_2025_06_18_R2.fastq.gz'||X
echo -ne '\r[█████████████▋··]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"E2_05_2025_06_26/"{,"20250711_2443602573/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/E2_05_2025_06_26_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/E2_05_2025_06_26/20250711_2443602573/raw_data/E2_05_2025_06_26_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/E2_05_2025_06_26_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/E2_05_2025_06_26/20250711_2443602573/raw_data/E2_05_2025_06_26_R2.fastq.gz'||X
echo -ne '\r[█████████████▉··]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"E3_15_2025_06_25/"{,"20250711_2443602573/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/E3_15_2025_06_25_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/E3_15_2025_06_25/20250711_2443602573/raw_data/E3_15_2025_06_25_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/E3_15_2025_06_25_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/E3_15_2025_06_25/20250711_2443602573/raw_data/E3_15_2025_06_25_R2.fastq.gz'||X
echo -ne '\r[██████████████··]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"F1_17_2025_06_20/"{,"20250711_2443602573/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/F1_17_2025_06_20_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/F1_17_2025_06_20/20250711_2443602573/raw_data/F1_17_2025_06_20_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/F1_17_2025_06_20_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/F1_17_2025_06_20/20250711_2443602573/raw_data/F1_17_2025_06_20_R2.fastq.gz'||X
echo -ne '\r[██████████████▏·]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"F2_05_2025_06_28/"{,"20250711_2443602573/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/F2_05_2025_06_28_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/F2_05_2025_06_28/20250711_2443602573/raw_data/F2_05_2025_06_28_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/F2_05_2025_06_28_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/F2_05_2025_06_28/20250711_2443602573/raw_data/F2_05_2025_06_28_R2.fastq.gz'||X
echo -ne '\r[██████████████▍·]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"F3_15_2025_06_29/"{,"20250711_2443602573/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/F3_15_2025_06_29_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/F3_15_2025_06_29/20250711_2443602573/raw_data/F3_15_2025_06_29_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/F3_15_2025_06_29_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/F3_15_2025_06_29/20250711_2443602573/raw_data/F3_15_2025_06_29_R2.fastq.gz'||X
echo -ne '\r[██████████████▌·]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"G1_25_2025_06_18/"{,"20250711_2443602573/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/G1_25_2025_06_18_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/G1_25_2025_06_18/20250711_2443602573/raw_data/G1_25_2025_06_18_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/G1_25_2025_06_18_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/G1_25_2025_06_18/20250711_2443602573/raw_data/G1_25_2025_06_18_R2.fastq.gz'||X
echo -ne '\r[██████████████▋·]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"G2_10_2025_06_26/"{,"20250711_2443602573/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/G2_10_2025_06_26_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/G2_10_2025_06_26/20250711_2443602573/raw_data/G2_10_2025_06_26_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/G2_10_2025_06_26_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/G2_10_2025_06_26/20250711_2443602573/raw_data/G2_10_2025_06_26_R2.fastq.gz'||X
echo -ne '\r[██████████████▊·]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"G3_16_2025_06_27/"{,"20250711_2443602573/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/G3_16_2025_06_27_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/G3_16_2025_06_27/20250711_2443602573/raw_data/G3_16_2025_06_27_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/G3_16_2025_06_27_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/G3_16_2025_06_27/20250711_2443602573/raw_data/G3_16_2025_06_27_R2.fastq.gz'||X
echo -ne '\r[███████████████·]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"H1_25_2025_06_20/"{,"20250711_2443602573/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/H1_25_2025_06_20_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/H1_25_2025_06_20/20250711_2443602573/raw_data/H1_25_2025_06_20_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/H1_25_2025_06_20_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/H1_25_2025_06_20/20250711_2443602573/raw_data/H1_25_2025_06_20_R2.fastq.gz'||X
echo -ne '\r[███████████████▏]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"H2_10_2025_06_28/"{,"20250711_2443602573/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/H2_10_2025_06_28_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/H2_10_2025_06_28/20250711_2443602573/raw_data/H2_10_2025_06_28_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/H2_10_2025_06_28_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/H2_10_2025_06_28/20250711_2443602573/raw_data/H2_10_2025_06_28_R2.fastq.gz'||X
echo -ne '\r[███████████████▎]\r'

mkdir ${mode} -p "/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/"{,"H3_16_2025_06_29/"{,"20250711_2443602573/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/H3_16_2025_06_29_R1.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/H3_16_2025_06_29/20250711_2443602573/raw_data/H3_16_2025_06_29_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/folder_cleanup/bfabric-downloads/p23224/o39115_Aviti_250711_AV105/H3_16_2025_06_29_R2.fastq.gz' '/cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/H3_16_2025_06_29/20250711_2443602573/raw_data/H3_16_2025_06_29_R2.fastq.gz'||X

echo -e '\r\e[K[████████████████] done.'
if (( !ALLOK )); then
		echo Some errors
		exit 1
fi;


mv -v /cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/samples.20250613_2427498204.tsv.staging /cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/samples.20250613_2427498204.tsv
mv -v /cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/samples.20250630_2427515972.tsv.staging /cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/samples.20250630_2427515972.tsv
mv -v /cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/samples.20250701_2427506364.tsv.staging /cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/samples.20250701_2427506364.tsv
mv -v /cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/samples.20250711_2443602573.tsv.staging /cluster/project/pangolin/folder_cleanup/sars_cov_2_automation/sampleset/samples.20250711_2443602573.tsv

echo All Ok
exit 0

