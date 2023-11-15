scriptdir=/cluster/project/pangolin/test_automation/pangolin/pangolin_src
. ${scriptdir}/config/server.conf

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
if [[ ! -d "/cluster/project/pangolin/sampleset" ]]; then
    fail 'No sampleset directory:' "cluster/project/pangolin/sampleset"
fi
if [[ ! -d "/cluster/project/pangolin/bfabric-downloads" ]]; then
    fail 'No download directory:' "/cluster/project/pangolin/bfabric-downloads"
fi

if [[ ! -d "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899" ]]; then
    fail 'Not a directory:' "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899"
fi
echo -ne '\r[················]\r'

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A1_05_2023_09_27/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/A1_05_2023_09_27_S56_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A1_05_2023_09_27/20231013_HLLJMDRX3/raw_data/A1_05_2023_09_27_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/A1_05_2023_09_27_S56_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A1_05_2023_09_27/20231013_HLLJMDRX3/raw_data/A1_05_2023_09_27_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A2_10_2023_09_30/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/A2_10_2023_09_30_S3_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A2_10_2023_09_30/20231013_HLLJMDRX3/raw_data/A2_10_2023_09_30_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/A2_10_2023_09_30_S3_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A2_10_2023_09_30/20231013_HLLJMDRX3/raw_data/A2_10_2023_09_30_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A3_15_2023_09_29/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/A3_15_2023_09_29_S6_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A3_15_2023_09_29/20231013_HLLJMDRX3/raw_data/A3_15_2023_09_29_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/A3_15_2023_09_29_S6_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A3_15_2023_09_29/20231013_HLLJMDRX3/raw_data/A3_15_2023_09_29_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A4_16_2023_10_03/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/A4_16_2023_10_03_S9_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A4_16_2023_10_03/20231013_HLLJMDRX3/raw_data/A4_16_2023_10_03_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/A4_16_2023_10_03_S9_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A4_16_2023_10_03/20231013_HLLJMDRX3/raw_data/A4_16_2023_10_03_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A5_18_2023_09_30/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/A5_18_2023_09_30_S31_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A5_18_2023_09_30/20231013_HLLJMDRX3/raw_data/A5_18_2023_09_30_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/A5_18_2023_09_30_S31_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A5_18_2023_09_30/20231013_HLLJMDRX3/raw_data/A5_18_2023_09_30_R2.fastq.gz"||X
echo -ne "\r[▏···············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A6_25_2023_09_27/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/A6_25_2023_09_27_S39_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A6_25_2023_09_27/20231013_HLLJMDRX3/raw_data/A6_25_2023_09_27_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/A6_25_2023_09_27_S39_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A6_25_2023_09_27/20231013_HLLJMDRX3/raw_data/A6_25_2023_09_27_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A7_32_2023_10_02/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/A7_32_2023_10_02_S52_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A7_32_2023_10_02/20231013_HLLJMDRX3/raw_data/A7_32_2023_10_02_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/A7_32_2023_10_02_S52_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A7_32_2023_10_02/20231013_HLLJMDRX3/raw_data/A7_32_2023_10_02_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A8_34_2023_09_28/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/A8_34_2023_09_28_S38_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A8_34_2023_09_28/20231013_HLLJMDRX3/raw_data/A8_34_2023_09_28_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/A8_34_2023_09_28_S38_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A8_34_2023_09_28/20231013_HLLJMDRX3/raw_data/A8_34_2023_09_28_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A9_35_2023_10_01/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/A9_35_2023_10_01_S7_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A9_35_2023_10_01/20231013_HLLJMDRX3/raw_data/A9_35_2023_10_01_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/A9_35_2023_10_01_S7_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A9_35_2023_10_01/20231013_HLLJMDRX3/raw_data/A9_35_2023_10_01_R2.fastq.gz"||X
echo -ne "\r[▎···············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B1_05_2023_09_29/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/B1_05_2023_09_29_S17_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B1_05_2023_09_29/20231013_HLLJMDRX3/raw_data/B1_05_2023_09_29_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/B1_05_2023_09_29_S17_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B1_05_2023_09_29/20231013_HLLJMDRX3/raw_data/B1_05_2023_09_29_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B2_10_2023_10_01/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/B2_10_2023_10_01_S53_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B2_10_2023_10_01/20231013_HLLJMDRX3/raw_data/B2_10_2023_10_01_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/B2_10_2023_10_01_S53_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B2_10_2023_10_01/20231013_HLLJMDRX3/raw_data/B2_10_2023_10_01_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B3_15_2023_09_30/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/B3_15_2023_09_30_S25_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B3_15_2023_09_30/20231013_HLLJMDRX3/raw_data/B3_15_2023_09_30_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/B3_15_2023_09_30_S25_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B3_15_2023_09_30/20231013_HLLJMDRX3/raw_data/B3_15_2023_09_30_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B4_17_2023_09_26/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/B4_17_2023_09_26_S70_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B4_17_2023_09_26/20231013_HLLJMDRX3/raw_data/B4_17_2023_09_26_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/B4_17_2023_09_26_S70_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B4_17_2023_09_26/20231013_HLLJMDRX3/raw_data/B4_17_2023_09_26_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B5_18_2023_10_01/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/B5_18_2023_10_01_S4_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B5_18_2023_10_01/20231013_HLLJMDRX3/raw_data/B5_18_2023_10_01_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/B5_18_2023_10_01_S4_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B5_18_2023_10_01/20231013_HLLJMDRX3/raw_data/B5_18_2023_10_01_R2.fastq.gz"||X
echo -ne "\r[▍···············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B6_25_2023_09_29/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/B6_25_2023_09_29_S37_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B6_25_2023_09_29/20231013_HLLJMDRX3/raw_data/B6_25_2023_09_29_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/B6_25_2023_09_29_S37_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B6_25_2023_09_29/20231013_HLLJMDRX3/raw_data/B6_25_2023_09_29_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B7_32_2023_10_03/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/B7_32_2023_10_03_S10_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B7_32_2023_10_03/20231013_HLLJMDRX3/raw_data/B7_32_2023_10_03_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/B7_32_2023_10_03_S10_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B7_32_2023_10_03/20231013_HLLJMDRX3/raw_data/B7_32_2023_10_03_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B8_34_2023_09_29/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/B8_34_2023_09_29_S23_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B8_34_2023_09_29/20231013_HLLJMDRX3/raw_data/B8_34_2023_09_29_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/B8_34_2023_09_29_S23_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B8_34_2023_09_29/20231013_HLLJMDRX3/raw_data/B8_34_2023_09_29_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B9_36_2023_09_28/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/B9_36_2023_09_28_S32_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B9_36_2023_09_28/20231013_HLLJMDRX3/raw_data/B9_36_2023_09_28_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/B9_36_2023_09_28_S32_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B9_36_2023_09_28/20231013_HLLJMDRX3/raw_data/B9_36_2023_09_28_R2.fastq.gz"||X
echo -ne "\r[▌···············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C1_05_2023_09_30/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/C1_05_2023_09_30_S57_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C1_05_2023_09_30/20231013_HLLJMDRX3/raw_data/C1_05_2023_09_30_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/C1_05_2023_09_30_S57_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C1_05_2023_09_30/20231013_HLLJMDRX3/raw_data/C1_05_2023_09_30_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C2_12_2023_09_26/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/C2_12_2023_09_26_S55_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C2_12_2023_09_26/20231013_HLLJMDRX3/raw_data/C2_12_2023_09_26_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/C2_12_2023_09_26_S55_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C2_12_2023_09_26/20231013_HLLJMDRX3/raw_data/C2_12_2023_09_26_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C3_15_2023_10_01/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/C3_15_2023_10_01_S34_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C3_15_2023_10_01/20231013_HLLJMDRX3/raw_data/C3_15_2023_10_01_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/C3_15_2023_10_01_S34_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C3_15_2023_10_01/20231013_HLLJMDRX3/raw_data/C3_15_2023_10_01_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C4_17_2023_09_28/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/C4_17_2023_09_28_S28_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C4_17_2023_09_28/20231013_HLLJMDRX3/raw_data/C4_17_2023_09_28_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/C4_17_2023_09_28_S28_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C4_17_2023_09_28/20231013_HLLJMDRX3/raw_data/C4_17_2023_09_28_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C5_18_2023_10_02/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/C5_18_2023_10_02_S61_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C5_18_2023_10_02/20231013_HLLJMDRX3/raw_data/C5_18_2023_10_02_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/C5_18_2023_10_02_S61_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C5_18_2023_10_02/20231013_HLLJMDRX3/raw_data/C5_18_2023_10_02_R2.fastq.gz"||X
echo -ne "\r[▋···············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C6_25_2023_09_30/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/C6_25_2023_09_30_S66_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C6_25_2023_09_30/20231013_HLLJMDRX3/raw_data/C6_25_2023_09_30_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/C6_25_2023_09_30_S66_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C6_25_2023_09_30/20231013_HLLJMDRX3/raw_data/C6_25_2023_09_30_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C7_33_2023_09_28/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/C7_33_2023_09_28_S58_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C7_33_2023_09_28/20231013_HLLJMDRX3/raw_data/C7_33_2023_09_28_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/C7_33_2023_09_28_S58_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C7_33_2023_09_28/20231013_HLLJMDRX3/raw_data/C7_33_2023_09_28_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C8_34_2023_09_30/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/C8_34_2023_09_30_S15_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C8_34_2023_09_30/20231013_HLLJMDRX3/raw_data/C8_34_2023_09_30_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/C8_34_2023_09_30_S15_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C8_34_2023_09_30/20231013_HLLJMDRX3/raw_data/C8_34_2023_09_30_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C9_36_2023_09_30/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/C9_36_2023_09_30_S60_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C9_36_2023_09_30/20231013_HLLJMDRX3/raw_data/C9_36_2023_09_30_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/C9_36_2023_09_30_S60_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C9_36_2023_09_30/20231013_HLLJMDRX3/raw_data/C9_36_2023_09_30_R2.fastq.gz"||X
echo -ne "\r[▊···············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D1_05_2023_10_01/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/D1_05_2023_10_01_S29_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D1_05_2023_10_01/20231013_HLLJMDRX3/raw_data/D1_05_2023_10_01_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/D1_05_2023_10_01_S29_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D1_05_2023_10_01/20231013_HLLJMDRX3/raw_data/D1_05_2023_10_01_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D2_12_2023_09_28/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/D2_12_2023_09_28_S1_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D2_12_2023_09_28/20231013_HLLJMDRX3/raw_data/D2_12_2023_09_28_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/D2_12_2023_09_28_S1_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D2_12_2023_09_28/20231013_HLLJMDRX3/raw_data/D2_12_2023_09_28_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D3_15_2023_10_02/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/D3_15_2023_10_02_S51_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D3_15_2023_10_02/20231013_HLLJMDRX3/raw_data/D3_15_2023_10_02_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/D3_15_2023_10_02_S51_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D3_15_2023_10_02/20231013_HLLJMDRX3/raw_data/D3_15_2023_10_02_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D4_17_2023_09_29/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/D4_17_2023_09_29_S24_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D4_17_2023_09_29/20231013_HLLJMDRX3/raw_data/D4_17_2023_09_29_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/D4_17_2023_09_29_S24_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D4_17_2023_09_29/20231013_HLLJMDRX3/raw_data/D4_17_2023_09_29_R2.fastq.gz"||X
echo -ne "\r[▉···············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D5_19_2023_09_27/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/D5_19_2023_09_27_S64_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D5_19_2023_09_27/20231013_HLLJMDRX3/raw_data/D5_19_2023_09_27_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/D5_19_2023_09_27_S64_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D5_19_2023_09_27/20231013_HLLJMDRX3/raw_data/D5_19_2023_09_27_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D6_25_2023_10_01/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/D6_25_2023_10_01_S16_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D6_25_2023_10_01/20231013_HLLJMDRX3/raw_data/D6_25_2023_10_01_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/D6_25_2023_10_01_S16_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D6_25_2023_10_01/20231013_HLLJMDRX3/raw_data/D6_25_2023_10_01_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D7_33_2023_09_30/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/D7_33_2023_09_30_S65_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D7_33_2023_09_30/20231013_HLLJMDRX3/raw_data/D7_33_2023_09_30_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/D7_33_2023_09_30_S65_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D7_33_2023_09_30/20231013_HLLJMDRX3/raw_data/D7_33_2023_09_30_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D8_34_2023_10_01/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/D8_34_2023_10_01_S22_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D8_34_2023_10_01/20231013_HLLJMDRX3/raw_data/D8_34_2023_10_01_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/D8_34_2023_10_01_S22_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D8_34_2023_10_01/20231013_HLLJMDRX3/raw_data/D8_34_2023_10_01_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D9_36_2023_10_01/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/D9_36_2023_10_01_S5_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D9_36_2023_10_01/20231013_HLLJMDRX3/raw_data/D9_36_2023_10_01_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/D9_36_2023_10_01_S5_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D9_36_2023_10_01/20231013_HLLJMDRX3/raw_data/D9_36_2023_10_01_R2.fastq.gz"||X
echo -ne "\r[█···············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E1_05_2023_10_02/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/E1_05_2023_10_02_S13_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E1_05_2023_10_02/20231013_HLLJMDRX3/raw_data/E1_05_2023_10_02_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/E1_05_2023_10_02_S13_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E1_05_2023_10_02/20231013_HLLJMDRX3/raw_data/E1_05_2023_10_02_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E2_12_2023_09_29/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/E2_12_2023_09_29_S50_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E2_12_2023_09_29/20231013_HLLJMDRX3/raw_data/E2_12_2023_09_29_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/E2_12_2023_09_29_S50_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E2_12_2023_09_29/20231013_HLLJMDRX3/raw_data/E2_12_2023_09_29_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E3_16_2023_09_28/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/E3_16_2023_09_28_S68_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E3_16_2023_09_28/20231013_HLLJMDRX3/raw_data/E3_16_2023_09_28_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/E3_16_2023_09_28_S68_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E3_16_2023_09_28/20231013_HLLJMDRX3/raw_data/E3_16_2023_09_28_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E4_17_2023_09_30/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/E4_17_2023_09_30_S2_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E4_17_2023_09_30/20231013_HLLJMDRX3/raw_data/E4_17_2023_09_30_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/E4_17_2023_09_30_S2_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E4_17_2023_09_30/20231013_HLLJMDRX3/raw_data/E4_17_2023_09_30_R2.fastq.gz"||X
echo -ne "\r[█▏··············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E5_19_2023_09_29/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/E5_19_2023_09_29_S43_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E5_19_2023_09_29/20231013_HLLJMDRX3/raw_data/E5_19_2023_09_29_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/E5_19_2023_09_29_S43_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E5_19_2023_09_29/20231013_HLLJMDRX3/raw_data/E5_19_2023_09_29_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E6_25_2023_10_02/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/E6_25_2023_10_02_S11_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E6_25_2023_10_02/20231013_HLLJMDRX3/raw_data/E6_25_2023_10_02_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/E6_25_2023_10_02_S11_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E6_25_2023_10_02/20231013_HLLJMDRX3/raw_data/E6_25_2023_10_02_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E7_33_2023_10_01/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/E7_33_2023_10_01_S44_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E7_33_2023_10_01/20231013_HLLJMDRX3/raw_data/E7_33_2023_10_01_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/E7_33_2023_10_01_S44_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E7_33_2023_10_01/20231013_HLLJMDRX3/raw_data/E7_33_2023_10_01_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E8_35_2023_09_26/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/E8_35_2023_09_26_S54_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E8_35_2023_09_26/20231013_HLLJMDRX3/raw_data/E8_35_2023_09_26_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/E8_35_2023_09_26_S54_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E8_35_2023_09_26/20231013_HLLJMDRX3/raw_data/E8_35_2023_09_26_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E9_36_2023_10_02/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/E9_36_2023_10_02_S42_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E9_36_2023_10_02/20231013_HLLJMDRX3/raw_data/E9_36_2023_10_02_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/E9_36_2023_10_02_S42_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E9_36_2023_10_02/20231013_HLLJMDRX3/raw_data/E9_36_2023_10_02_R2.fastq.gz"||X
echo -ne "\r[█▎··············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F1_10_2023_09_26/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/F1_10_2023_09_26_S36_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F1_10_2023_09_26/20231013_HLLJMDRX3/raw_data/F1_10_2023_09_26_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/F1_10_2023_09_26_S36_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F1_10_2023_09_26/20231013_HLLJMDRX3/raw_data/F1_10_2023_09_26_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F2_12_2023_09_30/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/F2_12_2023_09_30_S46_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F2_12_2023_09_30/20231013_HLLJMDRX3/raw_data/F2_12_2023_09_30_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/F2_12_2023_09_30_S46_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F2_12_2023_09_30/20231013_HLLJMDRX3/raw_data/F2_12_2023_09_30_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F3_16_2023_09_30/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/F3_16_2023_09_30_S45_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F3_16_2023_09_30/20231013_HLLJMDRX3/raw_data/F3_16_2023_09_30_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/F3_16_2023_09_30_S45_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F3_16_2023_09_30/20231013_HLLJMDRX3/raw_data/F3_16_2023_09_30_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F4_17_2023_10_01/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/F4_17_2023_10_01_S41_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F4_17_2023_10_01/20231013_HLLJMDRX3/raw_data/F4_17_2023_10_01_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/F4_17_2023_10_01_S41_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F4_17_2023_10_01/20231013_HLLJMDRX3/raw_data/F4_17_2023_10_01_R2.fastq.gz"||X
echo -ne "\r[█▍··············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F5_19_2023_09_30/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/F5_19_2023_09_30_S19_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F5_19_2023_09_30/20231013_HLLJMDRX3/raw_data/F5_19_2023_09_30_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/F5_19_2023_09_30_S19_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F5_19_2023_09_30/20231013_HLLJMDRX3/raw_data/F5_19_2023_09_30_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F6_32_2023_09_28/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/F6_32_2023_09_28_S33_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F6_32_2023_09_28/20231013_HLLJMDRX3/raw_data/F6_32_2023_09_28_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/F6_32_2023_09_28_S33_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F6_32_2023_09_28/20231013_HLLJMDRX3/raw_data/F6_32_2023_09_28_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F7_33_2023_10_02/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/F7_33_2023_10_02_S27_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F7_33_2023_10_02/20231013_HLLJMDRX3/raw_data/F7_33_2023_10_02_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/F7_33_2023_10_02_S27_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F7_33_2023_10_02/20231013_HLLJMDRX3/raw_data/F7_33_2023_10_02_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F8_35_2023_09_28/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/F8_35_2023_09_28_S20_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F8_35_2023_09_28/20231013_HLLJMDRX3/raw_data/F8_35_2023_09_28_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/F8_35_2023_09_28_S20_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F8_35_2023_09_28/20231013_HLLJMDRX3/raw_data/F8_35_2023_09_28_R2.fastq.gz"||X
echo -ne "\r[█▌··············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F9_36_2023_10_03/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/F9_36_2023_10_03_S8_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F9_36_2023_10_03/20231013_HLLJMDRX3/raw_data/F9_36_2023_10_03_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/F9_36_2023_10_03_S8_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F9_36_2023_10_03/20231013_HLLJMDRX3/raw_data/F9_36_2023_10_03_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G1_10_2023_09_28/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/G1_10_2023_09_28_S59_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G1_10_2023_09_28/20231013_HLLJMDRX3/raw_data/G1_10_2023_09_28_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/G1_10_2023_09_28_S59_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G1_10_2023_09_28/20231013_HLLJMDRX3/raw_data/G1_10_2023_09_28_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G2_12_2023_10_01/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/G2_12_2023_10_01_S40_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G2_12_2023_10_01/20231013_HLLJMDRX3/raw_data/G2_12_2023_10_01_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/G2_12_2023_10_01_S40_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G2_12_2023_10_01/20231013_HLLJMDRX3/raw_data/G2_12_2023_10_01_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G3_16_2023_10_01/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/G3_16_2023_10_01_S12_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G3_16_2023_10_01/20231013_HLLJMDRX3/raw_data/G3_16_2023_10_01_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/G3_16_2023_10_01_S12_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G3_16_2023_10_01/20231013_HLLJMDRX3/raw_data/G3_16_2023_10_01_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G4_18_2023_09_27/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/G4_18_2023_09_27_S69_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G4_18_2023_09_27/20231013_HLLJMDRX3/raw_data/G4_18_2023_09_27_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/G4_18_2023_09_27_S69_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G4_18_2023_09_27/20231013_HLLJMDRX3/raw_data/G4_18_2023_09_27_R2.fastq.gz"||X
echo -ne "\r[█▋··············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G5_19_2023_10_01/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/G5_19_2023_10_01_S62_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G5_19_2023_10_01/20231013_HLLJMDRX3/raw_data/G5_19_2023_10_01_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/G5_19_2023_10_01_S62_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G5_19_2023_10_01/20231013_HLLJMDRX3/raw_data/G5_19_2023_10_01_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G6_32_2023_09_30/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/G6_32_2023_09_30_S67_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G6_32_2023_09_30/20231013_HLLJMDRX3/raw_data/G6_32_2023_09_30_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/G6_32_2023_09_30_S67_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G6_32_2023_09_30/20231013_HLLJMDRX3/raw_data/G6_32_2023_09_30_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G7_33_2023_10_03/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/G7_33_2023_10_03_S35_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G7_33_2023_10_03/20231013_HLLJMDRX3/raw_data/G7_33_2023_10_03_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/G7_33_2023_10_03_S35_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G7_33_2023_10_03/20231013_HLLJMDRX3/raw_data/G7_33_2023_10_03_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G8_35_2023_09_29/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/G8_35_2023_09_29_S26_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G8_35_2023_09_29/20231013_HLLJMDRX3/raw_data/G8_35_2023_09_29_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/G8_35_2023_09_29_S26_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G8_35_2023_09_29/20231013_HLLJMDRX3/raw_data/G8_35_2023_09_29_R2.fastq.gz"||X
echo -ne "\r[█▊··············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H1_10_2023_09_29/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/H1_10_2023_09_29_S30_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H1_10_2023_09_29/20231013_HLLJMDRX3/raw_data/H1_10_2023_09_29_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/H1_10_2023_09_29_S30_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H1_10_2023_09_29/20231013_HLLJMDRX3/raw_data/H1_10_2023_09_29_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H2_15_2023_09_27/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/H2_15_2023_09_27_S14_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H2_15_2023_09_27/20231013_HLLJMDRX3/raw_data/H2_15_2023_09_27_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/H2_15_2023_09_27_S14_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H2_15_2023_09_27/20231013_HLLJMDRX3/raw_data/H2_15_2023_09_27_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H3_16_2023_10_02/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/H3_16_2023_10_02_S49_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H3_16_2023_10_02/20231013_HLLJMDRX3/raw_data/H3_16_2023_10_02_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/H3_16_2023_10_02_S49_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H3_16_2023_10_02/20231013_HLLJMDRX3/raw_data/H3_16_2023_10_02_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H4_18_2023_09_29/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/H4_18_2023_09_29_S63_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H4_18_2023_09_29/20231013_HLLJMDRX3/raw_data/H4_18_2023_09_29_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/H4_18_2023_09_29_S63_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H4_18_2023_09_29/20231013_HLLJMDRX3/raw_data/H4_18_2023_09_29_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H5_19_2023_10_02/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/H5_19_2023_10_02_S48_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H5_19_2023_10_02/20231013_HLLJMDRX3/raw_data/H5_19_2023_10_02_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/H5_19_2023_10_02_S48_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H5_19_2023_10_02/20231013_HLLJMDRX3/raw_data/H5_19_2023_10_02_R2.fastq.gz"||X
echo -ne "\r[█▉··············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H6_32_2023_10_01/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/H6_32_2023_10_01_S47_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H6_32_2023_10_01/20231013_HLLJMDRX3/raw_data/H6_32_2023_10_01_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/H6_32_2023_10_01_S47_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H6_32_2023_10_01/20231013_HLLJMDRX3/raw_data/H6_32_2023_10_01_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H7_34_2023_09_26/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/H7_34_2023_09_26_S21_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H7_34_2023_09_26/20231013_HLLJMDRX3/raw_data/H7_34_2023_09_26_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/H7_34_2023_09_26_S21_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H7_34_2023_09_26/20231013_HLLJMDRX3/raw_data/H7_34_2023_09_26_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H8_35_2023_09_30/"{,"20231013_HLLJMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/H8_35_2023_09_30_S18_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H8_35_2023_09_30/20231013_HLLJMDRX3/raw_data/H8_35_2023_09_30_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33104_NovaSeq_231013_NOV1899/H8_35_2023_09_30_S18_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H8_35_2023_09_30/20231013_HLLJMDRX3/raw_data/H8_35_2023_09_30_R2.fastq.gz"||X
if [[ ! -d "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904" ]]; then
    fail "Not a directory:" "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904"
fi

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A1_05_2023_10_03/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/A1_05_2023_10_03_S13_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A1_05_2023_10_03/20231020_HLNKVDRX3/raw_data/A1_05_2023_10_03_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/A1_05_2023_10_03_S13_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A1_05_2023_10_03/20231020_HLNKVDRX3/raw_data/A1_05_2023_10_03_R2.fastq.gz"||X
echo -ne "\r[██··············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A2_10_2023_10_07/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/A2_10_2023_10_07_S16_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A2_10_2023_10_07/20231020_HLNKVDRX3/raw_data/A2_10_2023_10_07_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/A2_10_2023_10_07_S16_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A2_10_2023_10_07/20231020_HLNKVDRX3/raw_data/A2_10_2023_10_07_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A3_15_2023_10_03/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/A3_15_2023_10_03_S51_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A3_15_2023_10_03/20231020_HLNKVDRX3/raw_data/A3_15_2023_10_03_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/A3_15_2023_10_03_S51_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A3_15_2023_10_03/20231020_HLNKVDRX3/raw_data/A3_15_2023_10_03_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A4_16_2023_10_10/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/A4_16_2023_10_10_S58_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A4_16_2023_10_10/20231020_HLNKVDRX3/raw_data/A4_16_2023_10_10_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/A4_16_2023_10_10_S58_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A4_16_2023_10_10/20231020_HLNKVDRX3/raw_data/A4_16_2023_10_10_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A5_18_2023_10_07/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/A5_18_2023_10_07_S54_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A5_18_2023_10_07/20231020_HLNKVDRX3/raw_data/A5_18_2023_10_07_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/A5_18_2023_10_07_S54_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A5_18_2023_10_07/20231020_HLNKVDRX3/raw_data/A5_18_2023_10_07_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A6_25_2023_10_03/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/A6_25_2023_10_03_S2_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A6_25_2023_10_03/20231020_HLNKVDRX3/raw_data/A6_25_2023_10_03_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/A6_25_2023_10_03_S2_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A6_25_2023_10_03/20231020_HLNKVDRX3/raw_data/A6_25_2023_10_03_R2.fastq.gz"||X
echo -ne "\r[██▏·············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A7_32_2023_10_10/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/A7_32_2023_10_10_S1_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A7_32_2023_10_10/20231020_HLNKVDRX3/raw_data/A7_32_2023_10_10_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/A7_32_2023_10_10_S1_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A7_32_2023_10_10/20231020_HLNKVDRX3/raw_data/A7_32_2023_10_10_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A8_34_2023_10_06/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/A8_34_2023_10_06_S20_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A8_34_2023_10_06/20231020_HLNKVDRX3/raw_data/A8_34_2023_10_06_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/A8_34_2023_10_06_S20_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A8_34_2023_10_06/20231020_HLNKVDRX3/raw_data/A8_34_2023_10_06_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A9_36_2023_10_04/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/A9_36_2023_10_04_S26_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A9_36_2023_10_04/20231020_HLNKVDRX3/raw_data/A9_36_2023_10_04_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/A9_36_2023_10_04_S26_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A9_36_2023_10_04/20231020_HLNKVDRX3/raw_data/A9_36_2023_10_04_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B1_05_2023_10_05/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/B1_05_2023_10_05_S21_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B1_05_2023_10_05/20231020_HLNKVDRX3/raw_data/B1_05_2023_10_05_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/B1_05_2023_10_05_S21_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B1_05_2023_10_05/20231020_HLNKVDRX3/raw_data/B1_05_2023_10_05_R2.fastq.gz"||X
echo -ne "\r[██▎·············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B2_10_2023_10_08/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/B2_10_2023_10_08_S37_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B2_10_2023_10_08/20231020_HLNKVDRX3/raw_data/B2_10_2023_10_08_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/B2_10_2023_10_08_S37_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B2_10_2023_10_08/20231020_HLNKVDRX3/raw_data/B2_10_2023_10_08_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B3_15_2023_10_07/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/B3_15_2023_10_07_S22_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B3_15_2023_10_07/20231020_HLNKVDRX3/raw_data/B3_15_2023_10_07_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/B3_15_2023_10_07_S22_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B3_15_2023_10_07/20231020_HLNKVDRX3/raw_data/B3_15_2023_10_07_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B4_17_2023_10_02/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/B4_17_2023_10_02_S29_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B4_17_2023_10_02/20231020_HLNKVDRX3/raw_data/B4_17_2023_10_02_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/B4_17_2023_10_02_S29_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B4_17_2023_10_02/20231020_HLNKVDRX3/raw_data/B4_17_2023_10_02_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B5_18_2023_10_08/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/B5_18_2023_10_08_S36_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B5_18_2023_10_08/20231020_HLNKVDRX3/raw_data/B5_18_2023_10_08_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/B5_18_2023_10_08_S36_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B5_18_2023_10_08/20231020_HLNKVDRX3/raw_data/B5_18_2023_10_08_R2.fastq.gz"||X
echo -ne "\r[██▍·············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B6_25_2023_10_05/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/B6_25_2023_10_05_S3_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B6_25_2023_10_05/20231020_HLNKVDRX3/raw_data/B6_25_2023_10_05_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/B6_25_2023_10_05_S3_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B6_25_2023_10_05/20231020_HLNKVDRX3/raw_data/B6_25_2023_10_05_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B7_33_2023_10_04/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/B7_33_2023_10_04_S43_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B7_33_2023_10_04/20231020_HLNKVDRX3/raw_data/B7_33_2023_10_04_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/B7_33_2023_10_04_S43_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B7_33_2023_10_04/20231020_HLNKVDRX3/raw_data/B7_33_2023_10_04_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B8_34_2023_10_07/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/B8_34_2023_10_07_S38_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B8_34_2023_10_07/20231020_HLNKVDRX3/raw_data/B8_34_2023_10_07_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/B8_34_2023_10_07_S38_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B8_34_2023_10_07/20231020_HLNKVDRX3/raw_data/B8_34_2023_10_07_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B9_36_2023_10_06/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/B9_36_2023_10_06_S30_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B9_36_2023_10_06/20231020_HLNKVDRX3/raw_data/B9_36_2023_10_06_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/B9_36_2023_10_06_S30_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B9_36_2023_10_06/20231020_HLNKVDRX3/raw_data/B9_36_2023_10_06_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C1_05_2023_10_07/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/C1_05_2023_10_07_S34_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C1_05_2023_10_07/20231020_HLNKVDRX3/raw_data/C1_05_2023_10_07_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/C1_05_2023_10_07_S34_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C1_05_2023_10_07/20231020_HLNKVDRX3/raw_data/C1_05_2023_10_07_R2.fastq.gz"||X
echo -ne "\r[██▌·············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C2_12_2023_10_02/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/C2_12_2023_10_02_S60_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C2_12_2023_10_02/20231020_HLNKVDRX3/raw_data/C2_12_2023_10_02_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/C2_12_2023_10_02_S60_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C2_12_2023_10_02/20231020_HLNKVDRX3/raw_data/C2_12_2023_10_02_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C3_15_2023_10_08/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/C3_15_2023_10_08_S15_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C3_15_2023_10_08/20231020_HLNKVDRX3/raw_data/C3_15_2023_10_08_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/C3_15_2023_10_08_S15_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C3_15_2023_10_08/20231020_HLNKVDRX3/raw_data/C3_15_2023_10_08_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C4_17_2023_10_04/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/C4_17_2023_10_04_S35_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C4_17_2023_10_04/20231020_HLNKVDRX3/raw_data/C4_17_2023_10_04_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/C4_17_2023_10_04_S35_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C4_17_2023_10_04/20231020_HLNKVDRX3/raw_data/C4_17_2023_10_04_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C5_18_2023_10_09/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/C5_18_2023_10_09_S19_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C5_18_2023_10_09/20231020_HLNKVDRX3/raw_data/C5_18_2023_10_09_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/C5_18_2023_10_09_S19_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C5_18_2023_10_09/20231020_HLNKVDRX3/raw_data/C5_18_2023_10_09_R2.fastq.gz"||X
echo -ne "\r[██▋·············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C6_25_2023_10_07/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/C6_25_2023_10_07_S59_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C6_25_2023_10_07/20231020_HLNKVDRX3/raw_data/C6_25_2023_10_07_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/C6_25_2023_10_07_S59_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C6_25_2023_10_07/20231020_HLNKVDRX3/raw_data/C6_25_2023_10_07_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C7_33_2023_10_06/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/C7_33_2023_10_06_S11_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C7_33_2023_10_06/20231020_HLNKVDRX3/raw_data/C7_33_2023_10_06_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/C7_33_2023_10_06_S11_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C7_33_2023_10_06/20231020_HLNKVDRX3/raw_data/C7_33_2023_10_06_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C8_34_2023_10_08/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/C8_34_2023_10_08_S17_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C8_34_2023_10_08/20231020_HLNKVDRX3/raw_data/C8_34_2023_10_08_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/C8_34_2023_10_08_S17_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C8_34_2023_10_08/20231020_HLNKVDRX3/raw_data/C8_34_2023_10_08_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C9_36_2023_10_08/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/C9_36_2023_10_08_S10_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C9_36_2023_10_08/20231020_HLNKVDRX3/raw_data/C9_36_2023_10_08_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/C9_36_2023_10_08_S10_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C9_36_2023_10_08/20231020_HLNKVDRX3/raw_data/C9_36_2023_10_08_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D1_05_2023_10_08/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/D1_05_2023_10_08_S31_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D1_05_2023_10_08/20231020_HLNKVDRX3/raw_data/D1_05_2023_10_08_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/D1_05_2023_10_08_S31_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D1_05_2023_10_08/20231020_HLNKVDRX3/raw_data/D1_05_2023_10_08_R2.fastq.gz"||X
echo -ne "\r[██▊·············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D2_12_2023_10_04/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/D2_12_2023_10_04_S67_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D2_12_2023_10_04/20231020_HLNKVDRX3/raw_data/D2_12_2023_10_04_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/D2_12_2023_10_04_S67_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D2_12_2023_10_04/20231020_HLNKVDRX3/raw_data/D2_12_2023_10_04_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D3_15_2023_10_09/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/D3_15_2023_10_09_S56_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D3_15_2023_10_09/20231020_HLNKVDRX3/raw_data/D3_15_2023_10_09_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/D3_15_2023_10_09_S56_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D3_15_2023_10_09/20231020_HLNKVDRX3/raw_data/D3_15_2023_10_09_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D4_17_2023_10_06/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/D4_17_2023_10_06_S39_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D4_17_2023_10_06/20231020_HLNKVDRX3/raw_data/D4_17_2023_10_06_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/D4_17_2023_10_06_S39_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D4_17_2023_10_06/20231020_HLNKVDRX3/raw_data/D4_17_2023_10_06_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D5_19_2023_10_03/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/D5_19_2023_10_03_S63_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D5_19_2023_10_03/20231020_HLNKVDRX3/raw_data/D5_19_2023_10_03_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/D5_19_2023_10_03_S63_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D5_19_2023_10_03/20231020_HLNKVDRX3/raw_data/D5_19_2023_10_03_R2.fastq.gz"||X
echo -ne "\r[██▉·············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D6_25_2023_10_08/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/D6_25_2023_10_08_S55_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D6_25_2023_10_08/20231020_HLNKVDRX3/raw_data/D6_25_2023_10_08_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/D6_25_2023_10_08_S55_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D6_25_2023_10_08/20231020_HLNKVDRX3/raw_data/D6_25_2023_10_08_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D7_33_2023_10_08/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/D7_33_2023_10_08_S69_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D7_33_2023_10_08/20231020_HLNKVDRX3/raw_data/D7_33_2023_10_08_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/D7_33_2023_10_08_S69_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D7_33_2023_10_08/20231020_HLNKVDRX3/raw_data/D7_33_2023_10_08_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D8_35_2023_10_02/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/D8_35_2023_10_02_S57_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D8_35_2023_10_02/20231020_HLNKVDRX3/raw_data/D8_35_2023_10_02_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/D8_35_2023_10_02_S57_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D8_35_2023_10_02/20231020_HLNKVDRX3/raw_data/D8_35_2023_10_02_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D9_36_2023_10_09/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/D9_36_2023_10_09_S47_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D9_36_2023_10_09/20231020_HLNKVDRX3/raw_data/D9_36_2023_10_09_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/D9_36_2023_10_09_S47_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D9_36_2023_10_09/20231020_HLNKVDRX3/raw_data/D9_36_2023_10_09_R2.fastq.gz"||X
echo -ne "\r[███·············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E1_05_2023_10_09/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/E1_05_2023_10_09_S9_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E1_05_2023_10_09/20231020_HLNKVDRX3/raw_data/E1_05_2023_10_09_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/E1_05_2023_10_09_S9_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E1_05_2023_10_09/20231020_HLNKVDRX3/raw_data/E1_05_2023_10_09_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E2_12_2023_10_06/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/E2_12_2023_10_06_S24_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E2_12_2023_10_06/20231020_HLNKVDRX3/raw_data/E2_12_2023_10_06_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/E2_12_2023_10_06_S24_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E2_12_2023_10_06/20231020_HLNKVDRX3/raw_data/E2_12_2023_10_06_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E3_16_2023_10_04/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/E3_16_2023_10_04_S25_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E3_16_2023_10_04/20231020_HLNKVDRX3/raw_data/E3_16_2023_10_04_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/E3_16_2023_10_04_S25_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E3_16_2023_10_04/20231020_HLNKVDRX3/raw_data/E3_16_2023_10_04_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E4_17_2023_10_07/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/E4_17_2023_10_07_S14_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E4_17_2023_10_07/20231020_HLNKVDRX3/raw_data/E4_17_2023_10_07_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/E4_17_2023_10_07_S14_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E4_17_2023_10_07/20231020_HLNKVDRX3/raw_data/E4_17_2023_10_07_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E5_19_2023_10_05/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/E5_19_2023_10_05_S62_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E5_19_2023_10_05/20231020_HLNKVDRX3/raw_data/E5_19_2023_10_05_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/E5_19_2023_10_05_S62_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E5_19_2023_10_05/20231020_HLNKVDRX3/raw_data/E5_19_2023_10_05_R2.fastq.gz"||X
echo -ne "\r[███▏············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E6_25_2023_10_09/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/E6_25_2023_10_09_S68_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E6_25_2023_10_09/20231020_HLNKVDRX3/raw_data/E6_25_2023_10_09_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/E6_25_2023_10_09_S68_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E6_25_2023_10_09/20231020_HLNKVDRX3/raw_data/E6_25_2023_10_09_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E7_33_2023_10_09/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/E7_33_2023_10_09_S64_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E7_33_2023_10_09/20231020_HLNKVDRX3/raw_data/E7_33_2023_10_09_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/E7_33_2023_10_09_S64_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E7_33_2023_10_09/20231020_HLNKVDRX3/raw_data/E7_33_2023_10_09_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E8_35_2023_10_04/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/E8_35_2023_10_04_S42_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E8_35_2023_10_04/20231020_HLNKVDRX3/raw_data/E8_35_2023_10_04_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/E8_35_2023_10_04_S42_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E8_35_2023_10_04/20231020_HLNKVDRX3/raw_data/E8_35_2023_10_04_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E9_36_2023_10_10/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/E9_36_2023_10_10_S52_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E9_36_2023_10_10/20231020_HLNKVDRX3/raw_data/E9_36_2023_10_10_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/E9_36_2023_10_10_S52_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E9_36_2023_10_10/20231020_HLNKVDRX3/raw_data/E9_36_2023_10_10_R2.fastq.gz"||X
echo -ne "\r[███▎············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F1_10_2023_10_02/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/F1_10_2023_10_02_S48_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F1_10_2023_10_02/20231020_HLNKVDRX3/raw_data/F1_10_2023_10_02_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/F1_10_2023_10_02_S48_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F1_10_2023_10_02/20231020_HLNKVDRX3/raw_data/F1_10_2023_10_02_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F2_12_2023_10_07/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/F2_12_2023_10_07_S33_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F2_12_2023_10_07/20231020_HLNKVDRX3/raw_data/F2_12_2023_10_07_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/F2_12_2023_10_07_S33_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F2_12_2023_10_07/20231020_HLNKVDRX3/raw_data/F2_12_2023_10_07_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F3_16_2023_10_06/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/F3_16_2023_10_06_S4_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F3_16_2023_10_06/20231020_HLNKVDRX3/raw_data/F3_16_2023_10_06_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/F3_16_2023_10_06_S4_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F3_16_2023_10_06/20231020_HLNKVDRX3/raw_data/F3_16_2023_10_06_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F4_17_2023_10_08/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/F4_17_2023_10_08_S5_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F4_17_2023_10_08/20231020_HLNKVDRX3/raw_data/F4_17_2023_10_08_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/F4_17_2023_10_08_S5_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F4_17_2023_10_08/20231020_HLNKVDRX3/raw_data/F4_17_2023_10_08_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F5_19_2023_10_07/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/F5_19_2023_10_07_S46_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F5_19_2023_10_07/20231020_HLNKVDRX3/raw_data/F5_19_2023_10_07_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/F5_19_2023_10_07_S46_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F5_19_2023_10_07/20231020_HLNKVDRX3/raw_data/F5_19_2023_10_07_R2.fastq.gz"||X
echo -ne "\r[███▍············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F6_32_2023_10_06/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/F6_32_2023_10_06_S7_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F6_32_2023_10_06/20231020_HLNKVDRX3/raw_data/F6_32_2023_10_06_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/F6_32_2023_10_06_S7_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F6_32_2023_10_06/20231020_HLNKVDRX3/raw_data/F6_32_2023_10_06_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F7_33_2023_10_10/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/F7_33_2023_10_10_S28_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F7_33_2023_10_10/20231020_HLNKVDRX3/raw_data/F7_33_2023_10_10_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/F7_33_2023_10_10_S28_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F7_33_2023_10_10/20231020_HLNKVDRX3/raw_data/F7_33_2023_10_10_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F8_35_2023_10_06/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/F8_35_2023_10_06_S50_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F8_35_2023_10_06/20231020_HLNKVDRX3/raw_data/F8_35_2023_10_06_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/F8_35_2023_10_06_S50_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F8_35_2023_10_06/20231020_HLNKVDRX3/raw_data/F8_35_2023_10_06_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G1_10_2023_10_04/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/G1_10_2023_10_04_S45_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G1_10_2023_10_04/20231020_HLNKVDRX3/raw_data/G1_10_2023_10_04_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/G1_10_2023_10_04_S45_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G1_10_2023_10_04/20231020_HLNKVDRX3/raw_data/G1_10_2023_10_04_R2.fastq.gz"||X
echo -ne "\r[███▌············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G2_12_2023_10_08/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/G2_12_2023_10_08_S44_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G2_12_2023_10_08/20231020_HLNKVDRX3/raw_data/G2_12_2023_10_08_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/G2_12_2023_10_08_S44_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G2_12_2023_10_08/20231020_HLNKVDRX3/raw_data/G2_12_2023_10_08_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G3_16_2023_10_08/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/G3_16_2023_10_08_S40_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G3_16_2023_10_08/20231020_HLNKVDRX3/raw_data/G3_16_2023_10_08_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/G3_16_2023_10_08_S40_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G3_16_2023_10_08/20231020_HLNKVDRX3/raw_data/G3_16_2023_10_08_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G4_18_2023_10_03/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/G4_18_2023_10_03_S65_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G4_18_2023_10_03/20231020_HLNKVDRX3/raw_data/G4_18_2023_10_03_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/G4_18_2023_10_03_S65_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G4_18_2023_10_03/20231020_HLNKVDRX3/raw_data/G4_18_2023_10_03_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G5_19_2023_10_08/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/G5_19_2023_10_08_S8_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G5_19_2023_10_08/20231020_HLNKVDRX3/raw_data/G5_19_2023_10_08_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/G5_19_2023_10_08_S8_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G5_19_2023_10_08/20231020_HLNKVDRX3/raw_data/G5_19_2023_10_08_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G6_32_2023_10_08/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/G6_32_2023_10_08_S53_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G6_32_2023_10_08/20231020_HLNKVDRX3/raw_data/G6_32_2023_10_08_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/G6_32_2023_10_08_S53_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G6_32_2023_10_08/20231020_HLNKVDRX3/raw_data/G6_32_2023_10_08_R2.fastq.gz"||X
echo -ne "\r[███▋············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G7_34_2023_10_02/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/G7_34_2023_10_02_S6_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G7_34_2023_10_02/20231020_HLNKVDRX3/raw_data/G7_34_2023_10_02_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/G7_34_2023_10_02_S6_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G7_34_2023_10_02/20231020_HLNKVDRX3/raw_data/G7_34_2023_10_02_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G8_35_2023_10_07/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/G8_35_2023_10_07_S41_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G8_35_2023_10_07/20231020_HLNKVDRX3/raw_data/G8_35_2023_10_07_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/G8_35_2023_10_07_S41_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G8_35_2023_10_07/20231020_HLNKVDRX3/raw_data/G8_35_2023_10_07_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H1_10_2023_10_06/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/H1_10_2023_10_06_S18_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H1_10_2023_10_06/20231020_HLNKVDRX3/raw_data/H1_10_2023_10_06_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/H1_10_2023_10_06_S18_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H1_10_2023_10_06/20231020_HLNKVDRX3/raw_data/H1_10_2023_10_06_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H2_15_2023_10_05/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/H2_15_2023_10_05_S32_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H2_15_2023_10_05/20231020_HLNKVDRX3/raw_data/H2_15_2023_10_05_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/H2_15_2023_10_05_S32_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H2_15_2023_10_05/20231020_HLNKVDRX3/raw_data/H2_15_2023_10_05_R2.fastq.gz"||X
echo -ne "\r[███▊············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H3_16_2023_10_09/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/H3_16_2023_10_09_S49_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H3_16_2023_10_09/20231020_HLNKVDRX3/raw_data/H3_16_2023_10_09_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/H3_16_2023_10_09_S49_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H3_16_2023_10_09/20231020_HLNKVDRX3/raw_data/H3_16_2023_10_09_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H4_18_2023_10_05/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/H4_18_2023_10_05_S61_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H4_18_2023_10_05/20231020_HLNKVDRX3/raw_data/H4_18_2023_10_05_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/H4_18_2023_10_05_S61_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H4_18_2023_10_05/20231020_HLNKVDRX3/raw_data/H4_18_2023_10_05_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H5_19_2023_10_09/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/H5_19_2023_10_09_S66_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H5_19_2023_10_09/20231020_HLNKVDRX3/raw_data/H5_19_2023_10_09_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/H5_19_2023_10_09_S66_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H5_19_2023_10_09/20231020_HLNKVDRX3/raw_data/H5_19_2023_10_09_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H6_32_2023_10_09/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/H6_32_2023_10_09_S23_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H6_32_2023_10_09/20231020_HLNKVDRX3/raw_data/H6_32_2023_10_09_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/H6_32_2023_10_09_S23_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H6_32_2023_10_09/20231020_HLNKVDRX3/raw_data/H6_32_2023_10_09_R2.fastq.gz"||X
echo -ne "\r[███▉············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H7_34_2023_10_04/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/H7_34_2023_10_04_S12_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H7_34_2023_10_04/20231020_HLNKVDRX3/raw_data/H7_34_2023_10_04_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/H7_34_2023_10_04_S12_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H7_34_2023_10_04/20231020_HLNKVDRX3/raw_data/H7_34_2023_10_04_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H8_35_2023_10_08/"{,"20231020_HLNKVDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/H8_35_2023_10_08_S27_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H8_35_2023_10_08/20231020_HLNKVDRX3/raw_data/H8_35_2023_10_08_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33160_NovaSeq_231020_NOV1904/H8_35_2023_10_08_S27_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H8_35_2023_10_08/20231020_HLNKVDRX3/raw_data/H8_35_2023_10_08_R2.fastq.gz"||X
if [[ ! -d "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897" ]]; then
    fail "Not a directory:" "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897"
fi
mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A1_05_2023_09_19/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/A1_05_2023_09_19_S5_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A1_05_2023_09_19/20231006_HLLLTDRX3/raw_data/A1_05_2023_09_19_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/A1_05_2023_09_19_S5_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A1_05_2023_09_19/20231006_HLLLTDRX3/raw_data/A1_05_2023_09_19_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A2_10_2023_09_23/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/A2_10_2023_09_23_S53_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A2_10_2023_09_23/20231006_HLLLTDRX3/raw_data/A2_10_2023_09_23_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/A2_10_2023_09_23_S53_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A2_10_2023_09_23/20231006_HLLLTDRX3/raw_data/A2_10_2023_09_23_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A3_15_2023_09_19/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/A3_15_2023_09_19_S29_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A3_15_2023_09_19/20231006_HLLLTDRX3/raw_data/A3_15_2023_09_19_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/A3_15_2023_09_19_S29_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A3_15_2023_09_19/20231006_HLLLTDRX3/raw_data/A3_15_2023_09_19_R2.fastq.gz"||X
echo -ne "\r[████············]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A4_16_2023_09_26/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/A4_16_2023_09_26_S38_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A4_16_2023_09_26/20231006_HLLLTDRX3/raw_data/A4_16_2023_09_26_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/A4_16_2023_09_26_S38_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A4_16_2023_09_26/20231006_HLLLTDRX3/raw_data/A4_16_2023_09_26_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A5_18_2023_09_23/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/A5_18_2023_09_23_S54_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A5_18_2023_09_23/20231006_HLLLTDRX3/raw_data/A5_18_2023_09_23_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/A5_18_2023_09_23_S54_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A5_18_2023_09_23/20231006_HLLLTDRX3/raw_data/A5_18_2023_09_23_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A6_25_2023_09_19/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/A6_25_2023_09_19_S7_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A6_25_2023_09_19/20231006_HLLLTDRX3/raw_data/A6_25_2023_09_19_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/A6_25_2023_09_19_S7_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A6_25_2023_09_19/20231006_HLLLTDRX3/raw_data/A6_25_2023_09_19_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A7_33_2023_09_25/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/A7_33_2023_09_25_S17_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A7_33_2023_09_25/20231006_HLLLTDRX3/raw_data/A7_33_2023_09_25_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/A7_33_2023_09_25_S17_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A7_33_2023_09_25/20231006_HLLLTDRX3/raw_data/A7_33_2023_09_25_R2.fastq.gz"||X
echo -ne "\r[████▏···········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A8_35_2023_09_20/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/A8_35_2023_09_20_S20_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A8_35_2023_09_20/20231006_HLLLTDRX3/raw_data/A8_35_2023_09_20_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/A8_35_2023_09_20_S20_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A8_35_2023_09_20/20231006_HLLLTDRX3/raw_data/A8_35_2023_09_20_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A9_36_2023_09_26/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/A9_36_2023_09_26_S11_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A9_36_2023_09_26/20231006_HLLLTDRX3/raw_data/A9_36_2023_09_26_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/A9_36_2023_09_26_S11_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A9_36_2023_09_26/20231006_HLLLTDRX3/raw_data/A9_36_2023_09_26_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B1_05_2023_09_21/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/B1_05_2023_09_21_S21_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B1_05_2023_09_21/20231006_HLLLTDRX3/raw_data/B1_05_2023_09_21_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/B1_05_2023_09_21_S21_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B1_05_2023_09_21/20231006_HLLLTDRX3/raw_data/B1_05_2023_09_21_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B2_10_2023_09_24/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/B2_10_2023_09_24_S43_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B2_10_2023_09_24/20231006_HLLLTDRX3/raw_data/B2_10_2023_09_24_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/B2_10_2023_09_24_S43_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B2_10_2023_09_24/20231006_HLLLTDRX3/raw_data/B2_10_2023_09_24_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B3_15_2023_09_23/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/B3_15_2023_09_23_S32_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B3_15_2023_09_23/20231006_HLLLTDRX3/raw_data/B3_15_2023_09_23_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/B3_15_2023_09_23_S32_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B3_15_2023_09_23/20231006_HLLLTDRX3/raw_data/B3_15_2023_09_23_R2.fastq.gz"||X
echo -ne "\r[████▎···········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B4_17_2023_09_18/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/B4_17_2023_09_18_S59_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B4_17_2023_09_18/20231006_HLLLTDRX3/raw_data/B4_17_2023_09_18_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/B4_17_2023_09_18_S59_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B4_17_2023_09_18/20231006_HLLLTDRX3/raw_data/B4_17_2023_09_18_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B5_18_2023_09_24/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/B5_18_2023_09_24_S19_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B5_18_2023_09_24/20231006_HLLLTDRX3/raw_data/B5_18_2023_09_24_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/B5_18_2023_09_24_S19_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B5_18_2023_09_24/20231006_HLLLTDRX3/raw_data/B5_18_2023_09_24_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B6_25_2023_09_21/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/B6_25_2023_09_21_S39_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B6_25_2023_09_21/20231006_HLLLTDRX3/raw_data/B6_25_2023_09_21_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/B6_25_2023_09_21_S39_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B6_25_2023_09_21/20231006_HLLLTDRX3/raw_data/B6_25_2023_09_21_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B7_33_2023_09_26/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/B7_33_2023_09_26_S62_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B7_33_2023_09_26/20231006_HLLLTDRX3/raw_data/B7_33_2023_09_26_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/B7_33_2023_09_26_S62_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B7_33_2023_09_26/20231006_HLLLTDRX3/raw_data/B7_33_2023_09_26_R2.fastq.gz"||X
echo -ne "\r[████▍···········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B8_35_2023_09_22/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/B8_35_2023_09_22_S35_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B8_35_2023_09_22/20231006_HLLLTDRX3/raw_data/B8_35_2023_09_22_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/B8_35_2023_09_22_S35_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B8_35_2023_09_22/20231006_HLLLTDRX3/raw_data/B8_35_2023_09_22_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C1_05_2023_09_23/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/C1_05_2023_09_23_S47_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C1_05_2023_09_23/20231006_HLLLTDRX3/raw_data/C1_05_2023_09_23_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/C1_05_2023_09_23_S47_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C1_05_2023_09_23/20231006_HLLLTDRX3/raw_data/C1_05_2023_09_23_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C2_12_2023_09_18/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/C2_12_2023_09_18_S13_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C2_12_2023_09_18/20231006_HLLLTDRX3/raw_data/C2_12_2023_09_18_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/C2_12_2023_09_18_S13_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C2_12_2023_09_18/20231006_HLLLTDRX3/raw_data/C2_12_2023_09_18_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C3_15_2023_09_24/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/C3_15_2023_09_24_S14_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C3_15_2023_09_24/20231006_HLLLTDRX3/raw_data/C3_15_2023_09_24_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/C3_15_2023_09_24_S14_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C3_15_2023_09_24/20231006_HLLLTDRX3/raw_data/C3_15_2023_09_24_R2.fastq.gz"||X
echo -ne "\r[████▌···········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C4_17_2023_09_20/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/C4_17_2023_09_20_S15_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C4_17_2023_09_20/20231006_HLLLTDRX3/raw_data/C4_17_2023_09_20_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/C4_17_2023_09_20_S15_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C4_17_2023_09_20/20231006_HLLLTDRX3/raw_data/C4_17_2023_09_20_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C5_18_2023_09_25/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/C5_18_2023_09_25_S3_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C5_18_2023_09_25/20231006_HLLLTDRX3/raw_data/C5_18_2023_09_25_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/C5_18_2023_09_25_S3_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C5_18_2023_09_25/20231006_HLLLTDRX3/raw_data/C5_18_2023_09_25_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C6_25_2023_09_23/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/C6_25_2023_09_23_S63_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C6_25_2023_09_23/20231006_HLLLTDRX3/raw_data/C6_25_2023_09_23_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/C6_25_2023_09_23_S63_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C6_25_2023_09_23/20231006_HLLLTDRX3/raw_data/C6_25_2023_09_23_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C7_34_2023_09_18/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/C7_34_2023_09_18_S27_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C7_34_2023_09_18/20231006_HLLLTDRX3/raw_data/C7_34_2023_09_18_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/C7_34_2023_09_18_S27_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C7_34_2023_09_18/20231006_HLLLTDRX3/raw_data/C7_34_2023_09_18_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C8_35_2023_09_23/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/C8_35_2023_09_23_S41_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C8_35_2023_09_23/20231006_HLLLTDRX3/raw_data/C8_35_2023_09_23_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/C8_35_2023_09_23_S41_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C8_35_2023_09_23/20231006_HLLLTDRX3/raw_data/C8_35_2023_09_23_R2.fastq.gz"||X
echo -ne "\r[████▋···········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D1_05_2023_09_24/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/D1_05_2023_09_24_S61_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D1_05_2023_09_24/20231006_HLLLTDRX3/raw_data/D1_05_2023_09_24_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/D1_05_2023_09_24_S61_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D1_05_2023_09_24/20231006_HLLLTDRX3/raw_data/D1_05_2023_09_24_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D2_12_2023_09_20/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/D2_12_2023_09_20_S28_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D2_12_2023_09_20/20231006_HLLLTDRX3/raw_data/D2_12_2023_09_20_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/D2_12_2023_09_20_S28_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D2_12_2023_09_20/20231006_HLLLTDRX3/raw_data/D2_12_2023_09_20_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D3_15_2023_09_25/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/D3_15_2023_09_25_S49_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D3_15_2023_09_25/20231006_HLLLTDRX3/raw_data/D3_15_2023_09_25_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/D3_15_2023_09_25_S49_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D3_15_2023_09_25/20231006_HLLLTDRX3/raw_data/D3_15_2023_09_25_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D4_17_2023_09_22/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/D4_17_2023_09_22_S58_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D4_17_2023_09_22/20231006_HLLLTDRX3/raw_data/D4_17_2023_09_22_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/D4_17_2023_09_22_S58_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D4_17_2023_09_22/20231006_HLLLTDRX3/raw_data/D4_17_2023_09_22_R2.fastq.gz"||X
echo -ne "\r[████▊···········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D5_19_2023_09_19/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/D5_19_2023_09_19_S60_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D5_19_2023_09_19/20231006_HLLLTDRX3/raw_data/D5_19_2023_09_19_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/D5_19_2023_09_19_S60_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D5_19_2023_09_19/20231006_HLLLTDRX3/raw_data/D5_19_2023_09_19_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D6_25_2023_09_24/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/D6_25_2023_09_24_S44_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D6_25_2023_09_24/20231006_HLLLTDRX3/raw_data/D6_25_2023_09_24_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/D6_25_2023_09_24_S44_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D6_25_2023_09_24/20231006_HLLLTDRX3/raw_data/D6_25_2023_09_24_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D7_34_2023_09_20/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/D7_34_2023_09_20_S33_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D7_34_2023_09_20/20231006_HLLLTDRX3/raw_data/D7_34_2023_09_20_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/D7_34_2023_09_20_S33_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D7_34_2023_09_20/20231006_HLLLTDRX3/raw_data/D7_34_2023_09_20_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D8_35_2023_09_24/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/D8_35_2023_09_24_S46_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D8_35_2023_09_24/20231006_HLLLTDRX3/raw_data/D8_35_2023_09_24_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/D8_35_2023_09_24_S46_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D8_35_2023_09_24/20231006_HLLLTDRX3/raw_data/D8_35_2023_09_24_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E1_05_2023_09_25/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/E1_05_2023_09_25_S23_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E1_05_2023_09_25/20231006_HLLLTDRX3/raw_data/E1_05_2023_09_25_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/E1_05_2023_09_25_S23_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E1_05_2023_09_25/20231006_HLLLTDRX3/raw_data/E1_05_2023_09_25_R2.fastq.gz"||X
echo -ne "\r[████▉···········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E2_12_2023_09_22/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/E2_12_2023_09_22_S10_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E2_12_2023_09_22/20231006_HLLLTDRX3/raw_data/E2_12_2023_09_22_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/E2_12_2023_09_22_S10_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E2_12_2023_09_22/20231006_HLLLTDRX3/raw_data/E2_12_2023_09_22_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E3_16_2023_09_20/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/E3_16_2023_09_20_S40_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E3_16_2023_09_20/20231006_HLLLTDRX3/raw_data/E3_16_2023_09_20_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/E3_16_2023_09_20_S40_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E3_16_2023_09_20/20231006_HLLLTDRX3/raw_data/E3_16_2023_09_20_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E4_17_2023_09_23/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/E4_17_2023_09_23_S12_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E4_17_2023_09_23/20231006_HLLLTDRX3/raw_data/E4_17_2023_09_23_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/E4_17_2023_09_23_S12_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E4_17_2023_09_23/20231006_HLLLTDRX3/raw_data/E4_17_2023_09_23_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E5_19_2023_09_21/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/E5_19_2023_09_21_S64_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E5_19_2023_09_21/20231006_HLLLTDRX3/raw_data/E5_19_2023_09_21_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/E5_19_2023_09_21_S64_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E5_19_2023_09_21/20231006_HLLLTDRX3/raw_data/E5_19_2023_09_21_R2.fastq.gz"||X
echo -ne "\r[█████···········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E6_25_2023_09_25/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/E6_25_2023_09_25_S37_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E6_25_2023_09_25/20231006_HLLLTDRX3/raw_data/E6_25_2023_09_25_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/E6_25_2023_09_25_S37_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E6_25_2023_09_25/20231006_HLLLTDRX3/raw_data/E6_25_2023_09_25_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E7_34_2023_09_22/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/E7_34_2023_09_22_S50_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E7_34_2023_09_22/20231006_HLLLTDRX3/raw_data/E7_34_2023_09_22_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/E7_34_2023_09_22_S50_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E7_34_2023_09_22/20231006_HLLLTDRX3/raw_data/E7_34_2023_09_22_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E8_36_2023_09_20/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/E8_36_2023_09_20_S45_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E8_36_2023_09_20/20231006_HLLLTDRX3/raw_data/E8_36_2023_09_20_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/E8_36_2023_09_20_S45_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E8_36_2023_09_20/20231006_HLLLTDRX3/raw_data/E8_36_2023_09_20_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F1_10_2023_09_18/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/F1_10_2023_09_18_S42_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F1_10_2023_09_18/20231006_HLLLTDRX3/raw_data/F1_10_2023_09_18_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/F1_10_2023_09_18_S42_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F1_10_2023_09_18/20231006_HLLLTDRX3/raw_data/F1_10_2023_09_18_R2.fastq.gz"||X
echo -ne "\r[█████▏··········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F2_12_2023_09_23/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/F2_12_2023_09_23_S25_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F2_12_2023_09_23/20231006_HLLLTDRX3/raw_data/F2_12_2023_09_23_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/F2_12_2023_09_23_S25_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F2_12_2023_09_23/20231006_HLLLTDRX3/raw_data/F2_12_2023_09_23_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F3_16_2023_09_22/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/F3_16_2023_09_22_S4_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F3_16_2023_09_22/20231006_HLLLTDRX3/raw_data/F3_16_2023_09_22_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/F3_16_2023_09_22_S4_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F3_16_2023_09_22/20231006_HLLLTDRX3/raw_data/F3_16_2023_09_22_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F4_17_2023_09_24/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/F4_17_2023_09_24_S52_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F4_17_2023_09_24/20231006_HLLLTDRX3/raw_data/F4_17_2023_09_24_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/F4_17_2023_09_24_S52_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F4_17_2023_09_24/20231006_HLLLTDRX3/raw_data/F4_17_2023_09_24_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F5_19_2023_09_23/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/F5_19_2023_09_23_S2_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F5_19_2023_09_23/20231006_HLLLTDRX3/raw_data/F5_19_2023_09_23_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/F5_19_2023_09_23_S2_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F5_19_2023_09_23/20231006_HLLLTDRX3/raw_data/F5_19_2023_09_23_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F6_33_2023_09_20/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/F6_33_2023_09_20_S9_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F6_33_2023_09_20/20231006_HLLLTDRX3/raw_data/F6_33_2023_09_20_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/F6_33_2023_09_20_S9_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F6_33_2023_09_20/20231006_HLLLTDRX3/raw_data/F6_33_2023_09_20_R2.fastq.gz"||X
echo -ne "\r[█████▎··········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F7_34_2023_09_23/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/F7_34_2023_09_23_S36_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F7_34_2023_09_23/20231006_HLLLTDRX3/raw_data/F7_34_2023_09_23_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/F7_34_2023_09_23_S36_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F7_34_2023_09_23/20231006_HLLLTDRX3/raw_data/F7_34_2023_09_23_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F8_36_2023_09_22/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/F8_36_2023_09_22_S34_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F8_36_2023_09_22/20231006_HLLLTDRX3/raw_data/F8_36_2023_09_22_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/F8_36_2023_09_22_S34_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F8_36_2023_09_22/20231006_HLLLTDRX3/raw_data/F8_36_2023_09_22_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G1_10_2023_09_20/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/G1_10_2023_09_20_S56_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G1_10_2023_09_20/20231006_HLLLTDRX3/raw_data/G1_10_2023_09_20_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/G1_10_2023_09_20_S56_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G1_10_2023_09_20/20231006_HLLLTDRX3/raw_data/G1_10_2023_09_20_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G2_12_2023_09_24/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/G2_12_2023_09_24_S22_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G2_12_2023_09_24/20231006_HLLLTDRX3/raw_data/G2_12_2023_09_24_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/G2_12_2023_09_24_S22_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G2_12_2023_09_24/20231006_HLLLTDRX3/raw_data/G2_12_2023_09_24_R2.fastq.gz"||X
echo -ne "\r[█████▍··········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G3_16_2023_09_24/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/G3_16_2023_09_24_S65_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G3_16_2023_09_24/20231006_HLLLTDRX3/raw_data/G3_16_2023_09_24_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/G3_16_2023_09_24_S65_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G3_16_2023_09_24/20231006_HLLLTDRX3/raw_data/G3_16_2023_09_24_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G4_18_2023_09_19/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/G4_18_2023_09_19_S48_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G4_18_2023_09_19/20231006_HLLLTDRX3/raw_data/G4_18_2023_09_19_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/G4_18_2023_09_19_S48_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G4_18_2023_09_19/20231006_HLLLTDRX3/raw_data/G4_18_2023_09_19_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G5_19_2023_09_24/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/G5_19_2023_09_24_S24_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G5_19_2023_09_24/20231006_HLLLTDRX3/raw_data/G5_19_2023_09_24_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/G5_19_2023_09_24_S24_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G5_19_2023_09_24/20231006_HLLLTDRX3/raw_data/G5_19_2023_09_24_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G6_33_2023_09_22/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/G6_33_2023_09_22_S16_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G6_33_2023_09_22/20231006_HLLLTDRX3/raw_data/G6_33_2023_09_22_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/G6_33_2023_09_22_S16_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G6_33_2023_09_22/20231006_HLLLTDRX3/raw_data/G6_33_2023_09_22_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G7_34_2023_09_24/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/G7_34_2023_09_24_S6_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G7_34_2023_09_24/20231006_HLLLTDRX3/raw_data/G7_34_2023_09_24_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/G7_34_2023_09_24_S6_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G7_34_2023_09_24/20231006_HLLLTDRX3/raw_data/G7_34_2023_09_24_R2.fastq.gz"||X
echo -ne "\r[█████▌··········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G8_36_2023_09_24/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/G8_36_2023_09_24_S31_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G8_36_2023_09_24/20231006_HLLLTDRX3/raw_data/G8_36_2023_09_24_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/G8_36_2023_09_24_S31_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G8_36_2023_09_24/20231006_HLLLTDRX3/raw_data/G8_36_2023_09_24_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H1_10_2023_09_22/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/H1_10_2023_09_22_S1_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H1_10_2023_09_22/20231006_HLLLTDRX3/raw_data/H1_10_2023_09_22_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/H1_10_2023_09_22_S1_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H1_10_2023_09_22/20231006_HLLLTDRX3/raw_data/H1_10_2023_09_22_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H2_15_2023_09_21/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/H2_15_2023_09_21_S57_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H2_15_2023_09_21/20231006_HLLLTDRX3/raw_data/H2_15_2023_09_21_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/H2_15_2023_09_21_S57_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H2_15_2023_09_21/20231006_HLLLTDRX3/raw_data/H2_15_2023_09_21_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H3_16_2023_09_25/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/H3_16_2023_09_25_S51_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H3_16_2023_09_25/20231006_HLLLTDRX3/raw_data/H3_16_2023_09_25_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/H3_16_2023_09_25_S51_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H3_16_2023_09_25/20231006_HLLLTDRX3/raw_data/H3_16_2023_09_25_R2.fastq.gz"||X
echo -ne "\r[█████▋··········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H4_18_2023_09_21/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/H4_18_2023_09_21_S18_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H4_18_2023_09_21/20231006_HLLLTDRX3/raw_data/H4_18_2023_09_21_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/H4_18_2023_09_21_S18_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H4_18_2023_09_21/20231006_HLLLTDRX3/raw_data/H4_18_2023_09_21_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H5_19_2023_09_25/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/H5_19_2023_09_25_S26_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H5_19_2023_09_25/20231006_HLLLTDRX3/raw_data/H5_19_2023_09_25_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/H5_19_2023_09_25_S26_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H5_19_2023_09_25/20231006_HLLLTDRX3/raw_data/H5_19_2023_09_25_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H6_33_2023_09_24/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/H6_33_2023_09_24_S55_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H6_33_2023_09_24/20231006_HLLLTDRX3/raw_data/H6_33_2023_09_24_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/H6_33_2023_09_24_S55_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H6_33_2023_09_24/20231006_HLLLTDRX3/raw_data/H6_33_2023_09_24_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H7_35_2023_09_18/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/H7_35_2023_09_18_S30_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H7_35_2023_09_18/20231006_HLLLTDRX3/raw_data/H7_35_2023_09_18_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/H7_35_2023_09_18_S30_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H7_35_2023_09_18/20231006_HLLLTDRX3/raw_data/H7_35_2023_09_18_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H8_36_2023_09_25/"{,"20231006_HLLLTDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/H8_36_2023_09_25_S8_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H8_36_2023_09_25/20231006_HLLLTDRX3/raw_data/H8_36_2023_09_25_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33039_NovaSeq_231006_NOV1897/H8_36_2023_09_25_S8_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H8_36_2023_09_25/20231006_HLLLTDRX3/raw_data/H8_36_2023_09_25_R2.fastq.gz"||X
if [[ ! -d "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917" ]]; then
    fail "Not a directory:" "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917"
fi
echo -ne "\r[█████▊··········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A1_05_2023_10_11/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/A1_05_2023_10_11_S63_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A1_05_2023_10_11/20231103_HLTHYDRX3/raw_data/A1_05_2023_10_11_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/A1_05_2023_10_11_S63_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A1_05_2023_10_11/20231103_HLTHYDRX3/raw_data/A1_05_2023_10_11_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A2_10_2023_10_14/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/A2_10_2023_10_14_S66_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A2_10_2023_10_14/20231103_HLTHYDRX3/raw_data/A2_10_2023_10_14_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/A2_10_2023_10_14_S66_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A2_10_2023_10_14/20231103_HLTHYDRX3/raw_data/A2_10_2023_10_14_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A3_15_2023_10_13/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/A3_15_2023_10_13_S40_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A3_15_2023_10_13/20231103_HLTHYDRX3/raw_data/A3_15_2023_10_13_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/A3_15_2023_10_13_S40_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A3_15_2023_10_13/20231103_HLTHYDRX3/raw_data/A3_15_2023_10_13_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A4_16_2023_10_17/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/A4_16_2023_10_17_S41_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A4_16_2023_10_17/20231103_HLTHYDRX3/raw_data/A4_16_2023_10_17_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/A4_16_2023_10_17_S41_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A4_16_2023_10_17/20231103_HLTHYDRX3/raw_data/A4_16_2023_10_17_R2.fastq.gz"||X
echo -ne "\r[█████▉··········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A5_18_2023_10_14/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/A5_18_2023_10_14_S28_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A5_18_2023_10_14/20231103_HLTHYDRX3/raw_data/A5_18_2023_10_14_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/A5_18_2023_10_14_S28_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A5_18_2023_10_14/20231103_HLTHYDRX3/raw_data/A5_18_2023_10_14_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A6_25_2023_10_11/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/A6_25_2023_10_11_S52_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A6_25_2023_10_11/20231103_HLTHYDRX3/raw_data/A6_25_2023_10_11_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/A6_25_2023_10_11_S52_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A6_25_2023_10_11/20231103_HLTHYDRX3/raw_data/A6_25_2023_10_11_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A7_32_2023_10_16/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/A7_32_2023_10_16_S11_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A7_32_2023_10_16/20231103_HLTHYDRX3/raw_data/A7_32_2023_10_16_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/A7_32_2023_10_16_S11_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A7_32_2023_10_16/20231103_HLTHYDRX3/raw_data/A7_32_2023_10_16_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A8_34_2023_10_12/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/A8_34_2023_10_12_S42_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A8_34_2023_10_12/20231103_HLTHYDRX3/raw_data/A8_34_2023_10_12_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/A8_34_2023_10_12_S42_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A8_34_2023_10_12/20231103_HLTHYDRX3/raw_data/A8_34_2023_10_12_R2.fastq.gz"||X
echo -ne "\r[██████··········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A9_35_2023_10_15/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/A9_35_2023_10_15_S43_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A9_35_2023_10_15/20231103_HLTHYDRX3/raw_data/A9_35_2023_10_15_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/A9_35_2023_10_15_S43_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A9_35_2023_10_15/20231103_HLTHYDRX3/raw_data/A9_35_2023_10_15_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B1_05_2023_10_13/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/B1_05_2023_10_13_S39_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B1_05_2023_10_13/20231103_HLTHYDRX3/raw_data/B1_05_2023_10_13_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/B1_05_2023_10_13_S39_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B1_05_2023_10_13/20231103_HLTHYDRX3/raw_data/B1_05_2023_10_13_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B2_10_2023_10_15/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/B2_10_2023_10_15_S24_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B2_10_2023_10_15/20231103_HLTHYDRX3/raw_data/B2_10_2023_10_15_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/B2_10_2023_10_15_S24_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B2_10_2023_10_15/20231103_HLTHYDRX3/raw_data/B2_10_2023_10_15_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B3_15_2023_10_14/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/B3_15_2023_10_14_S29_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B3_15_2023_10_14/20231103_HLTHYDRX3/raw_data/B3_15_2023_10_14_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/B3_15_2023_10_14_S29_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B3_15_2023_10_14/20231103_HLTHYDRX3/raw_data/B3_15_2023_10_14_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B4_17_2023_10_10/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/B4_17_2023_10_10_S51_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B4_17_2023_10_10/20231103_HLTHYDRX3/raw_data/B4_17_2023_10_10_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/B4_17_2023_10_10_S51_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B4_17_2023_10_10/20231103_HLTHYDRX3/raw_data/B4_17_2023_10_10_R2.fastq.gz"||X
echo -ne "\r[██████▏·········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B5_18_2023_10_15/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/B5_18_2023_10_15_S1_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B5_18_2023_10_15/20231103_HLTHYDRX3/raw_data/B5_18_2023_10_15_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/B5_18_2023_10_15_S1_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B5_18_2023_10_15/20231103_HLTHYDRX3/raw_data/B5_18_2023_10_15_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B6_25_2023_10_13/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/B6_25_2023_10_13_S59_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B6_25_2023_10_13/20231103_HLTHYDRX3/raw_data/B6_25_2023_10_13_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/B6_25_2023_10_13_S59_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B6_25_2023_10_13/20231103_HLTHYDRX3/raw_data/B6_25_2023_10_13_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B7_32_2023_10_17/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/B7_32_2023_10_17_S23_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B7_32_2023_10_17/20231103_HLTHYDRX3/raw_data/B7_32_2023_10_17_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/B7_32_2023_10_17_S23_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B7_32_2023_10_17/20231103_HLTHYDRX3/raw_data/B7_32_2023_10_17_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B8_34_2023_10_13/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/B8_34_2023_10_13_S67_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B8_34_2023_10_13/20231103_HLTHYDRX3/raw_data/B8_34_2023_10_13_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/B8_34_2023_10_13_S67_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B8_34_2023_10_13/20231103_HLTHYDRX3/raw_data/B8_34_2023_10_13_R2.fastq.gz"||X
echo -ne "\r[██████▎·········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B9_36_2023_10_12/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/B9_36_2023_10_12_S45_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B9_36_2023_10_12/20231103_HLTHYDRX3/raw_data/B9_36_2023_10_12_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/B9_36_2023_10_12_S45_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B9_36_2023_10_12/20231103_HLTHYDRX3/raw_data/B9_36_2023_10_12_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C1_05_2023_10_14/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/C1_05_2023_10_14_S57_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C1_05_2023_10_14/20231103_HLTHYDRX3/raw_data/C1_05_2023_10_14_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/C1_05_2023_10_14_S57_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C1_05_2023_10_14/20231103_HLTHYDRX3/raw_data/C1_05_2023_10_14_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C2_12_2023_10_10/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/C2_12_2023_10_10_S4_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C2_12_2023_10_10/20231103_HLTHYDRX3/raw_data/C2_12_2023_10_10_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/C2_12_2023_10_10_S4_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C2_12_2023_10_10/20231103_HLTHYDRX3/raw_data/C2_12_2023_10_10_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C3_15_2023_10_15/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/C3_15_2023_10_15_S25_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C3_15_2023_10_15/20231103_HLTHYDRX3/raw_data/C3_15_2023_10_15_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/C3_15_2023_10_15_S25_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C3_15_2023_10_15/20231103_HLTHYDRX3/raw_data/C3_15_2023_10_15_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C4_17_2023_10_12/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/C4_17_2023_10_12_S53_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C4_17_2023_10_12/20231103_HLTHYDRX3/raw_data/C4_17_2023_10_12_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/C4_17_2023_10_12_S53_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C4_17_2023_10_12/20231103_HLTHYDRX3/raw_data/C4_17_2023_10_12_R2.fastq.gz"||X
echo -ne "\r[██████▍·········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C5_18_2023_10_16/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/C5_18_2023_10_16_S60_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C5_18_2023_10_16/20231103_HLTHYDRX3/raw_data/C5_18_2023_10_16_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/C5_18_2023_10_16_S60_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C5_18_2023_10_16/20231103_HLTHYDRX3/raw_data/C5_18_2023_10_16_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C6_25_2023_10_14/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/C6_25_2023_10_14_S6_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C6_25_2023_10_14/20231103_HLTHYDRX3/raw_data/C6_25_2023_10_14_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/C6_25_2023_10_14_S6_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C6_25_2023_10_14/20231103_HLTHYDRX3/raw_data/C6_25_2023_10_14_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C7_33_2023_10_12/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/C7_33_2023_10_12_S31_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C7_33_2023_10_12/20231103_HLTHYDRX3/raw_data/C7_33_2023_10_12_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/C7_33_2023_10_12_S31_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C7_33_2023_10_12/20231103_HLTHYDRX3/raw_data/C7_33_2023_10_12_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C8_34_2023_10_14/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/C8_34_2023_10_14_S36_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C8_34_2023_10_14/20231103_HLTHYDRX3/raw_data/C8_34_2023_10_14_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/C8_34_2023_10_14_S36_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C8_34_2023_10_14/20231103_HLTHYDRX3/raw_data/C8_34_2023_10_14_R2.fastq.gz"||X
echo -ne "\r[██████▌·········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C9_36_2023_10_14/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/C9_36_2023_10_14_S9_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C9_36_2023_10_14/20231103_HLTHYDRX3/raw_data/C9_36_2023_10_14_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/C9_36_2023_10_14_S9_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C9_36_2023_10_14/20231103_HLTHYDRX3/raw_data/C9_36_2023_10_14_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D1_05_2023_10_15/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/D1_05_2023_10_15_S46_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D1_05_2023_10_15/20231103_HLTHYDRX3/raw_data/D1_05_2023_10_15_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/D1_05_2023_10_15_S46_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D1_05_2023_10_15/20231103_HLTHYDRX3/raw_data/D1_05_2023_10_15_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D2_12_2023_10_12/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/D2_12_2023_10_12_S10_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D2_12_2023_10_12/20231103_HLTHYDRX3/raw_data/D2_12_2023_10_12_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/D2_12_2023_10_12_S10_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D2_12_2023_10_12/20231103_HLTHYDRX3/raw_data/D2_12_2023_10_12_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D3_15_2023_10_16/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/D3_15_2023_10_16_S22_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D3_15_2023_10_16/20231103_HLTHYDRX3/raw_data/D3_15_2023_10_16_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/D3_15_2023_10_16_S22_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D3_15_2023_10_16/20231103_HLTHYDRX3/raw_data/D3_15_2023_10_16_R2.fastq.gz"||X
echo -ne "\r[██████▋·········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D4_17_2023_10_13/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/D4_17_2023_10_13_S47_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D4_17_2023_10_13/20231103_HLTHYDRX3/raw_data/D4_17_2023_10_13_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/D4_17_2023_10_13_S47_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D4_17_2023_10_13/20231103_HLTHYDRX3/raw_data/D4_17_2023_10_13_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D5_19_2023_10_11/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/D5_19_2023_10_11_S54_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D5_19_2023_10_11/20231103_HLTHYDRX3/raw_data/D5_19_2023_10_11_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/D5_19_2023_10_11_S54_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D5_19_2023_10_11/20231103_HLTHYDRX3/raw_data/D5_19_2023_10_11_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D6_25_2023_10_15/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/D6_25_2023_10_15_S69_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D6_25_2023_10_15/20231103_HLTHYDRX3/raw_data/D6_25_2023_10_15_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/D6_25_2023_10_15_S69_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D6_25_2023_10_15/20231103_HLTHYDRX3/raw_data/D6_25_2023_10_15_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D7_33_2023_10_14/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/D7_33_2023_10_14_S58_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D7_33_2023_10_14/20231103_HLTHYDRX3/raw_data/D7_33_2023_10_14_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/D7_33_2023_10_14_S58_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D7_33_2023_10_14/20231103_HLTHYDRX3/raw_data/D7_33_2023_10_14_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D8_34_2023_10_15/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/D8_34_2023_10_15_S68_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D8_34_2023_10_15/20231103_HLTHYDRX3/raw_data/D8_34_2023_10_15_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/D8_34_2023_10_15_S68_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D8_34_2023_10_15/20231103_HLTHYDRX3/raw_data/D8_34_2023_10_15_R2.fastq.gz"||X
echo -ne "\r[██████▊·········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D9_36_2023_10_16/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/D9_36_2023_10_16_S19_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D9_36_2023_10_16/20231103_HLTHYDRX3/raw_data/D9_36_2023_10_16_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/D9_36_2023_10_16_S19_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D9_36_2023_10_16/20231103_HLTHYDRX3/raw_data/D9_36_2023_10_16_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E1_05_2023_10_16/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/E1_05_2023_10_16_S37_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E1_05_2023_10_16/20231103_HLTHYDRX3/raw_data/E1_05_2023_10_16_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/E1_05_2023_10_16_S37_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E1_05_2023_10_16/20231103_HLTHYDRX3/raw_data/E1_05_2023_10_16_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E2_12_2023_10_13/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/E2_12_2023_10_13_S18_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E2_12_2023_10_13/20231103_HLTHYDRX3/raw_data/E2_12_2023_10_13_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/E2_12_2023_10_13_S18_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E2_12_2023_10_13/20231103_HLTHYDRX3/raw_data/E2_12_2023_10_13_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E3_16_2023_10_12/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/E3_16_2023_10_12_S16_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E3_16_2023_10_12/20231103_HLTHYDRX3/raw_data/E3_16_2023_10_12_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/E3_16_2023_10_12_S16_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E3_16_2023_10_12/20231103_HLTHYDRX3/raw_data/E3_16_2023_10_12_R2.fastq.gz"||X
echo -ne "\r[██████▉·········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E4_17_2023_10_14/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/E4_17_2023_10_14_S64_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E4_17_2023_10_14/20231103_HLTHYDRX3/raw_data/E4_17_2023_10_14_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/E4_17_2023_10_14_S64_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E4_17_2023_10_14/20231103_HLTHYDRX3/raw_data/E4_17_2023_10_14_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E5_19_2023_10_13/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/E5_19_2023_10_13_S34_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E5_19_2023_10_13/20231103_HLTHYDRX3/raw_data/E5_19_2023_10_13_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/E5_19_2023_10_13_S34_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E5_19_2023_10_13/20231103_HLTHYDRX3/raw_data/E5_19_2023_10_13_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E6_25_2023_10_16/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/E6_25_2023_10_16_S61_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E6_25_2023_10_16/20231103_HLTHYDRX3/raw_data/E6_25_2023_10_16_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/E6_25_2023_10_16_S61_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E6_25_2023_10_16/20231103_HLTHYDRX3/raw_data/E6_25_2023_10_16_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E7_33_2023_10_15/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/E7_33_2023_10_15_S17_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E7_33_2023_10_15/20231103_HLTHYDRX3/raw_data/E7_33_2023_10_15_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/E7_33_2023_10_15_S17_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E7_33_2023_10_15/20231103_HLTHYDRX3/raw_data/E7_33_2023_10_15_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E8_35_2023_10_10/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/E8_35_2023_10_10_S3_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E8_35_2023_10_10/20231103_HLTHYDRX3/raw_data/E8_35_2023_10_10_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/E8_35_2023_10_10_S3_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E8_35_2023_10_10/20231103_HLTHYDRX3/raw_data/E8_35_2023_10_10_R2.fastq.gz"||X
echo -ne "\r[███████·········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E9_36_2023_10_15/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/E9_36_2023_10_15_S38_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E9_36_2023_10_15/20231103_HLTHYDRX3/raw_data/E9_36_2023_10_15_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/E9_36_2023_10_15_S38_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E9_36_2023_10_15/20231103_HLTHYDRX3/raw_data/E9_36_2023_10_15_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F1_10_2023_10_10/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/F1_10_2023_10_10_S14_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F1_10_2023_10_10/20231103_HLTHYDRX3/raw_data/F1_10_2023_10_10_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/F1_10_2023_10_10_S14_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F1_10_2023_10_10/20231103_HLTHYDRX3/raw_data/F1_10_2023_10_10_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F2_12_2023_10_14/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/F2_12_2023_10_14_S2_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F2_12_2023_10_14/20231103_HLTHYDRX3/raw_data/F2_12_2023_10_14_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/F2_12_2023_10_14_S2_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F2_12_2023_10_14/20231103_HLTHYDRX3/raw_data/F2_12_2023_10_14_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F3_16_2023_10_14/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/F3_16_2023_10_14_S48_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F3_16_2023_10_14/20231103_HLTHYDRX3/raw_data/F3_16_2023_10_14_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/F3_16_2023_10_14_S48_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F3_16_2023_10_14/20231103_HLTHYDRX3/raw_data/F3_16_2023_10_14_R2.fastq.gz"||X
echo -ne "\r[███████▏········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F4_17_2023_10_15/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/F4_17_2023_10_15_S27_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F4_17_2023_10_15/20231103_HLTHYDRX3/raw_data/F4_17_2023_10_15_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/F4_17_2023_10_15_S27_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F4_17_2023_10_15/20231103_HLTHYDRX3/raw_data/F4_17_2023_10_15_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F5_19_2023_10_14/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/F5_19_2023_10_14_S5_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F5_19_2023_10_14/20231103_HLTHYDRX3/raw_data/F5_19_2023_10_14_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/F5_19_2023_10_14_S5_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F5_19_2023_10_14/20231103_HLTHYDRX3/raw_data/F5_19_2023_10_14_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F6_32_2023_10_12/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/F6_32_2023_10_12_S50_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F6_32_2023_10_12/20231103_HLTHYDRX3/raw_data/F6_32_2023_10_12_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/F6_32_2023_10_12_S50_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F6_32_2023_10_12/20231103_HLTHYDRX3/raw_data/F6_32_2023_10_12_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F7_33_2023_10_16/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/F7_33_2023_10_16_S44_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F7_33_2023_10_16/20231103_HLTHYDRX3/raw_data/F7_33_2023_10_16_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/F7_33_2023_10_16_S44_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F7_33_2023_10_16/20231103_HLTHYDRX3/raw_data/F7_33_2023_10_16_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F8_35_2023_10_12/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/F8_35_2023_10_12_S8_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F8_35_2023_10_12/20231103_HLTHYDRX3/raw_data/F8_35_2023_10_12_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/F8_35_2023_10_12_S8_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F8_35_2023_10_12/20231103_HLTHYDRX3/raw_data/F8_35_2023_10_12_R2.fastq.gz"||X
echo -ne "\r[███████▎········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F9_36_2023_10_17/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/F9_36_2023_10_17_S13_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F9_36_2023_10_17/20231103_HLTHYDRX3/raw_data/F9_36_2023_10_17_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/F9_36_2023_10_17_S13_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F9_36_2023_10_17/20231103_HLTHYDRX3/raw_data/F9_36_2023_10_17_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G1_10_2023_10_12/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/G1_10_2023_10_12_S33_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G1_10_2023_10_12/20231103_HLTHYDRX3/raw_data/G1_10_2023_10_12_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/G1_10_2023_10_12_S33_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G1_10_2023_10_12/20231103_HLTHYDRX3/raw_data/G1_10_2023_10_12_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G2_12_2023_10_15/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/G2_12_2023_10_15_S32_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G2_12_2023_10_15/20231103_HLTHYDRX3/raw_data/G2_12_2023_10_15_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/G2_12_2023_10_15_S32_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G2_12_2023_10_15/20231103_HLTHYDRX3/raw_data/G2_12_2023_10_15_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G3_16_2023_10_15/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/G3_16_2023_10_15_S20_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G3_16_2023_10_15/20231103_HLTHYDRX3/raw_data/G3_16_2023_10_15_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/G3_16_2023_10_15_S20_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G3_16_2023_10_15/20231103_HLTHYDRX3/raw_data/G3_16_2023_10_15_R2.fastq.gz"||X
echo -ne "\r[███████▍········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G4_18_2023_10_11/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/G4_18_2023_10_11_S26_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G4_18_2023_10_11/20231103_HLTHYDRX3/raw_data/G4_18_2023_10_11_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/G4_18_2023_10_11_S26_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G4_18_2023_10_11/20231103_HLTHYDRX3/raw_data/G4_18_2023_10_11_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G5_19_2023_10_15/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/G5_19_2023_10_15_S65_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G5_19_2023_10_15/20231103_HLTHYDRX3/raw_data/G5_19_2023_10_15_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/G5_19_2023_10_15_S65_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G5_19_2023_10_15/20231103_HLTHYDRX3/raw_data/G5_19_2023_10_15_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G6_32_2023_10_14/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/G6_32_2023_10_14_S35_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G6_32_2023_10_14/20231103_HLTHYDRX3/raw_data/G6_32_2023_10_14_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/G6_32_2023_10_14_S35_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G6_32_2023_10_14/20231103_HLTHYDRX3/raw_data/G6_32_2023_10_14_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G7_33_2023_10_17/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/G7_33_2023_10_17_S12_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G7_33_2023_10_17/20231103_HLTHYDRX3/raw_data/G7_33_2023_10_17_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/G7_33_2023_10_17_S12_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G7_33_2023_10_17/20231103_HLTHYDRX3/raw_data/G7_33_2023_10_17_R2.fastq.gz"||X
echo -ne "\r[███████▌········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G8_35_2023_10_13/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/G8_35_2023_10_13_S56_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G8_35_2023_10_13/20231103_HLTHYDRX3/raw_data/G8_35_2023_10_13_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/G8_35_2023_10_13_S56_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G8_35_2023_10_13/20231103_HLTHYDRX3/raw_data/G8_35_2023_10_13_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H1_10_2023_10_13/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/H1_10_2023_10_13_S49_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H1_10_2023_10_13/20231103_HLTHYDRX3/raw_data/H1_10_2023_10_13_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/H1_10_2023_10_13_S49_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H1_10_2023_10_13/20231103_HLTHYDRX3/raw_data/H1_10_2023_10_13_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H2_15_2023_10_11/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/H2_15_2023_10_11_S15_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H2_15_2023_10_11/20231103_HLTHYDRX3/raw_data/H2_15_2023_10_11_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/H2_15_2023_10_11_S15_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H2_15_2023_10_11/20231103_HLTHYDRX3/raw_data/H2_15_2023_10_11_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H3_16_2023_10_16/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/H3_16_2023_10_16_S62_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H3_16_2023_10_16/20231103_HLTHYDRX3/raw_data/H3_16_2023_10_16_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/H3_16_2023_10_16_S62_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H3_16_2023_10_16/20231103_HLTHYDRX3/raw_data/H3_16_2023_10_16_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H4_18_2023_10_13/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/H4_18_2023_10_13_S30_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H4_18_2023_10_13/20231103_HLTHYDRX3/raw_data/H4_18_2023_10_13_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/H4_18_2023_10_13_S30_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H4_18_2023_10_13/20231103_HLTHYDRX3/raw_data/H4_18_2023_10_13_R2.fastq.gz"||X
echo -ne "\r[███████▋········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H5_19_2023_10_16/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/H5_19_2023_10_16_S70_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H5_19_2023_10_16/20231103_HLTHYDRX3/raw_data/H5_19_2023_10_16_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/H5_19_2023_10_16_S70_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H5_19_2023_10_16/20231103_HLTHYDRX3/raw_data/H5_19_2023_10_16_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H6_32_2023_10_15/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/H6_32_2023_10_15_S21_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H6_32_2023_10_15/20231103_HLTHYDRX3/raw_data/H6_32_2023_10_15_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/H6_32_2023_10_15_S21_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H6_32_2023_10_15/20231103_HLTHYDRX3/raw_data/H6_32_2023_10_15_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H7_34_2023_10_10/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/H7_34_2023_10_10_S7_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H7_34_2023_10_10/20231103_HLTHYDRX3/raw_data/H7_34_2023_10_10_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/H7_34_2023_10_10_S7_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H7_34_2023_10_10/20231103_HLTHYDRX3/raw_data/H7_34_2023_10_10_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H8_35_2023_10_14/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/H8_35_2023_10_14_S55_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H8_35_2023_10_14/20231103_HLTHYDRX3/raw_data/H8_35_2023_10_14_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33236_NovaSeq_231103_NOV1917/H8_35_2023_10_14_S55_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H8_35_2023_10_14/20231103_HLTHYDRX3/raw_data/H8_35_2023_10_14_R2.fastq.gz"||X
if [[ ! -d "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919" ]]; then
    fail "Not a directory:" "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919"
fi
echo -ne "\r[███████▊········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A1_10_2023_10_24/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/A1_10_2023_10_24_S37_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A1_10_2023_10_24/20231110_HKHFMDRX3/raw_data/A1_10_2023_10_24_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/A1_10_2023_10_24_S37_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A1_10_2023_10_24/20231110_HKHFMDRX3/raw_data/A1_10_2023_10_24_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A2_12_2023_10_28/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/A2_12_2023_10_28_S69_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A2_12_2023_10_28/20231110_HKHFMDRX3/raw_data/A2_12_2023_10_28_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/A2_12_2023_10_28_S69_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A2_12_2023_10_28/20231110_HKHFMDRX3/raw_data/A2_12_2023_10_28_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A3_35_2023_10_26/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/A3_35_2023_10_26_S26_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A3_35_2023_10_26/20231110_HKHFMDRX3/raw_data/A3_35_2023_10_26_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/A3_35_2023_10_26_S26_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A3_35_2023_10_26/20231110_HKHFMDRX3/raw_data/A3_35_2023_10_26_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A4_05_2023_10_30/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/A4_05_2023_10_30_S17_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A4_05_2023_10_30/20231110_HKHFMDRX3/raw_data/A4_05_2023_10_30_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/A4_05_2023_10_30_S17_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A4_05_2023_10_30/20231110_HKHFMDRX3/raw_data/A4_05_2023_10_30_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A5_18_2023_10_28/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/A5_18_2023_10_28_S22_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A5_18_2023_10_28/20231110_HKHFMDRX3/raw_data/A5_18_2023_10_28_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/A5_18_2023_10_28_S22_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A5_18_2023_10_28/20231110_HKHFMDRX3/raw_data/A5_18_2023_10_28_R2.fastq.gz"||X
echo -ne "\r[███████▉········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A6_34_2023_10_24/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/A6_34_2023_10_24_S58_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A6_34_2023_10_24/20231110_HKHFMDRX3/raw_data/A6_34_2023_10_24_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/A6_34_2023_10_24_S58_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A6_34_2023_10_24/20231110_HKHFMDRX3/raw_data/A6_34_2023_10_24_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A7_25_2023_10_29/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/A7_25_2023_10_29_S23_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A7_25_2023_10_29/20231110_HKHFMDRX3/raw_data/A7_25_2023_10_29_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/A7_25_2023_10_29_S23_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A7_25_2023_10_29/20231110_HKHFMDRX3/raw_data/A7_25_2023_10_29_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A8_32_2023_10_28/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/A8_32_2023_10_28_S19_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A8_32_2023_10_28/20231110_HKHFMDRX3/raw_data/A8_32_2023_10_28_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/A8_32_2023_10_28_S19_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A8_32_2023_10_28/20231110_HKHFMDRX3/raw_data/A8_32_2023_10_28_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A9_33_2023_10_31/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/A9_33_2023_10_31_S25_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A9_33_2023_10_31/20231110_HKHFMDRX3/raw_data/A9_33_2023_10_31_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/A9_33_2023_10_31_S25_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A9_33_2023_10_31/20231110_HKHFMDRX3/raw_data/A9_33_2023_10_31_R2.fastq.gz"||X
echo -ne "\r[████████········]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B1_10_2023_10_26/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/B1_10_2023_10_26_S46_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B1_10_2023_10_26/20231110_HKHFMDRX3/raw_data/B1_10_2023_10_26_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/B1_10_2023_10_26_S46_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B1_10_2023_10_26/20231110_HKHFMDRX3/raw_data/B1_10_2023_10_26_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B2_12_2023_10_29/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/B2_12_2023_10_29_S61_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B2_12_2023_10_29/20231110_HKHFMDRX3/raw_data/B2_12_2023_10_29_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/B2_12_2023_10_29_S61_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B2_12_2023_10_29/20231110_HKHFMDRX3/raw_data/B2_12_2023_10_29_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B3_35_2023_10_27/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/B3_35_2023_10_27_S63_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B3_35_2023_10_27/20231110_HKHFMDRX3/raw_data/B3_35_2023_10_27_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/B3_35_2023_10_27_S63_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B3_35_2023_10_27/20231110_HKHFMDRX3/raw_data/B3_35_2023_10_27_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B4_15_2023_10_25/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/B4_15_2023_10_25_S32_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B4_15_2023_10_25/20231110_HKHFMDRX3/raw_data/B4_15_2023_10_25_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/B4_15_2023_10_25_S32_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B4_15_2023_10_25/20231110_HKHFMDRX3/raw_data/B4_15_2023_10_25_R2.fastq.gz"||X
echo -ne "\r[████████▏·······]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B5_18_2023_10_29/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/B5_18_2023_10_29_S45_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B5_18_2023_10_29/20231110_HKHFMDRX3/raw_data/B5_18_2023_10_29_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/B5_18_2023_10_29_S45_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B5_18_2023_10_29/20231110_HKHFMDRX3/raw_data/B5_18_2023_10_29_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B6_34_2023_10_26/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/B6_34_2023_10_26_S9_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B6_34_2023_10_26/20231110_HKHFMDRX3/raw_data/B6_34_2023_10_26_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/B6_34_2023_10_26_S9_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B6_34_2023_10_26/20231110_HKHFMDRX3/raw_data/B6_34_2023_10_26_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B7_25_2023_10_30/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/B7_25_2023_10_30_S42_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B7_25_2023_10_30/20231110_HKHFMDRX3/raw_data/B7_25_2023_10_30_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/B7_25_2023_10_30_S42_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B7_25_2023_10_30/20231110_HKHFMDRX3/raw_data/B7_25_2023_10_30_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B8_32_2023_10_29/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/B8_32_2023_10_29_S33_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B8_32_2023_10_29/20231110_HKHFMDRX3/raw_data/B8_32_2023_10_29_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/B8_32_2023_10_29_S33_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B8_32_2023_10_29/20231110_HKHFMDRX3/raw_data/B8_32_2023_10_29_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B9_36_2023_10_26/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/B9_36_2023_10_26_S67_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B9_36_2023_10_26/20231110_HKHFMDRX3/raw_data/B9_36_2023_10_26_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/B9_36_2023_10_26_S67_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B9_36_2023_10_26/20231110_HKHFMDRX3/raw_data/B9_36_2023_10_26_R2.fastq.gz"||X
echo -ne "\r[████████▎·······]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C1_10_2023_10_27/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/C1_10_2023_10_27_S36_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C1_10_2023_10_27/20231110_HKHFMDRX3/raw_data/C1_10_2023_10_27_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/C1_10_2023_10_27_S36_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C1_10_2023_10_27/20231110_HKHFMDRX3/raw_data/C1_10_2023_10_27_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C2_17_2023_10_24/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/C2_17_2023_10_24_S47_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C2_17_2023_10_24/20231110_HKHFMDRX3/raw_data/C2_17_2023_10_24_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/C2_17_2023_10_24_S47_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C2_17_2023_10_24/20231110_HKHFMDRX3/raw_data/C2_17_2023_10_24_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C3_35_2023_10_28/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/C3_35_2023_10_28_S40_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C3_35_2023_10_28/20231110_HKHFMDRX3/raw_data/C3_35_2023_10_28_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/C3_35_2023_10_28_S40_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C3_35_2023_10_28/20231110_HKHFMDRX3/raw_data/C3_35_2023_10_28_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C4_15_2023_10_27/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/C4_15_2023_10_27_S66_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C4_15_2023_10_27/20231110_HKHFMDRX3/raw_data/C4_15_2023_10_27_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/C4_15_2023_10_27_S66_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C4_15_2023_10_27/20231110_HKHFMDRX3/raw_data/C4_15_2023_10_27_R2.fastq.gz"||X
echo -ne "\r[████████▍·······]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C5_18_2023_10_30/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/C5_18_2023_10_30_S56_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C5_18_2023_10_30/20231110_HKHFMDRX3/raw_data/C5_18_2023_10_30_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/C5_18_2023_10_30_S56_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C5_18_2023_10_30/20231110_HKHFMDRX3/raw_data/C5_18_2023_10_30_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C6_34_2023_10_27/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/C6_34_2023_10_27_S52_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C6_34_2023_10_27/20231110_HKHFMDRX3/raw_data/C6_34_2023_10_27_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/C6_34_2023_10_27_S52_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C6_34_2023_10_27/20231110_HKHFMDRX3/raw_data/C6_34_2023_10_27_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C7_16_2023_10_26/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/C7_16_2023_10_26_S28_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C7_16_2023_10_26/20231110_HKHFMDRX3/raw_data/C7_16_2023_10_26_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/C7_16_2023_10_26_S28_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C7_16_2023_10_26/20231110_HKHFMDRX3/raw_data/C7_16_2023_10_26_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C8_32_2023_10_30/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/C8_32_2023_10_30_S21_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C8_32_2023_10_30/20231110_HKHFMDRX3/raw_data/C8_32_2023_10_30_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/C8_32_2023_10_30_S21_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C8_32_2023_10_30/20231110_HKHFMDRX3/raw_data/C8_32_2023_10_30_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C9_36_2023_10_28/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/C9_36_2023_10_28_S2_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C9_36_2023_10_28/20231110_HKHFMDRX3/raw_data/C9_36_2023_10_28_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/C9_36_2023_10_28_S2_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C9_36_2023_10_28/20231110_HKHFMDRX3/raw_data/C9_36_2023_10_28_R2.fastq.gz"||X
echo -ne "\r[████████▌·······]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D1_10_2023_10_28/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/D1_10_2023_10_28_S50_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D1_10_2023_10_28/20231110_HKHFMDRX3/raw_data/D1_10_2023_10_28_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/D1_10_2023_10_28_S50_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D1_10_2023_10_28/20231110_HKHFMDRX3/raw_data/D1_10_2023_10_28_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D2_17_2023_10_26/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/D2_17_2023_10_26_S11_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D2_17_2023_10_26/20231110_HKHFMDRX3/raw_data/D2_17_2023_10_26_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/D2_17_2023_10_26_S11_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D2_17_2023_10_26/20231110_HKHFMDRX3/raw_data/D2_17_2023_10_26_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D3_35_2023_10_29/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/D3_35_2023_10_29_S16_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D3_35_2023_10_29/20231110_HKHFMDRX3/raw_data/D3_35_2023_10_29_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/D3_35_2023_10_29_S16_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D3_35_2023_10_29/20231110_HKHFMDRX3/raw_data/D3_35_2023_10_29_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D4_15_2023_10_28/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/D4_15_2023_10_28_S59_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D4_15_2023_10_28/20231110_HKHFMDRX3/raw_data/D4_15_2023_10_28_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/D4_15_2023_10_28_S59_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D4_15_2023_10_28/20231110_HKHFMDRX3/raw_data/D4_15_2023_10_28_R2.fastq.gz"||X
echo -ne "\r[████████▋·······]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D5_19_2023_10_25/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/D5_19_2023_10_25_S65_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D5_19_2023_10_25/20231110_HKHFMDRX3/raw_data/D5_19_2023_10_25_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/D5_19_2023_10_25_S65_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D5_19_2023_10_25/20231110_HKHFMDRX3/raw_data/D5_19_2023_10_25_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D6_34_2023_10_28/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/D6_34_2023_10_28_S5_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D6_34_2023_10_28/20231110_HKHFMDRX3/raw_data/D6_34_2023_10_28_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/D6_34_2023_10_28_S5_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D6_34_2023_10_28/20231110_HKHFMDRX3/raw_data/D6_34_2023_10_28_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D7_16_2023_10_28/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/D7_16_2023_10_28_S27_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D7_16_2023_10_28/20231110_HKHFMDRX3/raw_data/D7_16_2023_10_28_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/D7_16_2023_10_28_S27_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D7_16_2023_10_28/20231110_HKHFMDRX3/raw_data/D7_16_2023_10_28_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D8_32_2023_10_31/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/D8_32_2023_10_31_S18_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D8_32_2023_10_31/20231110_HKHFMDRX3/raw_data/D8_32_2023_10_31_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/D8_32_2023_10_31_S18_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D8_32_2023_10_31/20231110_HKHFMDRX3/raw_data/D8_32_2023_10_31_R2.fastq.gz"||X
echo -ne "\r[████████▊·······]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D9_36_2023_10_29/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/D9_36_2023_10_29_S49_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D9_36_2023_10_29/20231110_HKHFMDRX3/raw_data/D9_36_2023_10_29_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/D9_36_2023_10_29_S49_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D9_36_2023_10_29/20231110_HKHFMDRX3/raw_data/D9_36_2023_10_29_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E1_10_2023_10_29/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/E1_10_2023_10_29_S57_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E1_10_2023_10_29/20231110_HKHFMDRX3/raw_data/E1_10_2023_10_29_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/E1_10_2023_10_29_S57_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E1_10_2023_10_29/20231110_HKHFMDRX3/raw_data/E1_10_2023_10_29_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E2_17_2023_10_27/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/E2_17_2023_10_27_S7_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E2_17_2023_10_27/20231110_HKHFMDRX3/raw_data/E2_17_2023_10_27_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/E2_17_2023_10_27_S7_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E2_17_2023_10_27/20231110_HKHFMDRX3/raw_data/E2_17_2023_10_27_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E3_05_2023_10_25/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/E3_05_2023_10_25_S54_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E3_05_2023_10_25/20231110_HKHFMDRX3/raw_data/E3_05_2023_10_25_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/E3_05_2023_10_25_S54_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E3_05_2023_10_25/20231110_HKHFMDRX3/raw_data/E3_05_2023_10_25_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E4_15_2023_10_29/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/E4_15_2023_10_29_S44_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E4_15_2023_10_29/20231110_HKHFMDRX3/raw_data/E4_15_2023_10_29_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/E4_15_2023_10_29_S44_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E4_15_2023_10_29/20231110_HKHFMDRX3/raw_data/E4_15_2023_10_29_R2.fastq.gz"||X
echo -ne "\r[████████▉·······]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E5_19_2023_10_27/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/E5_19_2023_10_27_S60_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E5_19_2023_10_27/20231110_HKHFMDRX3/raw_data/E5_19_2023_10_27_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/E5_19_2023_10_27_S60_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E5_19_2023_10_27/20231110_HKHFMDRX3/raw_data/E5_19_2023_10_27_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E6_34_2023_10_29/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/E6_34_2023_10_29_S15_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E6_34_2023_10_29/20231110_HKHFMDRX3/raw_data/E6_34_2023_10_29_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/E6_34_2023_10_29_S15_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E6_34_2023_10_29/20231110_HKHFMDRX3/raw_data/E6_34_2023_10_29_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E7_16_2023_10_29/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/E7_16_2023_10_29_S68_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E7_16_2023_10_29/20231110_HKHFMDRX3/raw_data/E7_16_2023_10_29_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/E7_16_2023_10_29_S68_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E7_16_2023_10_29/20231110_HKHFMDRX3/raw_data/E7_16_2023_10_29_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E8_33_2023_10_26/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/E8_33_2023_10_26_S64_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E8_33_2023_10_26/20231110_HKHFMDRX3/raw_data/E8_33_2023_10_26_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/E8_33_2023_10_26_S64_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E8_33_2023_10_26/20231110_HKHFMDRX3/raw_data/E8_33_2023_10_26_R2.fastq.gz"||X
echo -ne "\r[█████████·······]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E9_36_2023_10_30/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/E9_36_2023_10_30_S51_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E9_36_2023_10_30/20231110_HKHFMDRX3/raw_data/E9_36_2023_10_30_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/E9_36_2023_10_30_S51_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E9_36_2023_10_30/20231110_HKHFMDRX3/raw_data/E9_36_2023_10_30_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F1_12_2023_10_24/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/F1_12_2023_10_24_S10_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F1_12_2023_10_24/20231110_HKHFMDRX3/raw_data/F1_12_2023_10_24_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/F1_12_2023_10_24_S10_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F1_12_2023_10_24/20231110_HKHFMDRX3/raw_data/F1_12_2023_10_24_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F2_17_2023_10_28/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/F2_17_2023_10_28_S41_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F2_17_2023_10_28/20231110_HKHFMDRX3/raw_data/F2_17_2023_10_28_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/F2_17_2023_10_28_S41_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F2_17_2023_10_28/20231110_HKHFMDRX3/raw_data/F2_17_2023_10_28_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F3_05_2023_10_27/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/F3_05_2023_10_27_S38_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F3_05_2023_10_27/20231110_HKHFMDRX3/raw_data/F3_05_2023_10_27_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/F3_05_2023_10_27_S38_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F3_05_2023_10_27/20231110_HKHFMDRX3/raw_data/F3_05_2023_10_27_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F4_15_2023_10_30/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/F4_15_2023_10_30_S20_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F4_15_2023_10_30/20231110_HKHFMDRX3/raw_data/F4_15_2023_10_30_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/F4_15_2023_10_30_S20_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F4_15_2023_10_30/20231110_HKHFMDRX3/raw_data/F4_15_2023_10_30_R2.fastq.gz"||X
echo -ne "\r[█████████▏······]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F5_19_2023_10_28/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/F5_19_2023_10_28_S13_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F5_19_2023_10_28/20231110_HKHFMDRX3/raw_data/F5_19_2023_10_28_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/F5_19_2023_10_28_S13_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F5_19_2023_10_28/20231110_HKHFMDRX3/raw_data/F5_19_2023_10_28_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F6_25_2023_10_27/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/F6_25_2023_10_27_S30_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F6_25_2023_10_27/20231110_HKHFMDRX3/raw_data/F6_25_2023_10_27_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/F6_25_2023_10_27_S30_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F6_25_2023_10_27/20231110_HKHFMDRX3/raw_data/F6_25_2023_10_27_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F7_16_2023_10_30/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/F7_16_2023_10_30_S43_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F7_16_2023_10_30/20231110_HKHFMDRX3/raw_data/F7_16_2023_10_30_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/F7_16_2023_10_30_S43_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F7_16_2023_10_30/20231110_HKHFMDRX3/raw_data/F7_16_2023_10_30_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F8_33_2023_10_28/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/F8_33_2023_10_28_S34_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F8_33_2023_10_28/20231110_HKHFMDRX3/raw_data/F8_33_2023_10_28_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/F8_33_2023_10_28_S34_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F8_33_2023_10_28/20231110_HKHFMDRX3/raw_data/F8_33_2023_10_28_R2.fastq.gz"||X
echo -ne "\r[█████████▎······]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F9_36_2023_10_31/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/F9_36_2023_10_31_S8_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F9_36_2023_10_31/20231110_HKHFMDRX3/raw_data/F9_36_2023_10_31_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/F9_36_2023_10_31_S8_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F9_36_2023_10_31/20231110_HKHFMDRX3/raw_data/F9_36_2023_10_31_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G1_12_2023_10_26/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/G1_12_2023_10_26_S70_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G1_12_2023_10_26/20231110_HKHFMDRX3/raw_data/G1_12_2023_10_26_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/G1_12_2023_10_26_S70_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G1_12_2023_10_26/20231110_HKHFMDRX3/raw_data/G1_12_2023_10_26_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G2_17_2023_10_29/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/G2_17_2023_10_29_S24_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G2_17_2023_10_29/20231110_HKHFMDRX3/raw_data/G2_17_2023_10_29_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/G2_17_2023_10_29_S24_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G2_17_2023_10_29/20231110_HKHFMDRX3/raw_data/G2_17_2023_10_29_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G3_05_2023_10_28/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/G3_05_2023_10_28_S39_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G3_05_2023_10_28/20231110_HKHFMDRX3/raw_data/G3_05_2023_10_28_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/G3_05_2023_10_28_S39_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G3_05_2023_10_28/20231110_HKHFMDRX3/raw_data/G3_05_2023_10_28_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G4_18_2023_10_25/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/G4_18_2023_10_25_S6_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G4_18_2023_10_25/20231110_HKHFMDRX3/raw_data/G4_18_2023_10_25_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/G4_18_2023_10_25_S6_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G4_18_2023_10_25/20231110_HKHFMDRX3/raw_data/G4_18_2023_10_25_R2.fastq.gz"||X
echo -ne "\r[█████████▍······]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G5_19_2023_10_29/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/G5_19_2023_10_29_S48_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G5_19_2023_10_29/20231110_HKHFMDRX3/raw_data/G5_19_2023_10_29_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/G5_19_2023_10_29_S48_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G5_19_2023_10_29/20231110_HKHFMDRX3/raw_data/G5_19_2023_10_29_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G6_25_2023_10_25/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/G6_25_2023_10_25_S55_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G6_25_2023_10_25/20231110_HKHFMDRX3/raw_data/G6_25_2023_10_25_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/G6_25_2023_10_25_S55_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G6_25_2023_10_25/20231110_HKHFMDRX3/raw_data/G6_25_2023_10_25_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G7_16_2023_10_31/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/G7_16_2023_10_31_S14_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G7_16_2023_10_31/20231110_HKHFMDRX3/raw_data/G7_16_2023_10_31_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/G7_16_2023_10_31_S14_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G7_16_2023_10_31/20231110_HKHFMDRX3/raw_data/G7_16_2023_10_31_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G8_33_2023_10_29/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/G8_33_2023_10_29_S35_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G8_33_2023_10_29/20231110_HKHFMDRX3/raw_data/G8_33_2023_10_29_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/G8_33_2023_10_29_S35_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G8_33_2023_10_29/20231110_HKHFMDRX3/raw_data/G8_33_2023_10_29_R2.fastq.gz"||X
echo -ne "\r[█████████▌······]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H1_12_2023_10_27/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/H1_12_2023_10_27_S29_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H1_12_2023_10_27/20231110_HKHFMDRX3/raw_data/H1_12_2023_10_27_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/H1_12_2023_10_27_S29_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H1_12_2023_10_27/20231110_HKHFMDRX3/raw_data/H1_12_2023_10_27_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H2_35_2023_10_24/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/H2_35_2023_10_24_S4_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H2_35_2023_10_24/20231110_HKHFMDRX3/raw_data/H2_35_2023_10_24_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/H2_35_2023_10_24_S4_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H2_35_2023_10_24/20231110_HKHFMDRX3/raw_data/H2_35_2023_10_24_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H3_05_2023_10_29/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/H3_05_2023_10_29_S62_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H3_05_2023_10_29/20231110_HKHFMDRX3/raw_data/H3_05_2023_10_29_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/H3_05_2023_10_29_S62_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H3_05_2023_10_29/20231110_HKHFMDRX3/raw_data/H3_05_2023_10_29_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H4_18_2023_10_27/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/H4_18_2023_10_27_S31_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H4_18_2023_10_27/20231110_HKHFMDRX3/raw_data/H4_18_2023_10_27_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/H4_18_2023_10_27_S31_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H4_18_2023_10_27/20231110_HKHFMDRX3/raw_data/H4_18_2023_10_27_R2.fastq.gz"||X
echo -ne "\r[█████████▋······]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H5_19_2023_10_30/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/H5_19_2023_10_30_S12_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H5_19_2023_10_30/20231110_HKHFMDRX3/raw_data/H5_19_2023_10_30_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/H5_19_2023_10_30_S12_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H5_19_2023_10_30/20231110_HKHFMDRX3/raw_data/H5_19_2023_10_30_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H6_25_2023_10_28/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/H6_25_2023_10_28_S53_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H6_25_2023_10_28/20231110_HKHFMDRX3/raw_data/H6_25_2023_10_28_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/H6_25_2023_10_28_S53_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H6_25_2023_10_28/20231110_HKHFMDRX3/raw_data/H6_25_2023_10_28_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H7_32_2023_10_26/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/H7_32_2023_10_26_S1_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H7_32_2023_10_26/20231110_HKHFMDRX3/raw_data/H7_32_2023_10_26_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/H7_32_2023_10_26_S1_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H7_32_2023_10_26/20231110_HKHFMDRX3/raw_data/H7_32_2023_10_26_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H8_33_2023_10_30/"{,"20231110_HKHFMDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/H8_33_2023_10_30_S3_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H8_33_2023_10_30/20231110_HKHFMDRX3/raw_data/H8_33_2023_10_30_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33365_NovaSeq_231110_NOV1919/H8_33_2023_10_30_S3_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H8_33_2023_10_30/20231110_HKHFMDRX3/raw_data/H8_33_2023_10_30_R2.fastq.gz"||X
if [[ ! -d "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917" ]]; then
    fail "Not a directory:" "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917"
fi

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A1_05_2023_10_17/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/A1_05_2023_10_17_S135_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A1_05_2023_10_17/20231103_HLTHYDRX3/raw_data/A1_05_2023_10_17_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/A1_05_2023_10_17_S135_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A1_05_2023_10_17/20231103_HLTHYDRX3/raw_data/A1_05_2023_10_17_R2.fastq.gz"||X
echo -ne "\r[█████████▊······]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A2_10_2023_10_21/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/A2_10_2023_10_21_S131_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A2_10_2023_10_21/20231103_HLTHYDRX3/raw_data/A2_10_2023_10_21_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/A2_10_2023_10_21_S131_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A2_10_2023_10_21/20231103_HLTHYDRX3/raw_data/A2_10_2023_10_21_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A3_15_2023_10_19/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/A3_15_2023_10_19_S123_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A3_15_2023_10_19/20231103_HLTHYDRX3/raw_data/A3_15_2023_10_19_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/A3_15_2023_10_19_S123_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A3_15_2023_10_19/20231103_HLTHYDRX3/raw_data/A3_15_2023_10_19_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A4_16_2023_10_24/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/A4_16_2023_10_24_S132_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A4_16_2023_10_24/20231103_HLTHYDRX3/raw_data/A4_16_2023_10_24_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/A4_16_2023_10_24_S132_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A4_16_2023_10_24/20231103_HLTHYDRX3/raw_data/A4_16_2023_10_24_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A5_18_2023_10_21/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/A5_18_2023_10_21_S90_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A5_18_2023_10_21/20231103_HLTHYDRX3/raw_data/A5_18_2023_10_21_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/A5_18_2023_10_21_S90_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A5_18_2023_10_21/20231103_HLTHYDRX3/raw_data/A5_18_2023_10_21_R2.fastq.gz"||X
echo -ne "\r[█████████▉······]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A6_25_2023_10_17/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/A6_25_2023_10_17_S85_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A6_25_2023_10_17/20231103_HLTHYDRX3/raw_data/A6_25_2023_10_17_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/A6_25_2023_10_17_S85_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A6_25_2023_10_17/20231103_HLTHYDRX3/raw_data/A6_25_2023_10_17_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A7_32_2023_10_23/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/A7_32_2023_10_23_S118_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A7_32_2023_10_23/20231103_HLTHYDRX3/raw_data/A7_32_2023_10_23_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/A7_32_2023_10_23_S118_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A7_32_2023_10_23/20231103_HLTHYDRX3/raw_data/A7_32_2023_10_23_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A8_34_2023_10_18/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/A8_34_2023_10_18_S121_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A8_34_2023_10_18/20231103_HLTHYDRX3/raw_data/A8_34_2023_10_18_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/A8_34_2023_10_18_S121_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A8_34_2023_10_18/20231103_HLTHYDRX3/raw_data/A8_34_2023_10_18_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"A9_35_2023_10_22/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/A9_35_2023_10_22_S94_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/A9_35_2023_10_22/20231103_HLTHYDRX3/raw_data/A9_35_2023_10_22_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/A9_35_2023_10_22_S94_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/A9_35_2023_10_22/20231103_HLTHYDRX3/raw_data/A9_35_2023_10_22_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B1_05_2023_10_19/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/B1_05_2023_10_19_S97_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B1_05_2023_10_19/20231103_HLTHYDRX3/raw_data/B1_05_2023_10_19_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/B1_05_2023_10_19_S97_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B1_05_2023_10_19/20231103_HLTHYDRX3/raw_data/B1_05_2023_10_19_R2.fastq.gz"||X
echo -ne "\r[██████████······]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B2_10_2023_10_22/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/B2_10_2023_10_22_S81_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B2_10_2023_10_22/20231103_HLTHYDRX3/raw_data/B2_10_2023_10_22_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/B2_10_2023_10_22_S81_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B2_10_2023_10_22/20231103_HLTHYDRX3/raw_data/B2_10_2023_10_22_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B3_15_2023_10_21/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/B3_15_2023_10_21_S104_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B3_15_2023_10_21/20231103_HLTHYDRX3/raw_data/B3_15_2023_10_21_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/B3_15_2023_10_21_S104_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B3_15_2023_10_21/20231103_HLTHYDRX3/raw_data/B3_15_2023_10_21_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B4_17_2023_10_16/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/B4_17_2023_10_16_S93_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B4_17_2023_10_16/20231103_HLTHYDRX3/raw_data/B4_17_2023_10_16_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/B4_17_2023_10_16_S93_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B4_17_2023_10_16/20231103_HLTHYDRX3/raw_data/B4_17_2023_10_16_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B5_18_2023_10_22/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/B5_18_2023_10_22_S101_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B5_18_2023_10_22/20231103_HLTHYDRX3/raw_data/B5_18_2023_10_22_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/B5_18_2023_10_22_S101_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B5_18_2023_10_22/20231103_HLTHYDRX3/raw_data/B5_18_2023_10_22_R2.fastq.gz"||X
echo -ne "\r[██████████▏·····]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B6_25_2023_10_19/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/B6_25_2023_10_19_S114_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B6_25_2023_10_19/20231103_HLTHYDRX3/raw_data/B6_25_2023_10_19_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/B6_25_2023_10_19_S114_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B6_25_2023_10_19/20231103_HLTHYDRX3/raw_data/B6_25_2023_10_19_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B7_32_2023_10_24/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/B7_32_2023_10_24_S117_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B7_32_2023_10_24/20231103_HLTHYDRX3/raw_data/B7_32_2023_10_24_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/B7_32_2023_10_24_S117_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B7_32_2023_10_24/20231103_HLTHYDRX3/raw_data/B7_32_2023_10_24_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B8_34_2023_10_20/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/B8_34_2023_10_20_S111_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B8_34_2023_10_20/20231103_HLTHYDRX3/raw_data/B8_34_2023_10_20_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/B8_34_2023_10_20_S111_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B8_34_2023_10_20/20231103_HLTHYDRX3/raw_data/B8_34_2023_10_20_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"B9_36_2023_10_18/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/B9_36_2023_10_18_S112_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/B9_36_2023_10_18/20231103_HLTHYDRX3/raw_data/B9_36_2023_10_18_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/B9_36_2023_10_18_S112_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/B9_36_2023_10_18/20231103_HLTHYDRX3/raw_data/B9_36_2023_10_18_R2.fastq.gz"||X
echo -ne "\r[██████████▎·····]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C1_05_2023_10_21/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/C1_05_2023_10_21_S96_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C1_05_2023_10_21/20231103_HLTHYDRX3/raw_data/C1_05_2023_10_21_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/C1_05_2023_10_21_S96_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C1_05_2023_10_21/20231103_HLTHYDRX3/raw_data/C1_05_2023_10_21_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C2_12_2023_10_16/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/C2_12_2023_10_16_S91_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C2_12_2023_10_16/20231103_HLTHYDRX3/raw_data/C2_12_2023_10_16_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/C2_12_2023_10_16_S91_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C2_12_2023_10_16/20231103_HLTHYDRX3/raw_data/C2_12_2023_10_16_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C3_15_2023_10_22/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/C3_15_2023_10_22_S79_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C3_15_2023_10_22/20231103_HLTHYDRX3/raw_data/C3_15_2023_10_22_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/C3_15_2023_10_22_S79_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C3_15_2023_10_22/20231103_HLTHYDRX3/raw_data/C3_15_2023_10_22_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C4_17_2023_10_18/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/C4_17_2023_10_18_S89_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C4_17_2023_10_18/20231103_HLTHYDRX3/raw_data/C4_17_2023_10_18_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/C4_17_2023_10_18_S89_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C4_17_2023_10_18/20231103_HLTHYDRX3/raw_data/C4_17_2023_10_18_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C5_18_2023_10_23/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/C5_18_2023_10_23_S82_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C5_18_2023_10_23/20231103_HLTHYDRX3/raw_data/C5_18_2023_10_23_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/C5_18_2023_10_23_S82_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C5_18_2023_10_23/20231103_HLTHYDRX3/raw_data/C5_18_2023_10_23_R2.fastq.gz"||X
echo -ne "\r[██████████▍·····]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C6_25_2023_10_21/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/C6_25_2023_10_21_S125_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C6_25_2023_10_21/20231103_HLTHYDRX3/raw_data/C6_25_2023_10_21_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/C6_25_2023_10_21_S125_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C6_25_2023_10_21/20231103_HLTHYDRX3/raw_data/C6_25_2023_10_21_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C7_33_2023_10_18/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/C7_33_2023_10_18_S106_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C7_33_2023_10_18/20231103_HLTHYDRX3/raw_data/C7_33_2023_10_18_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/C7_33_2023_10_18_S106_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C7_33_2023_10_18/20231103_HLTHYDRX3/raw_data/C7_33_2023_10_18_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C8_34_2023_10_21/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/C8_34_2023_10_21_S119_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C8_34_2023_10_21/20231103_HLTHYDRX3/raw_data/C8_34_2023_10_21_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/C8_34_2023_10_21_S119_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C8_34_2023_10_21/20231103_HLTHYDRX3/raw_data/C8_34_2023_10_21_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"C9_36_2023_10_20/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/C9_36_2023_10_20_S126_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/C9_36_2023_10_20/20231103_HLTHYDRX3/raw_data/C9_36_2023_10_20_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/C9_36_2023_10_20_S126_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/C9_36_2023_10_20/20231103_HLTHYDRX3/raw_data/C9_36_2023_10_20_R2.fastq.gz"||X
echo -ne "\r[██████████▌·····]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D1_05_2023_10_22/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/D1_05_2023_10_22_S136_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D1_05_2023_10_22/20231103_HLTHYDRX3/raw_data/D1_05_2023_10_22_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/D1_05_2023_10_22_S136_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D1_05_2023_10_22/20231103_HLTHYDRX3/raw_data/D1_05_2023_10_22_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D2_12_2023_10_18/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/D2_12_2023_10_18_S102_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D2_12_2023_10_18/20231103_HLTHYDRX3/raw_data/D2_12_2023_10_18_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/D2_12_2023_10_18_S102_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D2_12_2023_10_18/20231103_HLTHYDRX3/raw_data/D2_12_2023_10_18_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D3_15_2023_10_23/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/D3_15_2023_10_23_S122_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D3_15_2023_10_23/20231103_HLTHYDRX3/raw_data/D3_15_2023_10_23_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/D3_15_2023_10_23_S122_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D3_15_2023_10_23/20231103_HLTHYDRX3/raw_data/D3_15_2023_10_23_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D4_17_2023_10_20/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/D4_17_2023_10_20_S138_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D4_17_2023_10_20/20231103_HLTHYDRX3/raw_data/D4_17_2023_10_20_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/D4_17_2023_10_20_S138_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D4_17_2023_10_20/20231103_HLTHYDRX3/raw_data/D4_17_2023_10_20_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D5_19_2023_10_17/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/D5_19_2023_10_17_S129_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D5_19_2023_10_17/20231103_HLTHYDRX3/raw_data/D5_19_2023_10_17_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/D5_19_2023_10_17_S129_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D5_19_2023_10_17/20231103_HLTHYDRX3/raw_data/D5_19_2023_10_17_R2.fastq.gz"||X
echo -ne "\r[██████████▋·····]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D6_25_2023_10_22/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/D6_25_2023_10_22_S107_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D6_25_2023_10_22/20231103_HLTHYDRX3/raw_data/D6_25_2023_10_22_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/D6_25_2023_10_22_S107_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D6_25_2023_10_22/20231103_HLTHYDRX3/raw_data/D6_25_2023_10_22_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D7_33_2023_10_20/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/D7_33_2023_10_20_S109_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D7_33_2023_10_20/20231103_HLTHYDRX3/raw_data/D7_33_2023_10_20_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/D7_33_2023_10_20_S109_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D7_33_2023_10_20/20231103_HLTHYDRX3/raw_data/D7_33_2023_10_20_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D8_34_2023_10_22/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/D8_34_2023_10_22_S76_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D8_34_2023_10_22/20231103_HLTHYDRX3/raw_data/D8_34_2023_10_22_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/D8_34_2023_10_22_S76_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D8_34_2023_10_22/20231103_HLTHYDRX3/raw_data/D8_34_2023_10_22_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"D9_36_2023_10_22/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/D9_36_2023_10_22_S92_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/D9_36_2023_10_22/20231103_HLTHYDRX3/raw_data/D9_36_2023_10_22_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/D9_36_2023_10_22_S92_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/D9_36_2023_10_22/20231103_HLTHYDRX3/raw_data/D9_36_2023_10_22_R2.fastq.gz"||X
echo -ne "\r[██████████▊·····]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E1_05_2023_10_23/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/E1_05_2023_10_23_S77_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E1_05_2023_10_23/20231103_HLTHYDRX3/raw_data/E1_05_2023_10_23_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/E1_05_2023_10_23_S77_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E1_05_2023_10_23/20231103_HLTHYDRX3/raw_data/E1_05_2023_10_23_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E2_12_2023_10_20/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/E2_12_2023_10_20_S130_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E2_12_2023_10_20/20231103_HLTHYDRX3/raw_data/E2_12_2023_10_20_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/E2_12_2023_10_20_S130_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E2_12_2023_10_20/20231103_HLTHYDRX3/raw_data/E2_12_2023_10_20_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E3_16_2023_10_18/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/E3_16_2023_10_18_S98_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E3_16_2023_10_18/20231103_HLTHYDRX3/raw_data/E3_16_2023_10_18_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/E3_16_2023_10_18_S98_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E3_16_2023_10_18/20231103_HLTHYDRX3/raw_data/E3_16_2023_10_18_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E4_17_2023_10_21/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/E4_17_2023_10_21_S84_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E4_17_2023_10_21/20231103_HLTHYDRX3/raw_data/E4_17_2023_10_21_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/E4_17_2023_10_21_S84_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E4_17_2023_10_21/20231103_HLTHYDRX3/raw_data/E4_17_2023_10_21_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E5_19_2023_10_19/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/E5_19_2023_10_19_S103_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E5_19_2023_10_19/20231103_HLTHYDRX3/raw_data/E5_19_2023_10_19_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/E5_19_2023_10_19_S103_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E5_19_2023_10_19/20231103_HLTHYDRX3/raw_data/E5_19_2023_10_19_R2.fastq.gz"||X
echo -ne "\r[██████████▉·····]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E6_25_2023_10_23/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/E6_25_2023_10_23_S127_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E6_25_2023_10_23/20231103_HLTHYDRX3/raw_data/E6_25_2023_10_23_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/E6_25_2023_10_23_S127_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E6_25_2023_10_23/20231103_HLTHYDRX3/raw_data/E6_25_2023_10_23_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E8_35_2023_10_16/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/E8_35_2023_10_16_S88_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E8_35_2023_10_16/20231103_HLTHYDRX3/raw_data/E8_35_2023_10_16_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/E8_35_2023_10_16_S88_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E8_35_2023_10_16/20231103_HLTHYDRX3/raw_data/E8_35_2023_10_16_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"E9_36_2023_10_23/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/E9_36_2023_10_23_S128_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/E9_36_2023_10_23/20231103_HLTHYDRX3/raw_data/E9_36_2023_10_23_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/E9_36_2023_10_23_S128_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/E9_36_2023_10_23/20231103_HLTHYDRX3/raw_data/E9_36_2023_10_23_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F1_10_2023_10_16/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/F1_10_2023_10_16_S75_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F1_10_2023_10_16/20231103_HLTHYDRX3/raw_data/F1_10_2023_10_16_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/F1_10_2023_10_16_S75_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F1_10_2023_10_16/20231103_HLTHYDRX3/raw_data/F1_10_2023_10_16_R2.fastq.gz"||X
echo -ne "\r[███████████·····]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F2_12_2023_10_21/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/F2_12_2023_10_21_S87_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F2_12_2023_10_21/20231103_HLTHYDRX3/raw_data/F2_12_2023_10_21_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/F2_12_2023_10_21_S87_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F2_12_2023_10_21/20231103_HLTHYDRX3/raw_data/F2_12_2023_10_21_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F3_16_2023_10_20/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/F3_16_2023_10_20_S134_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F3_16_2023_10_20/20231103_HLTHYDRX3/raw_data/F3_16_2023_10_20_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/F3_16_2023_10_20_S134_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F3_16_2023_10_20/20231103_HLTHYDRX3/raw_data/F3_16_2023_10_20_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F4_17_2023_10_22/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/F4_17_2023_10_22_S133_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F4_17_2023_10_22/20231103_HLTHYDRX3/raw_data/F4_17_2023_10_22_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/F4_17_2023_10_22_S133_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F4_17_2023_10_22/20231103_HLTHYDRX3/raw_data/F4_17_2023_10_22_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F5_19_2023_10_21/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/F5_19_2023_10_21_S137_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F5_19_2023_10_21/20231103_HLTHYDRX3/raw_data/F5_19_2023_10_21_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/F5_19_2023_10_21_S137_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F5_19_2023_10_21/20231103_HLTHYDRX3/raw_data/F5_19_2023_10_21_R2.fastq.gz"||X
echo -ne "\r[███████████▏····]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F6_32_2023_10_18/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/F6_32_2023_10_18_S124_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F6_32_2023_10_18/20231103_HLTHYDRX3/raw_data/F6_32_2023_10_18_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/F6_32_2023_10_18_S124_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F6_32_2023_10_18/20231103_HLTHYDRX3/raw_data/F6_32_2023_10_18_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F7_33_2023_10_23/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/F7_33_2023_10_23_S78_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F7_33_2023_10_23/20231103_HLTHYDRX3/raw_data/F7_33_2023_10_23_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/F7_33_2023_10_23_S78_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F7_33_2023_10_23/20231103_HLTHYDRX3/raw_data/F7_33_2023_10_23_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F8_35_2023_10_18/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/F8_35_2023_10_18_S74_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F8_35_2023_10_18/20231103_HLTHYDRX3/raw_data/F8_35_2023_10_18_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/F8_35_2023_10_18_S74_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F8_35_2023_10_18/20231103_HLTHYDRX3/raw_data/F8_35_2023_10_18_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"F9_36_2023_10_24/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/F9_36_2023_10_24_S80_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/F9_36_2023_10_24/20231103_HLTHYDRX3/raw_data/F9_36_2023_10_24_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/F9_36_2023_10_24_S80_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/F9_36_2023_10_24/20231103_HLTHYDRX3/raw_data/F9_36_2023_10_24_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G1_10_2023_10_18/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/G1_10_2023_10_18_S86_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G1_10_2023_10_18/20231103_HLTHYDRX3/raw_data/G1_10_2023_10_18_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/G1_10_2023_10_18_S86_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G1_10_2023_10_18/20231103_HLTHYDRX3/raw_data/G1_10_2023_10_18_R2.fastq.gz"||X
echo -ne "\r[███████████▎····]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G2_12_2023_10_22/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/G2_12_2023_10_22_S120_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G2_12_2023_10_22/20231103_HLTHYDRX3/raw_data/G2_12_2023_10_22_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/G2_12_2023_10_22_S120_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G2_12_2023_10_22/20231103_HLTHYDRX3/raw_data/G2_12_2023_10_22_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G3_16_2023_10_22/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/G3_16_2023_10_22_S115_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G3_16_2023_10_22/20231103_HLTHYDRX3/raw_data/G3_16_2023_10_22_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/G3_16_2023_10_22_S115_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G3_16_2023_10_22/20231103_HLTHYDRX3/raw_data/G3_16_2023_10_22_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G4_18_2023_10_17/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/G4_18_2023_10_17_S73_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G4_18_2023_10_17/20231103_HLTHYDRX3/raw_data/G4_18_2023_10_17_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/G4_18_2023_10_17_S73_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G4_18_2023_10_17/20231103_HLTHYDRX3/raw_data/G4_18_2023_10_17_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G5_19_2023_10_22/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/G5_19_2023_10_22_S71_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G5_19_2023_10_22/20231103_HLTHYDRX3/raw_data/G5_19_2023_10_22_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/G5_19_2023_10_22_S71_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G5_19_2023_10_22/20231103_HLTHYDRX3/raw_data/G5_19_2023_10_22_R2.fastq.gz"||X
echo -ne "\r[███████████▍····]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G6_32_2023_10_20/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/G6_32_2023_10_20_S140_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G6_32_2023_10_20/20231103_HLTHYDRX3/raw_data/G6_32_2023_10_20_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/G6_32_2023_10_20_S140_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G6_32_2023_10_20/20231103_HLTHYDRX3/raw_data/G6_32_2023_10_20_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G7_33_2023_10_24/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/G7_33_2023_10_24_S100_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G7_33_2023_10_24/20231103_HLTHYDRX3/raw_data/G7_33_2023_10_24_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/G7_33_2023_10_24_S100_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G7_33_2023_10_24/20231103_HLTHYDRX3/raw_data/G7_33_2023_10_24_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"G8_35_2023_10_20/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/G8_35_2023_10_20_S83_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/G8_35_2023_10_20/20231103_HLTHYDRX3/raw_data/G8_35_2023_10_20_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/G8_35_2023_10_20_S83_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/G8_35_2023_10_20/20231103_HLTHYDRX3/raw_data/G8_35_2023_10_20_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H1_10_2023_10_20/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/H1_10_2023_10_20_S113_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H1_10_2023_10_20/20231103_HLTHYDRX3/raw_data/H1_10_2023_10_20_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/H1_10_2023_10_20_S113_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H1_10_2023_10_20/20231103_HLTHYDRX3/raw_data/H1_10_2023_10_20_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H2_15_2023_10_17/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/H2_15_2023_10_17_S110_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H2_15_2023_10_17/20231103_HLTHYDRX3/raw_data/H2_15_2023_10_17_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/H2_15_2023_10_17_S110_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H2_15_2023_10_17/20231103_HLTHYDRX3/raw_data/H2_15_2023_10_17_R2.fastq.gz"||X
echo -ne "\r[███████████▌····]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H3_16_2023_10_23/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/H3_16_2023_10_23_S105_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H3_16_2023_10_23/20231103_HLTHYDRX3/raw_data/H3_16_2023_10_23_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/H3_16_2023_10_23_S105_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H3_16_2023_10_23/20231103_HLTHYDRX3/raw_data/H3_16_2023_10_23_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H4_18_2023_10_19/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/H4_18_2023_10_19_S99_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H4_18_2023_10_19/20231103_HLTHYDRX3/raw_data/H4_18_2023_10_19_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/H4_18_2023_10_19_S99_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H4_18_2023_10_19/20231103_HLTHYDRX3/raw_data/H4_18_2023_10_19_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H5_19_2023_10_23/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/H5_19_2023_10_23_S139_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H5_19_2023_10_23/20231103_HLTHYDRX3/raw_data/H5_19_2023_10_23_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/H5_19_2023_10_23_S139_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H5_19_2023_10_23/20231103_HLTHYDRX3/raw_data/H5_19_2023_10_23_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H6_32_2023_10_22/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/H6_32_2023_10_22_S108_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H6_32_2023_10_22/20231103_HLTHYDRX3/raw_data/H6_32_2023_10_22_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/H6_32_2023_10_22_S108_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H6_32_2023_10_22/20231103_HLTHYDRX3/raw_data/H6_32_2023_10_22_R2.fastq.gz"||X
echo -ne "\r[███████████▋····]\r"

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H7_34_2023_10_16/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/H7_34_2023_10_16_S116_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H7_34_2023_10_16/20231103_HLTHYDRX3/raw_data/H7_34_2023_10_16_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/H7_34_2023_10_16_S116_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H7_34_2023_10_16/20231103_HLTHYDRX3/raw_data/H7_34_2023_10_16_R2.fastq.gz"||X

mkdir ${mode} -p "cluster/project/pangolin/sampleset/"{,"H8_35_2023_10_21/"{,"20231103_HLTHYDRX3/"{,raw_data,extracted_data}}}
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/H8_35_2023_10_21_S72_R1_001.fastq.gz" "cluster/project/pangolin/sampleset/H8_35_2023_10_21/20231103_HLTHYDRX3/raw_data/H8_35_2023_10_21_R1.fastq.gz"||X
cp -vf ${link} "/cluster/project/pangolin/bfabric-downloads/p23224/o33290_NovaSeq_231103_NOV1917/H8_35_2023_10_21_S72_R2_001.fastq.gz" "cluster/project/pangolin/sampleset/H8_35_2023_10_21/20231103_HLTHYDRX3/raw_data/H8_35_2023_10_21_R2.fastq.gz"||X

echo -e '\r\e[K[████████████████] done.'
if (( !ALLOK )); then
        echo Some errors
        exit 1
fi;


mv -v cluster/project/pangolin/sampleset/samples.20231013_HLLJMDRX3.tsv.staging cluster/project/pangolin/sampleset/samples.20231013_HLLJMDRX3.tsv
mv -v cluster/project/pangolin/sampleset/samples.20231020_HLNKVDRX3.tsv.staging cluster/project/pangolin/sampleset/samples.20231020_HLNKVDRX3.tsv
mv -v cluster/project/pangolin/sampleset/samples.20231006_HLLLTDRX3.tsv.staging cluster/project/pangolin/sampleset/samples.20231006_HLLLTDRX3.tsv
mv -v cluster/project/pangolin/sampleset/samples.20231103_HLTHYDRX3.tsv.staging cluster/project/pangolin/sampleset/samples.20231103_HLTHYDRX3.tsv
mv -v cluster/project/pangolin/sampleset/samples.20231110_HKHFMDRX3.tsv.staging cluster/project/pangolin/sampleset/samples.20231110_HKHFMDRX3.tsv

echo All Ok
exit 0

