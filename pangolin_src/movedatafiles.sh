
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
[[ -d '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input' ]] || fail 'No sampleset directory:' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input'
[[ -d '/cluster/project/pangolin/data/fgcz_raw' ]] || fail 'No download directory:' '/cluster/project/pangolin/data/fgcz_raw'

[[ -d '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111' ]] || fail 'Not a directory:' '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111'
echo -ne '\r[················]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A1_05_2025_07_28/"{,"20250822_2506652341/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/A1_05_2025_07_28_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A1_05_2025_07_28/20250822_2506652341/raw_data/A1_05_2025_07_28_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/A1_05_2025_07_28_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A1_05_2025_07_28/20250822_2506652341/raw_data/A1_05_2025_07_28_R2.fastq.gz'||X
echo -ne '\r[▏···············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A2_15_2025_07_29/"{,"20250822_2506652341/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/A2_15_2025_07_29_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A2_15_2025_07_29/20250822_2506652341/raw_data/A2_15_2025_07_29_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/A2_15_2025_07_29_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A2_15_2025_07_29/20250822_2506652341/raw_data/A2_15_2025_07_29_R2.fastq.gz'||X
echo -ne '\r[▍···············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A3_17_2025_08_05/"{,"20250822_2506652341/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/A3_17_2025_08_05_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A3_17_2025_08_05/20250822_2506652341/raw_data/A3_17_2025_08_05_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/A3_17_2025_08_05_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A3_17_2025_08_05/20250822_2506652341/raw_data/A3_17_2025_08_05_R2.fastq.gz'||X
echo -ne '\r[▋···············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B1_05_2025_08_01/"{,"20250822_2506652341/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/B1_05_2025_08_01_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B1_05_2025_08_01/20250822_2506652341/raw_data/B1_05_2025_08_01_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/B1_05_2025_08_01_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B1_05_2025_08_01/20250822_2506652341/raw_data/B1_05_2025_08_01_R2.fastq.gz'||X
echo -ne '\r[▊···············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B2_15_2025_08_01/"{,"20250822_2506652341/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/B2_15_2025_08_01_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B2_15_2025_08_01/20250822_2506652341/raw_data/B2_15_2025_08_01_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/B2_15_2025_08_01_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B2_15_2025_08_01/20250822_2506652341/raw_data/B2_15_2025_08_01_R2.fastq.gz'||X
echo -ne '\r[█···············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B3_17_2025_08_09/"{,"20250822_2506652341/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/B3_17_2025_08_09_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B3_17_2025_08_09/20250822_2506652341/raw_data/B3_17_2025_08_09_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/B3_17_2025_08_09_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B3_17_2025_08_09/20250822_2506652341/raw_data/B3_17_2025_08_09_R2.fastq.gz'||X
echo -ne '\r[█▎··············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C1_10_2025_07_28/"{,"20250822_2506652341/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/C1_10_2025_07_28_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C1_10_2025_07_28/20250822_2506652341/raw_data/C1_10_2025_07_28_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/C1_10_2025_07_28_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C1_10_2025_07_28/20250822_2506652341/raw_data/C1_10_2025_07_28_R2.fastq.gz'||X
echo -ne '\r[█▍··············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C2_16_2025_08_01/"{,"20250822_2506652341/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/C2_16_2025_08_01_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C2_16_2025_08_01/20250822_2506652341/raw_data/C2_16_2025_08_01_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/C2_16_2025_08_01_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C2_16_2025_08_01/20250822_2506652341/raw_data/C2_16_2025_08_01_R2.fastq.gz'||X
echo -ne '\r[█▋··············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C3_25_2025_08_05/"{,"20250822_2506652341/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/C3_25_2025_08_05_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C3_25_2025_08_05/20250822_2506652341/raw_data/C3_25_2025_08_05_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/C3_25_2025_08_05_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C3_25_2025_08_05/20250822_2506652341/raw_data/C3_25_2025_08_05_R2.fastq.gz'||X
echo -ne '\r[█▉··············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D1_10_2025_08_01/"{,"20250822_2506652341/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/D1_10_2025_08_01_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D1_10_2025_08_01/20250822_2506652341/raw_data/D1_10_2025_08_01_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/D1_10_2025_08_01_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D1_10_2025_08_01/20250822_2506652341/raw_data/D1_10_2025_08_01_R2.fastq.gz'||X
echo -ne '\r[██▏·············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D2_16_2025_08_02/"{,"20250822_2506652341/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/D2_16_2025_08_02_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D2_16_2025_08_02/20250822_2506652341/raw_data/D2_16_2025_08_02_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/D2_16_2025_08_02_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D2_16_2025_08_02/20250822_2506652341/raw_data/D2_16_2025_08_02_R2.fastq.gz'||X
echo -ne '\r[██▎·············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D3_25_2025_08_09/"{,"20250822_2506652341/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/D3_25_2025_08_09_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D3_25_2025_08_09/20250822_2506652341/raw_data/D3_25_2025_08_09_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/D3_25_2025_08_09_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D3_25_2025_08_09/20250822_2506652341/raw_data/D3_25_2025_08_09_R2.fastq.gz'||X
echo -ne '\r[██▌·············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E1_17_2025_07_28/"{,"20250822_2506652341/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/E1_17_2025_07_28_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E1_17_2025_07_28/20250822_2506652341/raw_data/E1_17_2025_07_28_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/E1_17_2025_07_28_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E1_17_2025_07_28/20250822_2506652341/raw_data/E1_17_2025_07_28_R2.fastq.gz'||X
echo -ne '\r[██▊·············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E2_05_2025_08_05/"{,"20250822_2506652341/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/E2_05_2025_08_05_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E2_05_2025_08_05/20250822_2506652341/raw_data/E2_05_2025_08_05_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/E2_05_2025_08_05_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E2_05_2025_08_05/20250822_2506652341/raw_data/E2_05_2025_08_05_R2.fastq.gz'||X
echo -ne '\r[██▉·············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E3_15_2025_08_06/"{,"20250822_2506652341/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/E3_15_2025_08_06_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E3_15_2025_08_06/20250822_2506652341/raw_data/E3_15_2025_08_06_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/E3_15_2025_08_06_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E3_15_2025_08_06/20250822_2506652341/raw_data/E3_15_2025_08_06_R2.fastq.gz'||X
echo -ne '\r[███▏············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F1_17_2025_08_01/"{,"20250822_2506652341/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/F1_17_2025_08_01_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F1_17_2025_08_01/20250822_2506652341/raw_data/F1_17_2025_08_01_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/F1_17_2025_08_01_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F1_17_2025_08_01/20250822_2506652341/raw_data/F1_17_2025_08_01_R2.fastq.gz'||X
echo -ne '\r[███▍············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F2_05_2025_08_09/"{,"20250822_2506652341/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/F2_05_2025_08_09_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F2_05_2025_08_09/20250822_2506652341/raw_data/F2_05_2025_08_09_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/F2_05_2025_08_09_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F2_05_2025_08_09/20250822_2506652341/raw_data/F2_05_2025_08_09_R2.fastq.gz'||X
echo -ne '\r[███▋············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F3_15_2025_08_10/"{,"20250822_2506652341/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/F3_15_2025_08_10_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F3_15_2025_08_10/20250822_2506652341/raw_data/F3_15_2025_08_10_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/F3_15_2025_08_10_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F3_15_2025_08_10/20250822_2506652341/raw_data/F3_15_2025_08_10_R2.fastq.gz'||X
echo -ne '\r[███▊············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G1_25_2025_07_28/"{,"20250822_2506652341/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/G1_25_2025_07_28_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G1_25_2025_07_28/20250822_2506652341/raw_data/G1_25_2025_07_28_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/G1_25_2025_07_28_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G1_25_2025_07_28/20250822_2506652341/raw_data/G1_25_2025_07_28_R2.fastq.gz'||X
echo -ne '\r[████············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G2_10_2025_08_05/"{,"20250822_2506652341/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/G2_10_2025_08_05_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G2_10_2025_08_05/20250822_2506652341/raw_data/G2_10_2025_08_05_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/G2_10_2025_08_05_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G2_10_2025_08_05/20250822_2506652341/raw_data/G2_10_2025_08_05_R2.fastq.gz'||X
echo -ne '\r[████▎···········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G3_16_2025_08_05/"{,"20250822_2506652341/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/G3_16_2025_08_05_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G3_16_2025_08_05/20250822_2506652341/raw_data/G3_16_2025_08_05_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/G3_16_2025_08_05_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G3_16_2025_08_05/20250822_2506652341/raw_data/G3_16_2025_08_05_R2.fastq.gz'||X
echo -ne '\r[████▍···········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H1_25_2025_08_01/"{,"20250822_2506652341/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/H1_25_2025_08_01_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H1_25_2025_08_01/20250822_2506652341/raw_data/H1_25_2025_08_01_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/H1_25_2025_08_01_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H1_25_2025_08_01/20250822_2506652341/raw_data/H1_25_2025_08_01_R2.fastq.gz'||X
echo -ne '\r[████▋···········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H2_10_2025_08_09/"{,"20250822_2506652341/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/H2_10_2025_08_09_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H2_10_2025_08_09/20250822_2506652341/raw_data/H2_10_2025_08_09_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/H2_10_2025_08_09_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H2_10_2025_08_09/20250822_2506652341/raw_data/H2_10_2025_08_09_R2.fastq.gz'||X
echo -ne '\r[████▉···········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H3_16_2025_08_10/"{,"20250822_2506652341/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/H3_16_2025_08_10_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H3_16_2025_08_10/20250822_2506652341/raw_data/H3_16_2025_08_10_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39518_Aviti_250822_AV111/H3_16_2025_08_10_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H3_16_2025_08_10/20250822_2506652341/raw_data/H3_16_2025_08_10_R2.fastq.gz'||X
[[ -d '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115' ]] || fail 'Not a directory:' '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115'
echo -ne '\r[█████···········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A1_05_2025_08_13/"{,"20250905_2506570988/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/A1_05_2025_08_13_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A1_05_2025_08_13/20250905_2506570988/raw_data/A1_05_2025_08_13_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/A1_05_2025_08_13_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A1_05_2025_08_13/20250905_2506570988/raw_data/A1_05_2025_08_13_R2.fastq.gz'||X
echo -ne '\r[█████▎··········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A2_15_2025_08_14/"{,"20250905_2506570988/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/A2_15_2025_08_14_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A2_15_2025_08_14/20250905_2506570988/raw_data/A2_15_2025_08_14_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/A2_15_2025_08_14_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A2_15_2025_08_14/20250905_2506570988/raw_data/A2_15_2025_08_14_R2.fastq.gz'||X
echo -ne '\r[█████▌··········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A3_17_2025_08_21/"{,"20250905_2506570988/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/A3_17_2025_08_21_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A3_17_2025_08_21/20250905_2506570988/raw_data/A3_17_2025_08_21_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/A3_17_2025_08_21_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A3_17_2025_08_21/20250905_2506570988/raw_data/A3_17_2025_08_21_R2.fastq.gz'||X
echo -ne '\r[█████▊··········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B1_05_2025_08_17/"{,"20250905_2506570988/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/B1_05_2025_08_17_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B1_05_2025_08_17/20250905_2506570988/raw_data/B1_05_2025_08_17_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/B1_05_2025_08_17_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B1_05_2025_08_17/20250905_2506570988/raw_data/B1_05_2025_08_17_R2.fastq.gz'||X
echo -ne '\r[█████▉··········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B2_15_2025_08_18/"{,"20250905_2506570988/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/B2_15_2025_08_18_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B2_15_2025_08_18/20250905_2506570988/raw_data/B2_15_2025_08_18_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/B2_15_2025_08_18_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B2_15_2025_08_18/20250905_2506570988/raw_data/B2_15_2025_08_18_R2.fastq.gz'||X
echo -ne '\r[██████▏·········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B3_17_2025_08_22/"{,"20250905_2506570988/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/B3_17_2025_08_22_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B3_17_2025_08_22/20250905_2506570988/raw_data/B3_17_2025_08_22_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/B3_17_2025_08_22_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B3_17_2025_08_22/20250905_2506570988/raw_data/B3_17_2025_08_22_R2.fastq.gz'||X
echo -ne '\r[██████▍·········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C1_10_2025_08_13/"{,"20250905_2506570988/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/C1_10_2025_08_13_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C1_10_2025_08_13/20250905_2506570988/raw_data/C1_10_2025_08_13_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/C1_10_2025_08_13_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C1_10_2025_08_13/20250905_2506570988/raw_data/C1_10_2025_08_13_R2.fastq.gz'||X
echo -ne '\r[██████▌·········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C2_16_2025_08_13/"{,"20250905_2506570988/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/C2_16_2025_08_13_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C2_16_2025_08_13/20250905_2506570988/raw_data/C2_16_2025_08_13_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/C2_16_2025_08_13_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C2_16_2025_08_13/20250905_2506570988/raw_data/C2_16_2025_08_13_R2.fastq.gz'||X
echo -ne '\r[██████▊·········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C3_25_2025_08_21/"{,"20250905_2506570988/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/C3_25_2025_08_21_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C3_25_2025_08_21/20250905_2506570988/raw_data/C3_25_2025_08_21_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/C3_25_2025_08_21_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C3_25_2025_08_21/20250905_2506570988/raw_data/C3_25_2025_08_21_R2.fastq.gz'||X
echo -ne '\r[███████·········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D1_10_2025_08_17/"{,"20250905_2506570988/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/D1_10_2025_08_17_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D1_10_2025_08_17/20250905_2506570988/raw_data/D1_10_2025_08_17_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/D1_10_2025_08_17_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D1_10_2025_08_17/20250905_2506570988/raw_data/D1_10_2025_08_17_R2.fastq.gz'||X
echo -ne '\r[███████▎········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D2_16_2025_08_18/"{,"20250905_2506570988/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/D2_16_2025_08_18_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D2_16_2025_08_18/20250905_2506570988/raw_data/D2_16_2025_08_18_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/D2_16_2025_08_18_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D2_16_2025_08_18/20250905_2506570988/raw_data/D2_16_2025_08_18_R2.fastq.gz'||X
echo -ne '\r[███████▍········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D3_25_2025_08_22/"{,"20250905_2506570988/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/D3_25_2025_08_22_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D3_25_2025_08_22/20250905_2506570988/raw_data/D3_25_2025_08_22_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/D3_25_2025_08_22_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D3_25_2025_08_22/20250905_2506570988/raw_data/D3_25_2025_08_22_R2.fastq.gz'||X
echo -ne '\r[███████▋········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E1_17_2025_08_13/"{,"20250905_2506570988/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/E1_17_2025_08_13_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E1_17_2025_08_13/20250905_2506570988/raw_data/E1_17_2025_08_13_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/E1_17_2025_08_13_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E1_17_2025_08_13/20250905_2506570988/raw_data/E1_17_2025_08_13_R2.fastq.gz'||X
echo -ne '\r[███████▉········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E2_05_2025_08_21/"{,"20250905_2506570988/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/E2_05_2025_08_21_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E2_05_2025_08_21/20250905_2506570988/raw_data/E2_05_2025_08_21_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/E2_05_2025_08_21_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E2_05_2025_08_21/20250905_2506570988/raw_data/E2_05_2025_08_21_R2.fastq.gz'||X
echo -ne '\r[████████········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E3_15_2025_08_19/"{,"20250905_2506570988/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/E3_15_2025_08_19_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E3_15_2025_08_19/20250905_2506570988/raw_data/E3_15_2025_08_19_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/E3_15_2025_08_19_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E3_15_2025_08_19/20250905_2506570988/raw_data/E3_15_2025_08_19_R2.fastq.gz'||X
echo -ne '\r[████████▎·······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F1_17_2025_08_17/"{,"20250905_2506570988/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/F1_17_2025_08_17_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F1_17_2025_08_17/20250905_2506570988/raw_data/F1_17_2025_08_17_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/F1_17_2025_08_17_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F1_17_2025_08_17/20250905_2506570988/raw_data/F1_17_2025_08_17_R2.fastq.gz'||X
echo -ne '\r[████████▌·······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F2_05_2025_08_22/"{,"20250905_2506570988/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/F2_05_2025_08_22_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F2_05_2025_08_22/20250905_2506570988/raw_data/F2_05_2025_08_22_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/F2_05_2025_08_22_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F2_05_2025_08_22/20250905_2506570988/raw_data/F2_05_2025_08_22_R2.fastq.gz'||X
echo -ne '\r[████████▋·······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F3_15_2025_08_22/"{,"20250905_2506570988/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/F3_15_2025_08_22_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F3_15_2025_08_22/20250905_2506570988/raw_data/F3_15_2025_08_22_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/F3_15_2025_08_22_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F3_15_2025_08_22/20250905_2506570988/raw_data/F3_15_2025_08_22_R2.fastq.gz'||X
echo -ne '\r[████████▉·······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G1_25_2025_08_13/"{,"20250905_2506570988/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/G1_25_2025_08_13_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G1_25_2025_08_13/20250905_2506570988/raw_data/G1_25_2025_08_13_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/G1_25_2025_08_13_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G1_25_2025_08_13/20250905_2506570988/raw_data/G1_25_2025_08_13_R2.fastq.gz'||X
echo -ne '\r[█████████▏······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G2_10_2025_08_21/"{,"20250905_2506570988/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/G2_10_2025_08_21_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G2_10_2025_08_21/20250905_2506570988/raw_data/G2_10_2025_08_21_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/G2_10_2025_08_21_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G2_10_2025_08_21/20250905_2506570988/raw_data/G2_10_2025_08_21_R2.fastq.gz'||X
echo -ne '\r[█████████▍······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G3_16_2025_08_21/"{,"20250905_2506570988/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/G3_16_2025_08_21_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G3_16_2025_08_21/20250905_2506570988/raw_data/G3_16_2025_08_21_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/G3_16_2025_08_21_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G3_16_2025_08_21/20250905_2506570988/raw_data/G3_16_2025_08_21_R2.fastq.gz'||X
echo -ne '\r[█████████▌······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H1_25_2025_08_17/"{,"20250905_2506570988/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/H1_25_2025_08_17_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H1_25_2025_08_17/20250905_2506570988/raw_data/H1_25_2025_08_17_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/H1_25_2025_08_17_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H1_25_2025_08_17/20250905_2506570988/raw_data/H1_25_2025_08_17_R2.fastq.gz'||X
echo -ne '\r[█████████▊······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H2_10_2025_08_22/"{,"20250905_2506570988/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/H2_10_2025_08_22_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H2_10_2025_08_22/20250905_2506570988/raw_data/H2_10_2025_08_22_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/H2_10_2025_08_22_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H2_10_2025_08_22/20250905_2506570988/raw_data/H2_10_2025_08_22_R2.fastq.gz'||X
echo -ne '\r[██████████······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H3_16_2025_08_23/"{,"20250905_2506570988/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/H3_16_2025_08_23_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H3_16_2025_08_23/20250905_2506570988/raw_data/H3_16_2025_08_23_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39684_Aviti_250905_AV115/H3_16_2025_08_23_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H3_16_2025_08_23/20250905_2506570988/raw_data/H3_16_2025_08_23_R2.fastq.gz'||X
[[ -d '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117' ]] || fail 'Not a directory:' '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117'
echo -ne '\r[██████████▏·····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A1_05_2025_08_25/"{,"20250919_2443587133/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/A1_05_2025_08_25_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A1_05_2025_08_25/20250919_2443587133/raw_data/A1_05_2025_08_25_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/A1_05_2025_08_25_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A1_05_2025_08_25/20250919_2443587133/raw_data/A1_05_2025_08_25_R2.fastq.gz'||X
echo -ne '\r[██████████▍·····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A2_15_2025_08_27/"{,"20250919_2443587133/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/A2_15_2025_08_27_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A2_15_2025_08_27/20250919_2443587133/raw_data/A2_15_2025_08_27_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/A2_15_2025_08_27_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A2_15_2025_08_27/20250919_2443587133/raw_data/A2_15_2025_08_27_R2.fastq.gz'||X
echo -ne '\r[██████████▋·····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A3_17_2025_09_02/"{,"20250919_2443587133/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/A3_17_2025_09_02_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A3_17_2025_09_02/20250919_2443587133/raw_data/A3_17_2025_09_02_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/A3_17_2025_09_02_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A3_17_2025_09_02/20250919_2443587133/raw_data/A3_17_2025_09_02_R2.fastq.gz'||X
echo -ne '\r[██████████▉·····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B1_05_2025_08_30/"{,"20250919_2443587133/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/B1_05_2025_09_30_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B1_05_2025_08_30/20250919_2443587133/raw_data/B1_05_2025_09_30_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/B1_05_2025_09_30_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B1_05_2025_08_30/20250919_2443587133/raw_data/B1_05_2025_09_30_R2.fastq.gz'||X
echo -ne '\r[███████████·····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B2_15_2025_08_31/"{,"20250919_2443587133/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/B2_15_2025_09_31_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B2_15_2025_08_31/20250919_2443587133/raw_data/B2_15_2025_09_31_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/B2_15_2025_09_31_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B2_15_2025_08_31/20250919_2443587133/raw_data/B2_15_2025_09_31_R2.fastq.gz'||X
echo -ne '\r[███████████▎····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B3_17_2025_09_07/"{,"20250919_2443587133/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/B3_17_2025_09_07_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B3_17_2025_09_07/20250919_2443587133/raw_data/B3_17_2025_09_07_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/B3_17_2025_09_07_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B3_17_2025_09_07/20250919_2443587133/raw_data/B3_17_2025_09_07_R2.fastq.gz'||X
echo -ne '\r[███████████▌····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C1_10_2025_08_25/"{,"20250919_2443587133/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/C1_10_2025_08_25_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C1_10_2025_08_25/20250919_2443587133/raw_data/C1_10_2025_08_25_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/C1_10_2025_08_25_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C1_10_2025_08_25/20250919_2443587133/raw_data/C1_10_2025_08_25_R2.fastq.gz'||X
echo -ne '\r[███████████▋····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C2_16_2025_08_29/"{,"20250919_2443587133/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/C2_16_2025_09_29_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C2_16_2025_08_29/20250919_2443587133/raw_data/C2_16_2025_09_29_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/C2_16_2025_09_29_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C2_16_2025_08_29/20250919_2443587133/raw_data/C2_16_2025_09_29_R2.fastq.gz'||X
echo -ne '\r[███████████▉····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C3_25_2025_09_02/"{,"20250919_2443587133/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/C3_25_2025_09_02_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C3_25_2025_09_02/20250919_2443587133/raw_data/C3_25_2025_09_02_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/C3_25_2025_09_02_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C3_25_2025_09_02/20250919_2443587133/raw_data/C3_25_2025_09_02_R2.fastq.gz'||X
echo -ne '\r[████████████▏···]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D1_10_2025_08_30/"{,"20250919_2443587133/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/D1_10_2025_09_30_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D1_10_2025_08_30/20250919_2443587133/raw_data/D1_10_2025_09_30_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/D1_10_2025_09_30_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D1_10_2025_08_30/20250919_2443587133/raw_data/D1_10_2025_09_30_R2.fastq.gz'||X
echo -ne '\r[████████████▎···]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D2_16_2025_08_31/"{,"20250919_2443587133/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/D2_16_2025_09_31_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D2_16_2025_08_31/20250919_2443587133/raw_data/D2_16_2025_09_31_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/D2_16_2025_09_31_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D2_16_2025_08_31/20250919_2443587133/raw_data/D2_16_2025_09_31_R2.fastq.gz'||X
echo -ne '\r[████████████▌···]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D3_25_2025_09_07/"{,"20250919_2443587133/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/D3_25_2025_09_07_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D3_25_2025_09_07/20250919_2443587133/raw_data/D3_25_2025_09_07_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/D3_25_2025_09_07_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D3_25_2025_09_07/20250919_2443587133/raw_data/D3_25_2025_09_07_R2.fastq.gz'||X
echo -ne '\r[████████████▊···]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E1_17_2025_08_25/"{,"20250919_2443587133/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/E1_17_2025_08_25_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E1_17_2025_08_25/20250919_2443587133/raw_data/E1_17_2025_08_25_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/E1_17_2025_08_25_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E1_17_2025_08_25/20250919_2443587133/raw_data/E1_17_2025_08_25_R2.fastq.gz'||X
echo -ne '\r[█████████████···]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E2_05_2025_09_02/"{,"20250919_2443587133/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/E2_05_2025_09_02_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E2_05_2025_09_02/20250919_2443587133/raw_data/E2_05_2025_09_02_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/E2_05_2025_09_02_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E2_05_2025_09_02/20250919_2443587133/raw_data/E2_05_2025_09_02_R2.fastq.gz'||X
echo -ne '\r[█████████████▏··]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E3_15_2025_09_04/"{,"20250919_2443587133/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/E3_15_2025_09_04_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E3_15_2025_09_04/20250919_2443587133/raw_data/E3_15_2025_09_04_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/E3_15_2025_09_04_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E3_15_2025_09_04/20250919_2443587133/raw_data/E3_15_2025_09_04_R2.fastq.gz'||X
echo -ne '\r[█████████████▍··]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F1_17_2025_08_30/"{,"20250919_2443587133/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/F1_17_2025_09_30_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F1_17_2025_08_30/20250919_2443587133/raw_data/F1_17_2025_09_30_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/F1_17_2025_09_30_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F1_17_2025_08_30/20250919_2443587133/raw_data/F1_17_2025_09_30_R2.fastq.gz'||X
echo -ne '\r[█████████████▋··]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F2_05_2025_09_07/"{,"20250919_2443587133/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/F2_05_2025_09_07_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F2_05_2025_09_07/20250919_2443587133/raw_data/F2_05_2025_09_07_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/F2_05_2025_09_07_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F2_05_2025_09_07/20250919_2443587133/raw_data/F2_05_2025_09_07_R2.fastq.gz'||X
echo -ne '\r[█████████████▊··]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F3_15_2025_09_08/"{,"20250919_2443587133/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/F3_15_2025_09_08_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F3_15_2025_09_08/20250919_2443587133/raw_data/F3_15_2025_09_08_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/F3_15_2025_09_08_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F3_15_2025_09_08/20250919_2443587133/raw_data/F3_15_2025_09_08_R2.fastq.gz'||X
echo -ne '\r[██████████████··]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G1_25_2025_08_25/"{,"20250919_2443587133/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/G1_25_2025_08_25_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G1_25_2025_08_25/20250919_2443587133/raw_data/G1_25_2025_08_25_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/G1_25_2025_08_25_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G1_25_2025_08_25/20250919_2443587133/raw_data/G1_25_2025_08_25_R2.fastq.gz'||X
echo -ne '\r[██████████████▎·]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G2_10_2025_09_02/"{,"20250919_2443587133/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/G2_10_2025_09_02_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G2_10_2025_09_02/20250919_2443587133/raw_data/G2_10_2025_09_02_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/G2_10_2025_09_02_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G2_10_2025_09_02/20250919_2443587133/raw_data/G2_10_2025_09_02_R2.fastq.gz'||X
echo -ne '\r[██████████████▌·]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G3_16_2025_09_02/"{,"20250919_2443587133/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/G3_16_2025_09_02_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G3_16_2025_09_02/20250919_2443587133/raw_data/G3_16_2025_09_02_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/G3_16_2025_09_02_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G3_16_2025_09_02/20250919_2443587133/raw_data/G3_16_2025_09_02_R2.fastq.gz'||X
echo -ne '\r[██████████████▋·]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H1_25_2025_08_30/"{,"20250919_2443587133/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/H1_25_2025_09_30_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H1_25_2025_08_30/20250919_2443587133/raw_data/H1_25_2025_09_30_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/H1_25_2025_09_30_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H1_25_2025_08_30/20250919_2443587133/raw_data/H1_25_2025_09_30_R2.fastq.gz'||X
echo -ne '\r[██████████████▉·]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H2_10_2025_09_07/"{,"20250919_2443587133/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/H2_10_2025_09_07_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H2_10_2025_09_07/20250919_2443587133/raw_data/H2_10_2025_09_07_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/H2_10_2025_09_07_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H2_10_2025_09_07/20250919_2443587133/raw_data/H2_10_2025_09_07_R2.fastq.gz'||X
echo -ne '\r[███████████████▏]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H3_16_2025_09_08/"{,"20250919_2443587133/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/H3_16_2025_09_08_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H3_16_2025_09_08/20250919_2443587133/raw_data/H3_16_2025_09_08_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o39798_Aviti_250919_AV117/H3_16_2025_09_08_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H3_16_2025_09_08/20250919_2443587133/raw_data/H3_16_2025_09_08_R2.fastq.gz'||X

echo -e '\r\e[K[████████████████] done.'
if (( !ALLOK )); then
		echo Some errors
		exit 1
fi;


mv -v /cluster/project/pangolin/processes/sars_cov_2/vpipe_input/samples.20250822_2506652341.tsv.staging /cluster/project/pangolin/processes/sars_cov_2/vpipe_input/samples.20250822_2506652341.tsv
mv -v /cluster/project/pangolin/processes/sars_cov_2/vpipe_input/samples.20250905_2506570988.tsv.staging /cluster/project/pangolin/processes/sars_cov_2/vpipe_input/samples.20250905_2506570988.tsv
mv -v /cluster/project/pangolin/processes/sars_cov_2/vpipe_input/samples.20250919_2443587133.tsv.staging /cluster/project/pangolin/processes/sars_cov_2/vpipe_input/samples.20250919_2443587133.tsv

echo All Ok
exit 0

