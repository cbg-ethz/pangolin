
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
[[ -d '/cluster/project/pangolin/sampleset' ]] || fail 'No sampleset directory:' '/cluster/project/pangolin/sampleset'
[[ -d '/cluster/project/pangolin/bfabric-downloads' ]] || fail 'No download directory:' '/cluster/project/pangolin/bfabric-downloads'

[[ -d '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104' ]] || fail 'Not a directory:' '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104'
echo -ne '\r[················]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"A1_05_2025_06_02/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/A1_05_2025_06_02_R1.fastq.gz' '/cluster/project/pangolin/sampleset/A1_05_2025_06_02/20250701_2427506364/raw_data/A1_05_2025_06_02_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/A1_05_2025_06_02_R2.fastq.gz' '/cluster/project/pangolin/sampleset/A1_05_2025_06_02/20250701_2427506364/raw_data/A1_05_2025_06_02_R2.fastq.gz'||X
echo -ne '\r[▎···············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"A2_15_2025_06_04/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/A2_15_2025_06_04_R1.fastq.gz' '/cluster/project/pangolin/sampleset/A2_15_2025_06_04/20250701_2427506364/raw_data/A2_15_2025_06_04_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/A2_15_2025_06_04_R2.fastq.gz' '/cluster/project/pangolin/sampleset/A2_15_2025_06_04/20250701_2427506364/raw_data/A2_15_2025_06_04_R2.fastq.gz'||X
echo -ne '\r[▋···············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"A3_17_2025_06_10/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/A3_17_2025_06_10_R1.fastq.gz' '/cluster/project/pangolin/sampleset/A3_17_2025_06_10/20250701_2427506364/raw_data/A3_17_2025_06_10_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/A3_17_2025_06_10_R2.fastq.gz' '/cluster/project/pangolin/sampleset/A3_17_2025_06_10/20250701_2427506364/raw_data/A3_17_2025_06_10_R2.fastq.gz'||X
echo -ne '\r[▉···············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"B1_05_2025_06_07/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/B1_05_2025_06_07_R1.fastq.gz' '/cluster/project/pangolin/sampleset/B1_05_2025_06_07/20250701_2427506364/raw_data/B1_05_2025_06_07_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/B1_05_2025_06_07_R2.fastq.gz' '/cluster/project/pangolin/sampleset/B1_05_2025_06_07/20250701_2427506364/raw_data/B1_05_2025_06_07_R2.fastq.gz'||X
echo -ne '\r[█▎··············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"B2_15_2025_06_08/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/B2_15_2025_06_08_R1.fastq.gz' '/cluster/project/pangolin/sampleset/B2_15_2025_06_08/20250701_2427506364/raw_data/B2_15_2025_06_08_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/B2_15_2025_06_08_R2.fastq.gz' '/cluster/project/pangolin/sampleset/B2_15_2025_06_08/20250701_2427506364/raw_data/B2_15_2025_06_08_R2.fastq.gz'||X
echo -ne '\r[█▌··············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"B3_17_2025_06_15/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/B3_17_2025_06_15_R1.fastq.gz' '/cluster/project/pangolin/sampleset/B3_17_2025_06_15/20250701_2427506364/raw_data/B3_17_2025_06_15_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/B3_17_2025_06_15_R2.fastq.gz' '/cluster/project/pangolin/sampleset/B3_17_2025_06_15/20250701_2427506364/raw_data/B3_17_2025_06_15_R2.fastq.gz'||X
echo -ne '\r[█▉··············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"C1_10_2025_06_02/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/C1_10_2025_06_02_R1.fastq.gz' '/cluster/project/pangolin/sampleset/C1_10_2025_06_02/20250701_2427506364/raw_data/C1_10_2025_06_02_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/C1_10_2025_06_02_R2.fastq.gz' '/cluster/project/pangolin/sampleset/C1_10_2025_06_02/20250701_2427506364/raw_data/C1_10_2025_06_02_R2.fastq.gz'||X
echo -ne '\r[██▏·············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"C2_16_2025_06_06/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/C2_16_2025_06_06_R1.fastq.gz' '/cluster/project/pangolin/sampleset/C2_16_2025_06_06/20250701_2427506364/raw_data/C2_16_2025_06_06_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/C2_16_2025_06_06_R2.fastq.gz' '/cluster/project/pangolin/sampleset/C2_16_2025_06_06/20250701_2427506364/raw_data/C2_16_2025_06_06_R2.fastq.gz'||X
echo -ne '\r[██▌·············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"C3_25_2025_06_10/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/C3_25_2025_06_10_R1.fastq.gz' '/cluster/project/pangolin/sampleset/C3_25_2025_06_10/20250701_2427506364/raw_data/C3_25_2025_06_10_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/C3_25_2025_06_10_R2.fastq.gz' '/cluster/project/pangolin/sampleset/C3_25_2025_06_10/20250701_2427506364/raw_data/C3_25_2025_06_10_R2.fastq.gz'||X
echo -ne '\r[██▉·············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"D1_10_2025_06_07/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/D1_10_2025_06_07_R1.fastq.gz' '/cluster/project/pangolin/sampleset/D1_10_2025_06_07/20250701_2427506364/raw_data/D1_10_2025_06_07_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/D1_10_2025_06_07_R2.fastq.gz' '/cluster/project/pangolin/sampleset/D1_10_2025_06_07/20250701_2427506364/raw_data/D1_10_2025_06_07_R2.fastq.gz'||X
echo -ne '\r[███▏············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"D2_16_2025_06_08/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/D2_16_2025_06_08_R1.fastq.gz' '/cluster/project/pangolin/sampleset/D2_16_2025_06_08/20250701_2427506364/raw_data/D2_16_2025_06_08_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/D2_16_2025_06_08_R2.fastq.gz' '/cluster/project/pangolin/sampleset/D2_16_2025_06_08/20250701_2427506364/raw_data/D2_16_2025_06_08_R2.fastq.gz'||X
echo -ne '\r[███▌············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"D3_25_2025_06_15/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/D3_25_2025_06_15_R1.fastq.gz' '/cluster/project/pangolin/sampleset/D3_25_2025_06_15/20250701_2427506364/raw_data/D3_25_2025_06_15_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/D3_25_2025_06_15_R2.fastq.gz' '/cluster/project/pangolin/sampleset/D3_25_2025_06_15/20250701_2427506364/raw_data/D3_25_2025_06_15_R2.fastq.gz'||X
echo -ne '\r[███▊············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"E1_17_2025_06_02/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/E1_17_2025_06_02_R1.fastq.gz' '/cluster/project/pangolin/sampleset/E1_17_2025_06_02/20250701_2427506364/raw_data/E1_17_2025_06_02_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/E1_17_2025_06_02_R2.fastq.gz' '/cluster/project/pangolin/sampleset/E1_17_2025_06_02/20250701_2427506364/raw_data/E1_17_2025_06_02_R2.fastq.gz'||X
echo -ne '\r[████▏···········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"E2_05_2025_06_10/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/E2_05_2025_06_10_R1.fastq.gz' '/cluster/project/pangolin/sampleset/E2_05_2025_06_10/20250701_2427506364/raw_data/E2_05_2025_06_10_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/E2_05_2025_06_10_R2.fastq.gz' '/cluster/project/pangolin/sampleset/E2_05_2025_06_10/20250701_2427506364/raw_data/E2_05_2025_06_10_R2.fastq.gz'||X
echo -ne '\r[████▍···········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"E3_15_2025_06_12/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/E3_15_2025_06_12_R1.fastq.gz' '/cluster/project/pangolin/sampleset/E3_15_2025_06_12/20250701_2427506364/raw_data/E3_15_2025_06_12_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/E3_15_2025_06_12_R2.fastq.gz' '/cluster/project/pangolin/sampleset/E3_15_2025_06_12/20250701_2427506364/raw_data/E3_15_2025_06_12_R2.fastq.gz'||X
echo -ne '\r[████▊···········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"F1_17_2025_06_07/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/F1_17_2025_06_07_R1.fastq.gz' '/cluster/project/pangolin/sampleset/F1_17_2025_06_07/20250701_2427506364/raw_data/F1_17_2025_06_07_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/F1_17_2025_06_07_R2.fastq.gz' '/cluster/project/pangolin/sampleset/F1_17_2025_06_07/20250701_2427506364/raw_data/F1_17_2025_06_07_R2.fastq.gz'||X
echo -ne '\r[█████···········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"F2_05_2025_06_15/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/F2_05_2025_06_15_R1.fastq.gz' '/cluster/project/pangolin/sampleset/F2_05_2025_06_15/20250701_2427506364/raw_data/F2_05_2025_06_15_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/F2_05_2025_06_15_R2.fastq.gz' '/cluster/project/pangolin/sampleset/F2_05_2025_06_15/20250701_2427506364/raw_data/F2_05_2025_06_15_R2.fastq.gz'||X
echo -ne '\r[█████▍··········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"F3_15_2025_06_16/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/F3_15_2025_06_16_R1.fastq.gz' '/cluster/project/pangolin/sampleset/F3_15_2025_06_16/20250701_2427506364/raw_data/F3_15_2025_06_16_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/F3_15_2025_06_16_R2.fastq.gz' '/cluster/project/pangolin/sampleset/F3_15_2025_06_16/20250701_2427506364/raw_data/F3_15_2025_06_16_R2.fastq.gz'||X
echo -ne '\r[█████▊··········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"G1_25_2025_06_02/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/G1_25_2025_06_02_R1.fastq.gz' '/cluster/project/pangolin/sampleset/G1_25_2025_06_02/20250701_2427506364/raw_data/G1_25_2025_06_02_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/G1_25_2025_06_02_R2.fastq.gz' '/cluster/project/pangolin/sampleset/G1_25_2025_06_02/20250701_2427506364/raw_data/G1_25_2025_06_02_R2.fastq.gz'||X
echo -ne '\r[██████··········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"G2_10_2025_06_10/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/G2_10_2025_06_10_R1.fastq.gz' '/cluster/project/pangolin/sampleset/G2_10_2025_06_10/20250701_2427506364/raw_data/G2_10_2025_06_10_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/G2_10_2025_06_10_R2.fastq.gz' '/cluster/project/pangolin/sampleset/G2_10_2025_06_10/20250701_2427506364/raw_data/G2_10_2025_06_10_R2.fastq.gz'||X
echo -ne '\r[██████▍·········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"G3_16_2025_06_10/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/G3_16_2025_06_10_R1.fastq.gz' '/cluster/project/pangolin/sampleset/G3_16_2025_06_10/20250701_2427506364/raw_data/G3_16_2025_06_10_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/G3_16_2025_06_10_R2.fastq.gz' '/cluster/project/pangolin/sampleset/G3_16_2025_06_10/20250701_2427506364/raw_data/G3_16_2025_06_10_R2.fastq.gz'||X
echo -ne '\r[██████▋·········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"H1_25_2025_06_07/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/H1_25_2025_06_07_R1.fastq.gz' '/cluster/project/pangolin/sampleset/H1_25_2025_06_07/20250701_2427506364/raw_data/H1_25_2025_06_07_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/H1_25_2025_06_07_R2.fastq.gz' '/cluster/project/pangolin/sampleset/H1_25_2025_06_07/20250701_2427506364/raw_data/H1_25_2025_06_07_R2.fastq.gz'||X
echo -ne '\r[███████·········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"H2_10_2025_06_15/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/H2_10_2025_06_15_R1.fastq.gz' '/cluster/project/pangolin/sampleset/H2_10_2025_06_15/20250701_2427506364/raw_data/H2_10_2025_06_15_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/H2_10_2025_06_15_R2.fastq.gz' '/cluster/project/pangolin/sampleset/H2_10_2025_06_15/20250701_2427506364/raw_data/H2_10_2025_06_15_R2.fastq.gz'||X
echo -ne '\r[███████▎········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"H3_16_2025_06_16/"{,"20250701_2427506364/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/H3_16_2025_06_16_R1.fastq.gz' '/cluster/project/pangolin/sampleset/H3_16_2025_06_16/20250701_2427506364/raw_data/H3_16_2025_06_16_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o38965_Aviti_250701_AV104/H3_16_2025_06_16_R2.fastq.gz' '/cluster/project/pangolin/sampleset/H3_16_2025_06_16/20250701_2427506364/raw_data/H3_16_2025_06_16_R2.fastq.gz'||X
[[ -d '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110' ]] || fail 'Not a directory:' '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110'
echo -ne '\r[███████▋········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"A1_05_2025_06_30/"{,"20250724_2447636847/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/A1_05_2025_06_30_R1.fastq.gz' '/cluster/project/pangolin/sampleset/A1_05_2025_06_30/20250724_2447636847/raw_data/A1_05_2025_06_30_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/A1_05_2025_06_30_R2.fastq.gz' '/cluster/project/pangolin/sampleset/A1_05_2025_06_30/20250724_2447636847/raw_data/A1_05_2025_06_30_R2.fastq.gz'||X
echo -ne '\r[████████········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"A2_15_2025_07_03/"{,"20250724_2447636847/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/A2_15_2025_07_03_R1.fastq.gz' '/cluster/project/pangolin/sampleset/A2_15_2025_07_03/20250724_2447636847/raw_data/A2_15_2025_07_03_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/A2_15_2025_07_03_R2.fastq.gz' '/cluster/project/pangolin/sampleset/A2_15_2025_07_03/20250724_2447636847/raw_data/A2_15_2025_07_03_R2.fastq.gz'||X
echo -ne '\r[████████▎·······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"A3_17_2025_07_08/"{,"20250724_2447636847/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/A3_17_2025_07_08_R1.fastq.gz' '/cluster/project/pangolin/sampleset/A3_17_2025_07_08/20250724_2447636847/raw_data/A3_17_2025_07_08_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/A3_17_2025_07_08_R2.fastq.gz' '/cluster/project/pangolin/sampleset/A3_17_2025_07_08/20250724_2447636847/raw_data/A3_17_2025_07_08_R2.fastq.gz'||X
echo -ne '\r[████████▋·······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"B1_05_2025_07_06/"{,"20250724_2447636847/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/B1_05_2025_07_06_R1.fastq.gz' '/cluster/project/pangolin/sampleset/B1_05_2025_07_06/20250724_2447636847/raw_data/B1_05_2025_07_06_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/B1_05_2025_07_06_R2.fastq.gz' '/cluster/project/pangolin/sampleset/B1_05_2025_07_06/20250724_2447636847/raw_data/B1_05_2025_07_06_R2.fastq.gz'||X
echo -ne '\r[████████▉·······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"B2_15_2025_07_07/"{,"20250724_2447636847/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/B2_15_2025_07_07_R1.fastq.gz' '/cluster/project/pangolin/sampleset/B2_15_2025_07_07/20250724_2447636847/raw_data/B2_15_2025_07_07_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/B2_15_2025_07_07_R2.fastq.gz' '/cluster/project/pangolin/sampleset/B2_15_2025_07_07/20250724_2447636847/raw_data/B2_15_2025_07_07_R2.fastq.gz'||X
echo -ne '\r[█████████▎······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"B3_17_2025_07_11/"{,"20250724_2447636847/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/B3_17_2025_07_11_R1.fastq.gz' '/cluster/project/pangolin/sampleset/B3_17_2025_07_11/20250724_2447636847/raw_data/B3_17_2025_07_11_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/B3_17_2025_07_11_R2.fastq.gz' '/cluster/project/pangolin/sampleset/B3_17_2025_07_11/20250724_2447636847/raw_data/B3_17_2025_07_11_R2.fastq.gz'||X
echo -ne '\r[█████████▌······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"C1_10_2025_06_30/"{,"20250724_2447636847/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/C1_10_2025_06_30_R1.fastq.gz' '/cluster/project/pangolin/sampleset/C1_10_2025_06_30/20250724_2447636847/raw_data/C1_10_2025_06_30_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/C1_10_2025_06_30_R2.fastq.gz' '/cluster/project/pangolin/sampleset/C1_10_2025_06_30/20250724_2447636847/raw_data/C1_10_2025_06_30_R2.fastq.gz'||X
echo -ne '\r[█████████▉······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"C2_16_2025_07_04/"{,"20250724_2447636847/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/C2_16_2025_07_04_R1.fastq.gz' '/cluster/project/pangolin/sampleset/C2_16_2025_07_04/20250724_2447636847/raw_data/C2_16_2025_07_04_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/C2_16_2025_07_04_R2.fastq.gz' '/cluster/project/pangolin/sampleset/C2_16_2025_07_04/20250724_2447636847/raw_data/C2_16_2025_07_04_R2.fastq.gz'||X
echo -ne '\r[██████████▏·····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"C3_25_2025_07_08/"{,"20250724_2447636847/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/C3_25_2025_07_08_R1.fastq.gz' '/cluster/project/pangolin/sampleset/C3_25_2025_07_08/20250724_2447636847/raw_data/C3_25_2025_07_08_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/C3_25_2025_07_08_R2.fastq.gz' '/cluster/project/pangolin/sampleset/C3_25_2025_07_08/20250724_2447636847/raw_data/C3_25_2025_07_08_R2.fastq.gz'||X
echo -ne '\r[██████████▌·····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"D1_10_2025_07_06/"{,"20250724_2447636847/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/D1_10_2025_07_06_R1.fastq.gz' '/cluster/project/pangolin/sampleset/D1_10_2025_07_06/20250724_2447636847/raw_data/D1_10_2025_07_06_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/D1_10_2025_07_06_R2.fastq.gz' '/cluster/project/pangolin/sampleset/D1_10_2025_07_06/20250724_2447636847/raw_data/D1_10_2025_07_06_R2.fastq.gz'||X
echo -ne '\r[██████████▉·····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"D2_16_2025_07_07/"{,"20250724_2447636847/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/D2_16_2025_07_07_R1.fastq.gz' '/cluster/project/pangolin/sampleset/D2_16_2025_07_07/20250724_2447636847/raw_data/D2_16_2025_07_07_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/D2_16_2025_07_07_R2.fastq.gz' '/cluster/project/pangolin/sampleset/D2_16_2025_07_07/20250724_2447636847/raw_data/D2_16_2025_07_07_R2.fastq.gz'||X
echo -ne '\r[███████████▏····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"D3_25_2025_07_11/"{,"20250724_2447636847/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/D3_25_2025_07_11_R1.fastq.gz' '/cluster/project/pangolin/sampleset/D3_25_2025_07_11/20250724_2447636847/raw_data/D3_25_2025_07_11_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/D3_25_2025_07_11_R2.fastq.gz' '/cluster/project/pangolin/sampleset/D3_25_2025_07_11/20250724_2447636847/raw_data/D3_25_2025_07_11_R2.fastq.gz'||X
echo -ne '\r[███████████▌····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"E1_17_2025_06_30/"{,"20250724_2447636847/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/E1_17_2025_06_30_R1.fastq.gz' '/cluster/project/pangolin/sampleset/E1_17_2025_06_30/20250724_2447636847/raw_data/E1_17_2025_06_30_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/E1_17_2025_06_30_R2.fastq.gz' '/cluster/project/pangolin/sampleset/E1_17_2025_06_30/20250724_2447636847/raw_data/E1_17_2025_06_30_R2.fastq.gz'||X
echo -ne '\r[███████████▊····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"E2_05_2025_07_08/"{,"20250724_2447636847/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/E2_05_2025_07_08_R1.fastq.gz' '/cluster/project/pangolin/sampleset/E2_05_2025_07_08/20250724_2447636847/raw_data/E2_05_2025_07_08_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/E2_05_2025_07_08_R2.fastq.gz' '/cluster/project/pangolin/sampleset/E2_05_2025_07_08/20250724_2447636847/raw_data/E2_05_2025_07_08_R2.fastq.gz'||X
echo -ne '\r[████████████▏···]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"E3_15_2025_07_08/"{,"20250724_2447636847/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/E3_15_2025_07_08_R1.fastq.gz' '/cluster/project/pangolin/sampleset/E3_15_2025_07_08/20250724_2447636847/raw_data/E3_15_2025_07_08_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/E3_15_2025_07_08_R2.fastq.gz' '/cluster/project/pangolin/sampleset/E3_15_2025_07_08/20250724_2447636847/raw_data/E3_15_2025_07_08_R2.fastq.gz'||X
echo -ne '\r[████████████▍···]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"F1_17_2025_07_06/"{,"20250724_2447636847/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/F1_17_2025_07_06_R1.fastq.gz' '/cluster/project/pangolin/sampleset/F1_17_2025_07_06/20250724_2447636847/raw_data/F1_17_2025_07_06_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/F1_17_2025_07_06_R2.fastq.gz' '/cluster/project/pangolin/sampleset/F1_17_2025_07_06/20250724_2447636847/raw_data/F1_17_2025_07_06_R2.fastq.gz'||X
echo -ne '\r[████████████▊···]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"F2_05_2025_07_11/"{,"20250724_2447636847/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/F2_05_2025_07_11_R1.fastq.gz' '/cluster/project/pangolin/sampleset/F2_05_2025_07_11/20250724_2447636847/raw_data/F2_05_2025_07_11_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/F2_05_2025_07_11_R2.fastq.gz' '/cluster/project/pangolin/sampleset/F2_05_2025_07_11/20250724_2447636847/raw_data/F2_05_2025_07_11_R2.fastq.gz'||X
echo -ne '\r[█████████████···]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"F3_15_2025_07_11/"{,"20250724_2447636847/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/F3_15_2025_07_11_R1.fastq.gz' '/cluster/project/pangolin/sampleset/F3_15_2025_07_11/20250724_2447636847/raw_data/F3_15_2025_07_11_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/F3_15_2025_07_11_R2.fastq.gz' '/cluster/project/pangolin/sampleset/F3_15_2025_07_11/20250724_2447636847/raw_data/F3_15_2025_07_11_R2.fastq.gz'||X
echo -ne '\r[█████████████▍··]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"G1_25_2025_06_30/"{,"20250724_2447636847/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/G1_25_2025_06_30_R1.fastq.gz' '/cluster/project/pangolin/sampleset/G1_25_2025_06_30/20250724_2447636847/raw_data/G1_25_2025_06_30_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/G1_25_2025_06_30_R2.fastq.gz' '/cluster/project/pangolin/sampleset/G1_25_2025_06_30/20250724_2447636847/raw_data/G1_25_2025_06_30_R2.fastq.gz'||X
echo -ne '\r[█████████████▊··]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"G2_10_2025_07_08/"{,"20250724_2447636847/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/G2_10_2025_07_08_R1.fastq.gz' '/cluster/project/pangolin/sampleset/G2_10_2025_07_08/20250724_2447636847/raw_data/G2_10_2025_07_08_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/G2_10_2025_07_08_R2.fastq.gz' '/cluster/project/pangolin/sampleset/G2_10_2025_07_08/20250724_2447636847/raw_data/G2_10_2025_07_08_R2.fastq.gz'||X
echo -ne '\r[██████████████··]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"G3_16_2025_07_08/"{,"20250724_2447636847/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/G3_16_2025_07_08_R1.fastq.gz' '/cluster/project/pangolin/sampleset/G3_16_2025_07_08/20250724_2447636847/raw_data/G3_16_2025_07_08_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/G3_16_2025_07_08_R2.fastq.gz' '/cluster/project/pangolin/sampleset/G3_16_2025_07_08/20250724_2447636847/raw_data/G3_16_2025_07_08_R2.fastq.gz'||X
echo -ne '\r[██████████████▍·]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"H1_25_2025_07_06/"{,"20250724_2447636847/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/H1_25_2025_07_06_R1.fastq.gz' '/cluster/project/pangolin/sampleset/H1_25_2025_07_06/20250724_2447636847/raw_data/H1_25_2025_07_06_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/H1_25_2025_07_06_R2.fastq.gz' '/cluster/project/pangolin/sampleset/H1_25_2025_07_06/20250724_2447636847/raw_data/H1_25_2025_07_06_R2.fastq.gz'||X
echo -ne '\r[██████████████▋·]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"H2_10_2025_07_11/"{,"20250724_2447636847/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/H2_10_2025_07_11_R1.fastq.gz' '/cluster/project/pangolin/sampleset/H2_10_2025_07_11/20250724_2447636847/raw_data/H2_10_2025_07_11_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/H2_10_2025_07_11_R2.fastq.gz' '/cluster/project/pangolin/sampleset/H2_10_2025_07_11/20250724_2447636847/raw_data/H2_10_2025_07_11_R2.fastq.gz'||X
echo -ne '\r[███████████████·]\r'

mkdir ${mode} -p "/cluster/project/pangolin/sampleset/"{,"H3_16_2025_07_12/"{,"20250724_2447636847/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/H3_16_2025_07_12_R1.fastq.gz' '/cluster/project/pangolin/sampleset/H3_16_2025_07_12/20250724_2447636847/raw_data/H3_16_2025_07_12_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/bfabric-downloads/p23224/o39253_Aviti_250724_AV110/H3_16_2025_07_12_R2.fastq.gz' '/cluster/project/pangolin/sampleset/H3_16_2025_07_12/20250724_2447636847/raw_data/H3_16_2025_07_12_R2.fastq.gz'||X

echo -e '\r\e[K[████████████████] done.'
if (( !ALLOK )); then
		echo Some errors
		exit 1
fi;


mv -v /cluster/project/pangolin/sampleset/samples.20250701_2427506364.tsv.staging /cluster/project/pangolin/sampleset/samples.20250701_2427506364.tsv
mv -v /cluster/project/pangolin/sampleset/samples.20250724_2447636847.tsv.staging /cluster/project/pangolin/sampleset/samples.20250724_2447636847.tsv

echo All Ok
exit 0

