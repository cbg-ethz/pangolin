
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

[[ -d '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192' ]] || fail 'Not a directory:' '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192'
echo -ne '\r[················]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A1_05_2026_09_09/"{,"20261002_2538645270/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/A1_05_2026_09_09_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A1_05_2026_09_09/20261002_2538645270/raw_data/A1_05_2026_09_09_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/A1_05_2026_09_09_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A1_05_2026_09_09/20261002_2538645270/raw_data/A1_05_2026_09_09_R2.fastq.gz'||X
echo -ne '\r[▏···············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A2_15_2026_09_09/"{,"20261002_2538645270/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/A2_15_2026_09_09_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A2_15_2026_09_09/20261002_2538645270/raw_data/A2_15_2026_09_09_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/A2_15_2026_09_09_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A2_15_2026_09_09/20261002_2538645270/raw_data/A2_15_2026_09_09_R2.fastq.gz'||X
echo -ne '\r[▎···············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A3_17_2026_09_17/"{,"20261002_2538645270/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/A3_17_2026_09_17_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A3_17_2026_09_17/20261002_2538645270/raw_data/A3_17_2026_09_17_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/A3_17_2026_09_17_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A3_17_2026_09_17/20261002_2538645270/raw_data/A3_17_2026_09_17_R2.fastq.gz'||X
echo -ne '\r[▍···············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B1_05_2026_09_12/"{,"20261002_2538645270/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/B1_05_2026_09_12_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B1_05_2026_09_12/20261002_2538645270/raw_data/B1_05_2026_09_12_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/B1_05_2026_09_12_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B1_05_2026_09_12/20261002_2538645270/raw_data/B1_05_2026_09_12_R2.fastq.gz'||X
echo -ne '\r[▋···············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B2_15_2026_09_13/"{,"20261002_2538645270/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/B2_15_2026_09_13_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B2_15_2026_09_13/20261002_2538645270/raw_data/B2_15_2026_09_13_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/B2_15_2026_09_13_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B2_15_2026_09_13/20261002_2538645270/raw_data/B2_15_2026_09_13_R2.fastq.gz'||X
echo -ne '\r[▊···············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B3_17_2026_09_20/"{,"20261002_2538645270/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/B3_17_2026_09_20_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B3_17_2026_09_20/20261002_2538645270/raw_data/B3_17_2026_09_20_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/B3_17_2026_09_20_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B3_17_2026_09_20/20261002_2538645270/raw_data/B3_17_2026_09_20_R2.fastq.gz'||X
echo -ne '\r[▉···············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C1_10_2026_09_09/"{,"20261002_2538645270/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/C1_10_2026_09_09_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C1_10_2026_09_09/20261002_2538645270/raw_data/C1_10_2026_09_09_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/C1_10_2026_09_09_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C1_10_2026_09_09/20261002_2538645270/raw_data/C1_10_2026_09_09_R2.fastq.gz'||X
echo -ne '\r[█▏··············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C2_16_2026_09_09/"{,"20261002_2538645270/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/C2_16_2026_09_09_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C2_16_2026_09_09/20261002_2538645270/raw_data/C2_16_2026_09_09_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/C2_16_2026_09_09_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C2_16_2026_09_09/20261002_2538645270/raw_data/C2_16_2026_09_09_R2.fastq.gz'||X
echo -ne '\r[█▎··············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C3_25_2026_09_17/"{,"20261002_2538645270/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/C3_25_2026_09_17_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C3_25_2026_09_17/20261002_2538645270/raw_data/C3_25_2026_09_17_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/C3_25_2026_09_17_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C3_25_2026_09_17/20261002_2538645270/raw_data/C3_25_2026_09_17_R2.fastq.gz'||X
echo -ne '\r[█▍··············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D1_10_2026_09_12/"{,"20261002_2538645270/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/D1_10_2026_09_12_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D1_10_2026_09_12/20261002_2538645270/raw_data/D1_10_2026_09_12_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/D1_10_2026_09_12_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D1_10_2026_09_12/20261002_2538645270/raw_data/D1_10_2026_09_12_R2.fastq.gz'||X
echo -ne '\r[█▌··············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D2_16_2026_09_13/"{,"20261002_2538645270/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/D2_16_2026_09_13_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D2_16_2026_09_13/20261002_2538645270/raw_data/D2_16_2026_09_13_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/D2_16_2026_09_13_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D2_16_2026_09_13/20261002_2538645270/raw_data/D2_16_2026_09_13_R2.fastq.gz'||X
echo -ne '\r[█▊··············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D3_25_2026_09_20/"{,"20261002_2538645270/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/D3_25_2026_09_20_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D3_25_2026_09_20/20261002_2538645270/raw_data/D3_25_2026_09_20_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/D3_25_2026_09_20_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D3_25_2026_09_20/20261002_2538645270/raw_data/D3_25_2026_09_20_R2.fastq.gz'||X
echo -ne '\r[█▉··············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E1_17_2026_09_09/"{,"20261002_2538645270/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/E1_17_2026_09_09_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E1_17_2026_09_09/20261002_2538645270/raw_data/E1_17_2026_09_09_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/E1_17_2026_09_09_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E1_17_2026_09_09/20261002_2538645270/raw_data/E1_17_2026_09_09_R2.fastq.gz'||X
echo -ne '\r[██··············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E2_05_2026_09_17/"{,"20261002_2538645270/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/E2_05_2026_09_17_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E2_05_2026_09_17/20261002_2538645270/raw_data/E2_05_2026_09_17_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/E2_05_2026_09_17_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E2_05_2026_09_17/20261002_2538645270/raw_data/E2_05_2026_09_17_R2.fastq.gz'||X
echo -ne '\r[██▎·············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E3_15_2026_09_17/"{,"20261002_2538645270/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/E3_15_2026_09_17_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E3_15_2026_09_17/20261002_2538645270/raw_data/E3_15_2026_09_17_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/E3_15_2026_09_17_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E3_15_2026_09_17/20261002_2538645270/raw_data/E3_15_2026_09_17_R2.fastq.gz'||X
echo -ne '\r[██▍·············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F1_17_2026_09_12/"{,"20261002_2538645270/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/F1_17_2026_09_12_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F1_17_2026_09_12/20261002_2538645270/raw_data/F1_17_2026_09_12_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/F1_17_2026_09_12_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F1_17_2026_09_12/20261002_2538645270/raw_data/F1_17_2026_09_12_R2.fastq.gz'||X
echo -ne '\r[██▌·············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F2_05_2026_09_20/"{,"20261002_2538645270/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/F2_05_2026_09_20_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F2_05_2026_09_20/20261002_2538645270/raw_data/F2_05_2026_09_20_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/F2_05_2026_09_20_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F2_05_2026_09_20/20261002_2538645270/raw_data/F2_05_2026_09_20_R2.fastq.gz'||X
echo -ne '\r[██▋·············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F3_15_2026_09_21/"{,"20261002_2538645270/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/F3_15_2026_09_21_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F3_15_2026_09_21/20261002_2538645270/raw_data/F3_15_2026_09_21_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/F3_15_2026_09_21_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F3_15_2026_09_21/20261002_2538645270/raw_data/F3_15_2026_09_21_R2.fastq.gz'||X
echo -ne '\r[██▉·············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G1_25_2026_09_09/"{,"20261002_2538645270/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/G1_25_2026_09_09_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G1_25_2026_09_09/20261002_2538645270/raw_data/G1_25_2026_09_09_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/G1_25_2026_09_09_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G1_25_2026_09_09/20261002_2538645270/raw_data/G1_25_2026_09_09_R2.fastq.gz'||X
echo -ne '\r[███·············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G2_10_2026_09_17/"{,"20261002_2538645270/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/G2_10_2026_09_17_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G2_10_2026_09_17/20261002_2538645270/raw_data/G2_10_2026_09_17_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/G2_10_2026_09_17_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G2_10_2026_09_17/20261002_2538645270/raw_data/G2_10_2026_09_17_R2.fastq.gz'||X
echo -ne '\r[███▏············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G3_16_2026_09_17/"{,"20261002_2538645270/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/G3_16_2026_09_17_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G3_16_2026_09_17/20261002_2538645270/raw_data/G3_16_2026_09_17_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/G3_16_2026_09_17_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G3_16_2026_09_17/20261002_2538645270/raw_data/G3_16_2026_09_17_R2.fastq.gz'||X
echo -ne '\r[███▍············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H1_25_2026_09_12/"{,"20261002_2538645270/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/H1_25_2026_09_12_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H1_25_2026_09_12/20261002_2538645270/raw_data/H1_25_2026_09_12_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/H1_25_2026_09_12_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H1_25_2026_09_12/20261002_2538645270/raw_data/H1_25_2026_09_12_R2.fastq.gz'||X
echo -ne '\r[███▌············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H2_10_2026_09_20/"{,"20261002_2538645270/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/H2_10_2026_09_20_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H2_10_2026_09_20/20261002_2538645270/raw_data/H2_10_2026_09_20_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/H2_10_2026_09_20_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H2_10_2026_09_20/20261002_2538645270/raw_data/H2_10_2026_09_20_R2.fastq.gz'||X
echo -ne '\r[███▋············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H3_16_2026_09_21/"{,"20261002_2538645270/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/H3_16_2026_09_21_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H3_16_2026_09_21/20261002_2538645270/raw_data/H3_16_2026_09_21_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43421_Aviti_261002_AV192/H3_16_2026_09_21_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H3_16_2026_09_21/20261002_2538645270/raw_data/H3_16_2026_09_21_R2.fastq.gz'||X
[[ -d '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194' ]] || fail 'Not a directory:' '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194'
echo -ne '\r[███▉············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A1_05_2026_09_21/"{,"20261016_2607456428/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/A1_05_2026_09_21_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A1_05_2026_09_21/20261016_2607456428/raw_data/A1_05_2026_09_21_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/A1_05_2026_09_21_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A1_05_2026_09_21/20261016_2607456428/raw_data/A1_05_2026_09_21_R2.fastq.gz'||X
echo -ne '\r[████············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A2_15_2026_09_22/"{,"20261016_2607456428/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/A2_15_2026_09_22_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A2_15_2026_09_22/20261016_2607456428/raw_data/A2_15_2026_09_22_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/A2_15_2026_09_22_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A2_15_2026_09_22/20261016_2607456428/raw_data/A2_15_2026_09_22_R2.fastq.gz'||X
echo -ne '\r[████▏···········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A3_17_2026_09_29/"{,"20261016_2607456428/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/A3_17_2026_09_29_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A3_17_2026_09_29/20261016_2607456428/raw_data/A3_17_2026_09_29_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/A3_17_2026_09_29_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A3_17_2026_09_29/20261016_2607456428/raw_data/A3_17_2026_09_29_R2.fastq.gz'||X
echo -ne '\r[████▎···········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B1_05_2026_09_25/"{,"20261016_2607456428/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/B1_05_2026_09_25_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B1_05_2026_09_25/20261016_2607456428/raw_data/B1_05_2026_09_25_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/B1_05_2026_09_25_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B1_05_2026_09_25/20261016_2607456428/raw_data/B1_05_2026_09_25_R2.fastq.gz'||X
echo -ne '\r[████▌···········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B2_15_2026_09_25/"{,"20261016_2607456428/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/B2_15_2026_09_25_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B2_15_2026_09_25/20261016_2607456428/raw_data/B2_15_2026_09_25_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/B2_15_2026_09_25_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B2_15_2026_09_25/20261016_2607456428/raw_data/B2_15_2026_09_25_R2.fastq.gz'||X
echo -ne '\r[████▋···········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B3_17_2026_10_03/"{,"20261016_2607456428/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/B3_17_2026_10_03_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B3_17_2026_10_03/20261016_2607456428/raw_data/B3_17_2026_10_03_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/B3_17_2026_10_03_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B3_17_2026_10_03/20261016_2607456428/raw_data/B3_17_2026_10_03_R2.fastq.gz'||X
echo -ne '\r[████▊···········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C1_10_2026_09_21/"{,"20261016_2607456428/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/C1_10_2026_09_21_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C1_10_2026_09_21/20261016_2607456428/raw_data/C1_10_2026_09_21_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/C1_10_2026_09_21_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C1_10_2026_09_21/20261016_2607456428/raw_data/C1_10_2026_09_21_R2.fastq.gz'||X
echo -ne '\r[█████···········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C2_16_2026_09_25/"{,"20261016_2607456428/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/C2_16_2026_09_25_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C2_16_2026_09_25/20261016_2607456428/raw_data/C2_16_2026_09_25_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/C2_16_2026_09_25_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C2_16_2026_09_25/20261016_2607456428/raw_data/C2_16_2026_09_25_R2.fastq.gz'||X
echo -ne '\r[█████▏··········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C3_25_2026_09_29/"{,"20261016_2607456428/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/C3_25_2026_09_29_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C3_25_2026_09_29/20261016_2607456428/raw_data/C3_25_2026_09_29_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/C3_25_2026_09_29_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C3_25_2026_09_29/20261016_2607456428/raw_data/C3_25_2026_09_29_R2.fastq.gz'||X
echo -ne '\r[█████▎··········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D1_10_2026_09_25/"{,"20261016_2607456428/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/D1_10_2026_09_25_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D1_10_2026_09_25/20261016_2607456428/raw_data/D1_10_2026_09_25_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/D1_10_2026_09_25_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D1_10_2026_09_25/20261016_2607456428/raw_data/D1_10_2026_09_25_R2.fastq.gz'||X
echo -ne '\r[█████▍··········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D2_16_2026_09_26/"{,"20261016_2607456428/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/D2_16_2026_09_26_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D2_16_2026_09_26/20261016_2607456428/raw_data/D2_16_2026_09_26_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/D2_16_2026_09_26_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D2_16_2026_09_26/20261016_2607456428/raw_data/D2_16_2026_09_26_R2.fastq.gz'||X
echo -ne '\r[█████▋··········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D3_25_2026_10_03/"{,"20261016_2607456428/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/D3_25_2026_10_03_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D3_25_2026_10_03/20261016_2607456428/raw_data/D3_25_2026_10_03_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/D3_25_2026_10_03_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D3_25_2026_10_03/20261016_2607456428/raw_data/D3_25_2026_10_03_R2.fastq.gz'||X
echo -ne '\r[█████▊··········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E1_17_2026_09_21/"{,"20261016_2607456428/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/E1_17_2026_09_21_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E1_17_2026_09_21/20261016_2607456428/raw_data/E1_17_2026_09_21_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/E1_17_2026_09_21_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E1_17_2026_09_21/20261016_2607456428/raw_data/E1_17_2026_09_21_R2.fastq.gz'||X
echo -ne '\r[█████▉··········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E2_05_2026_09_29/"{,"20261016_2607456428/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/E2_05_2026_09_29_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E2_05_2026_09_29/20261016_2607456428/raw_data/E2_05_2026_09_29_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/E2_05_2026_09_29_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E2_05_2026_09_29/20261016_2607456428/raw_data/E2_05_2026_09_29_R2.fastq.gz'||X
echo -ne '\r[██████▏·········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E3_15_2026_09_30/"{,"20261016_2607456428/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/E3_15_2026_09_30_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E3_15_2026_09_30/20261016_2607456428/raw_data/E3_15_2026_09_30_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/E3_15_2026_09_30_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E3_15_2026_09_30/20261016_2607456428/raw_data/E3_15_2026_09_30_R2.fastq.gz'||X
echo -ne '\r[██████▎·········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F1_17_2026_09_25/"{,"20261016_2607456428/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/F1_17_2026_09_25_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F1_17_2026_09_25/20261016_2607456428/raw_data/F1_17_2026_09_25_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/F1_17_2026_09_25_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F1_17_2026_09_25/20261016_2607456428/raw_data/F1_17_2026_09_25_R2.fastq.gz'||X
echo -ne '\r[██████▍·········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F2_05_2026_10_03/"{,"20261016_2607456428/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/F2_05_2026_10_03_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F2_05_2026_10_03/20261016_2607456428/raw_data/F2_05_2026_10_03_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/F2_05_2026_10_03_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F2_05_2026_10_03/20261016_2607456428/raw_data/F2_05_2026_10_03_R2.fastq.gz'||X
echo -ne '\r[██████▋·········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F3_15_2026_10_04/"{,"20261016_2607456428/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/F3_15_2026_10_04_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F3_15_2026_10_04/20261016_2607456428/raw_data/F3_15_2026_10_04_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/F3_15_2026_10_04_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F3_15_2026_10_04/20261016_2607456428/raw_data/F3_15_2026_10_04_R2.fastq.gz'||X
echo -ne '\r[██████▊·········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G1_25_2026_09_21/"{,"20261016_2607456428/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/G1_25_2026_09_21_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G1_25_2026_09_21/20261016_2607456428/raw_data/G1_25_2026_09_21_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/G1_25_2026_09_21_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G1_25_2026_09_21/20261016_2607456428/raw_data/G1_25_2026_09_21_R2.fastq.gz'||X
echo -ne '\r[██████▉·········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G2_10_2026_09_29/"{,"20261016_2607456428/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/G2_10_2026_09_29_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G2_10_2026_09_29/20261016_2607456428/raw_data/G2_10_2026_09_29_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/G2_10_2026_09_29_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G2_10_2026_09_29/20261016_2607456428/raw_data/G2_10_2026_09_29_R2.fastq.gz'||X
echo -ne '\r[███████·········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G3_16_2026_09_29/"{,"20261016_2607456428/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/G3_16_2026_09_29_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G3_16_2026_09_29/20261016_2607456428/raw_data/G3_16_2026_09_29_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/G3_16_2026_09_29_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G3_16_2026_09_29/20261016_2607456428/raw_data/G3_16_2026_09_29_R2.fastq.gz'||X
echo -ne '\r[███████▎········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H1_25_2026_09_25/"{,"20261016_2607456428/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/H1_25_2026_09_25_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H1_25_2026_09_25/20261016_2607456428/raw_data/H1_25_2026_09_25_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/H1_25_2026_09_25_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H1_25_2026_09_25/20261016_2607456428/raw_data/H1_25_2026_09_25_R2.fastq.gz'||X
echo -ne '\r[███████▍········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H2_10_2026_10_03/"{,"20261016_2607456428/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/H2_10_2026_10_03_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H2_10_2026_10_03/20261016_2607456428/raw_data/H2_10_2026_10_03_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/H2_10_2026_10_03_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H2_10_2026_10_03/20261016_2607456428/raw_data/H2_10_2026_10_03_R2.fastq.gz'||X
echo -ne '\r[███████▌········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H3_16_2026_10_04/"{,"20261016_2607456428/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/H3_16_2026_10_04_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H3_16_2026_10_04/20261016_2607456428/raw_data/H3_16_2026_10_04_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43541_Aviti_261016_AV194/H3_16_2026_10_04_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H3_16_2026_10_04/20261016_2607456428/raw_data/H3_16_2026_10_04_R2.fastq.gz'||X
[[ -d '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195' ]] || fail 'Not a directory:' '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195'
echo -ne '\r[███████▊········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A1_05_2026_10_07/"{,"20261030_2546537150/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/A1_05_2026_10_07_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A1_05_2026_10_07/20261030_2546537150/raw_data/A1_05_2026_10_07_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/A1_05_2026_10_07_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A1_05_2026_10_07/20261030_2546537150/raw_data/A1_05_2026_10_07_R2.fastq.gz'||X
echo -ne '\r[███████▉········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A2_15_2026_10_08/"{,"20261030_2546537150/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/A2_15_2026_10_08_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A2_15_2026_10_08/20261030_2546537150/raw_data/A2_15_2026_10_08_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/A2_15_2026_10_08_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A2_15_2026_10_08/20261030_2546537150/raw_data/A2_15_2026_10_08_R2.fastq.gz'||X
echo -ne '\r[████████········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A3_17_2026_10_15/"{,"20261030_2546537150/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/A3_17_2026_10_15_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A3_17_2026_10_15/20261030_2546537150/raw_data/A3_17_2026_10_15_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/A3_17_2026_10_15_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A3_17_2026_10_15/20261030_2546537150/raw_data/A3_17_2026_10_15_R2.fastq.gz'||X
echo -ne '\r[████████▏·······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B1_05_2026_10_11/"{,"20261030_2546537150/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/B1_05_2026_10_11_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B1_05_2026_10_11/20261030_2546537150/raw_data/B1_05_2026_10_11_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/B1_05_2026_10_11_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B1_05_2026_10_11/20261030_2546537150/raw_data/B1_05_2026_10_11_R2.fastq.gz'||X
echo -ne '\r[████████▍·······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B2_15_2026_10_12/"{,"20261030_2546537150/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/B2_15_2026_10_12_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B2_15_2026_10_12/20261030_2546537150/raw_data/B2_15_2026_10_12_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/B2_15_2026_10_12_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B2_15_2026_10_12/20261030_2546537150/raw_data/B2_15_2026_10_12_R2.fastq.gz'||X
echo -ne '\r[████████▌·······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B3_17_2026_10_16/"{,"20261030_2546537150/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/B3_17_2026_10_16_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B3_17_2026_10_16/20261030_2546537150/raw_data/B3_17_2026_10_16_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/B3_17_2026_10_16_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B3_17_2026_10_16/20261030_2546537150/raw_data/B3_17_2026_10_16_R2.fastq.gz'||X
echo -ne '\r[████████▋·······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C1_10_2026_10_07/"{,"20261030_2546537150/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/C1_10_2026_10_07_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C1_10_2026_10_07/20261030_2546537150/raw_data/C1_10_2026_10_07_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/C1_10_2026_10_07_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C1_10_2026_10_07/20261030_2546537150/raw_data/C1_10_2026_10_07_R2.fastq.gz'||X
echo -ne '\r[████████▉·······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C2_16_2026_10_07/"{,"20261030_2546537150/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/C2_16_2026_10_07_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C2_16_2026_10_07/20261030_2546537150/raw_data/C2_16_2026_10_07_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/C2_16_2026_10_07_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C2_16_2026_10_07/20261030_2546537150/raw_data/C2_16_2026_10_07_R2.fastq.gz'||X
echo -ne '\r[█████████·······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C3_25_2026_10_15/"{,"20261030_2546537150/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/C3_25_2026_10_15_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C3_25_2026_10_15/20261030_2546537150/raw_data/C3_25_2026_10_15_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/C3_25_2026_10_15_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C3_25_2026_10_15/20261030_2546537150/raw_data/C3_25_2026_10_15_R2.fastq.gz'||X
echo -ne '\r[█████████▏······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D1_10_2026_10_11/"{,"20261030_2546537150/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/D1_10_2026_10_11_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D1_10_2026_10_11/20261030_2546537150/raw_data/D1_10_2026_10_11_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/D1_10_2026_10_11_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D1_10_2026_10_11/20261030_2546537150/raw_data/D1_10_2026_10_11_R2.fastq.gz'||X
echo -ne '\r[█████████▎······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D2_16_2026_10_12/"{,"20261030_2546537150/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/D2_16_2026_10_12_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D2_16_2026_10_12/20261030_2546537150/raw_data/D2_16_2026_10_12_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/D2_16_2026_10_12_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D2_16_2026_10_12/20261030_2546537150/raw_data/D2_16_2026_10_12_R2.fastq.gz'||X
echo -ne '\r[█████████▌······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D3_25_2026_10_16/"{,"20261030_2546537150/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/D3_25_2026_10_16_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D3_25_2026_10_16/20261030_2546537150/raw_data/D3_25_2026_10_16_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/D3_25_2026_10_16_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D3_25_2026_10_16/20261030_2546537150/raw_data/D3_25_2026_10_16_R2.fastq.gz'||X
echo -ne '\r[█████████▋······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E1_17_2026_10_07/"{,"20261030_2546537150/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/E1_17_2026_10_07_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E1_17_2026_10_07/20261030_2546537150/raw_data/E1_17_2026_10_07_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/E1_17_2026_10_07_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E1_17_2026_10_07/20261030_2546537150/raw_data/E1_17_2026_10_07_R2.fastq.gz'||X
echo -ne '\r[█████████▊······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E2_05_2026_10_15/"{,"20261030_2546537150/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/E2_05_2026_10_15_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E2_05_2026_10_15/20261030_2546537150/raw_data/E2_05_2026_10_15_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/E2_05_2026_10_15_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E2_05_2026_10_15/20261030_2546537150/raw_data/E2_05_2026_10_15_R2.fastq.gz'||X
echo -ne '\r[██████████······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E3_15_2026_10_13/"{,"20261030_2546537150/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/E3_15_2026_10_13_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E3_15_2026_10_13/20261030_2546537150/raw_data/E3_15_2026_10_13_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/E3_15_2026_10_13_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E3_15_2026_10_13/20261030_2546537150/raw_data/E3_15_2026_10_13_R2.fastq.gz'||X
echo -ne '\r[██████████▏·····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F1_17_2026_10_10/"{,"20261030_2546537150/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/F1_17_2026_10_10_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F1_17_2026_10_10/20261030_2546537150/raw_data/F1_17_2026_10_10_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/F1_17_2026_10_10_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F1_17_2026_10_10/20261030_2546537150/raw_data/F1_17_2026_10_10_R2.fastq.gz'||X
echo -ne '\r[██████████▎·····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F2_05_2026_10_16/"{,"20261030_2546537150/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/F2_05_2026_10_16_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F2_05_2026_10_16/20261030_2546537150/raw_data/F2_05_2026_10_16_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/F2_05_2026_10_16_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F2_05_2026_10_16/20261030_2546537150/raw_data/F2_05_2026_10_16_R2.fastq.gz'||X
echo -ne '\r[██████████▌·····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F3_15_2026_10_16/"{,"20261030_2546537150/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/F3_15_2026_10_16_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F3_15_2026_10_16/20261030_2546537150/raw_data/F3_15_2026_10_16_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/F3_15_2026_10_16_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F3_15_2026_10_16/20261030_2546537150/raw_data/F3_15_2026_10_16_R2.fastq.gz'||X
echo -ne '\r[██████████▋·····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G1_25_2026_10_07/"{,"20261030_2546537150/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/G1_25_2026_10_07_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G1_25_2026_10_07/20261030_2546537150/raw_data/G1_25_2026_10_07_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/G1_25_2026_10_07_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G1_25_2026_10_07/20261030_2546537150/raw_data/G1_25_2026_10_07_R2.fastq.gz'||X
echo -ne '\r[██████████▊·····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G2_10_2026_10_15/"{,"20261030_2546537150/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/G2_10_2026_10_15_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G2_10_2026_10_15/20261030_2546537150/raw_data/G2_10_2026_10_15_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/G2_10_2026_10_15_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G2_10_2026_10_15/20261030_2546537150/raw_data/G2_10_2026_10_15_R2.fastq.gz'||X
echo -ne '\r[██████████▉·····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G3_16_2026_10_15/"{,"20261030_2546537150/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/G3_16_2026_10_15_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G3_16_2026_10_15/20261030_2546537150/raw_data/G3_16_2026_10_15_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/G3_16_2026_10_15_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G3_16_2026_10_15/20261030_2546537150/raw_data/G3_16_2026_10_15_R2.fastq.gz'||X
echo -ne '\r[███████████▏····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H1_25_2026_10_10/"{,"20261030_2546537150/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/H1_25_2026_10_10_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H1_25_2026_10_10/20261030_2546537150/raw_data/H1_25_2026_10_10_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/H1_25_2026_10_10_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H1_25_2026_10_10/20261030_2546537150/raw_data/H1_25_2026_10_10_R2.fastq.gz'||X
echo -ne '\r[███████████▎····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H2_10_2026_10_16/"{,"20261030_2546537150/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/H2_10_2026_10_16_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H2_10_2026_10_16/20261030_2546537150/raw_data/H2_10_2026_10_16_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/H2_10_2026_10_16_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H2_10_2026_10_16/20261030_2546537150/raw_data/H2_10_2026_10_16_R2.fastq.gz'||X
echo -ne '\r[███████████▍····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H3_16_2026_10_17/"{,"20261030_2546537150/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/H3_16_2026_10_17_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H3_16_2026_10_17/20261030_2546537150/raw_data/H3_16_2026_10_17_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43668_Aviti_261030_AV195/H3_16_2026_10_17_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H3_16_2026_10_17/20261030_2546537150/raw_data/H3_16_2026_10_17_R2.fastq.gz'||X
[[ -d '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196' ]] || fail 'Not a directory:' '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196'
echo -ne '\r[███████████▋····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A1_05_2026_10_19/"{,"20261113_2546621999/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/A1_05_2026_10_19_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A1_05_2026_10_19/20261113_2546621999/raw_data/A1_05_2026_10_19_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/A1_05_2026_10_19_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A1_05_2026_10_19/20261113_2546621999/raw_data/A1_05_2026_10_19_R2.fastq.gz'||X
echo -ne '\r[███████████▊····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A2_15_2026_10_21/"{,"20261113_2546621999/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/A2_15_2026_10_21_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A2_15_2026_10_21/20261113_2546621999/raw_data/A2_15_2026_10_21_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/A2_15_2026_10_21_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A2_15_2026_10_21/20261113_2546621999/raw_data/A2_15_2026_10_21_R2.fastq.gz'||X
echo -ne '\r[███████████▉····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A3_17_2026_10_27/"{,"20261113_2546621999/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/A3_17_2026_10_27_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A3_17_2026_10_27/20261113_2546621999/raw_data/A3_17_2026_10_27_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/A3_17_2026_10_27_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A3_17_2026_10_27/20261113_2546621999/raw_data/A3_17_2026_10_27_R2.fastq.gz'||X
echo -ne '\r[████████████····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B1_05_2026_10_24/"{,"20261113_2546621999/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/B1_05_2026_10_24_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B1_05_2026_10_24/20261113_2546621999/raw_data/B1_05_2026_10_24_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/B1_05_2026_10_24_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B1_05_2026_10_24/20261113_2546621999/raw_data/B1_05_2026_10_24_R2.fastq.gz'||X
echo -ne '\r[████████████▎···]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B2_15_2026_10_25/"{,"20261113_2546621999/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/B2_15_2026_10_25_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B2_15_2026_10_25/20261113_2546621999/raw_data/B2_15_2026_10_25_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/B2_15_2026_10_25_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B2_15_2026_10_25/20261113_2546621999/raw_data/B2_15_2026_10_25_R2.fastq.gz'||X
echo -ne '\r[████████████▍···]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B3_17_2026_11_01/"{,"20261113_2546621999/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/B3_17_2026_11_01_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B3_17_2026_11_01/20261113_2546621999/raw_data/B3_17_2026_11_01_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/B3_17_2026_11_01_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B3_17_2026_11_01/20261113_2546621999/raw_data/B3_17_2026_11_01_R2.fastq.gz'||X
echo -ne '\r[████████████▌···]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C1_10_2026_10_19/"{,"20261113_2546621999/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/C1_10_2026_10_19_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C1_10_2026_10_19/20261113_2546621999/raw_data/C1_10_2026_10_19_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/C1_10_2026_10_19_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C1_10_2026_10_19/20261113_2546621999/raw_data/C1_10_2026_10_19_R2.fastq.gz'||X
echo -ne '\r[████████████▊···]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C2_16_2026_10_23/"{,"20261113_2546621999/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/C2_16_2026_10_23_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C2_16_2026_10_23/20261113_2546621999/raw_data/C2_16_2026_10_23_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/C2_16_2026_10_23_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C2_16_2026_10_23/20261113_2546621999/raw_data/C2_16_2026_10_23_R2.fastq.gz'||X
echo -ne '\r[████████████▉···]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C3_25_2026_10_27/"{,"20261113_2546621999/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/C3_25_2026_10_27_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C3_25_2026_10_27/20261113_2546621999/raw_data/C3_25_2026_10_27_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/C3_25_2026_10_27_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C3_25_2026_10_27/20261113_2546621999/raw_data/C3_25_2026_10_27_R2.fastq.gz'||X
echo -ne '\r[█████████████···]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D1_10_2026_10_24/"{,"20261113_2546621999/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/D1_10_2026_10_24_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D1_10_2026_10_24/20261113_2546621999/raw_data/D1_10_2026_10_24_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/D1_10_2026_10_24_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D1_10_2026_10_24/20261113_2546621999/raw_data/D1_10_2026_10_24_R2.fastq.gz'||X
echo -ne '\r[█████████████▎··]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D2_16_2026_10_26/"{,"20261113_2546621999/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/D2_16_2026_10_26_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D2_16_2026_10_26/20261113_2546621999/raw_data/D2_16_2026_10_26_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/D2_16_2026_10_26_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D2_16_2026_10_26/20261113_2546621999/raw_data/D2_16_2026_10_26_R2.fastq.gz'||X
echo -ne '\r[█████████████▍··]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D3_25_2026_11_01/"{,"20261113_2546621999/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/D3_25_2026_11_01_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D3_25_2026_11_01/20261113_2546621999/raw_data/D3_25_2026_11_01_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/D3_25_2026_11_01_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D3_25_2026_11_01/20261113_2546621999/raw_data/D3_25_2026_11_01_R2.fastq.gz'||X
echo -ne '\r[█████████████▌··]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E1_17_2026_10_19/"{,"20261113_2546621999/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/E1_17_2026_10_19_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E1_17_2026_10_19/20261113_2546621999/raw_data/E1_17_2026_10_19_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/E1_17_2026_10_19_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E1_17_2026_10_19/20261113_2546621999/raw_data/E1_17_2026_10_19_R2.fastq.gz'||X
echo -ne '\r[█████████████▋··]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E2_05_2026_10_27/"{,"20261113_2546621999/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/E2_05_2026_10_27_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E2_05_2026_10_27/20261113_2546621999/raw_data/E2_05_2026_10_27_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/E2_05_2026_10_27_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E2_05_2026_10_27/20261113_2546621999/raw_data/E2_05_2026_10_27_R2.fastq.gz'||X
echo -ne '\r[█████████████▉··]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E3_15_2026_10_29/"{,"20261113_2546621999/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/E3_15_2026_10_29_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E3_15_2026_10_29/20261113_2546621999/raw_data/E3_15_2026_10_29_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/E3_15_2026_10_29_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E3_15_2026_10_29/20261113_2546621999/raw_data/E3_15_2026_10_29_R2.fastq.gz'||X
echo -ne '\r[██████████████··]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F1_17_2026_10_24/"{,"20261113_2546621999/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/F1_17_2026_10_24_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F1_17_2026_10_24/20261113_2546621999/raw_data/F1_17_2026_10_24_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/F1_17_2026_10_24_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F1_17_2026_10_24/20261113_2546621999/raw_data/F1_17_2026_10_24_R2.fastq.gz'||X
echo -ne '\r[██████████████▏·]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F2_05_2026_11_01/"{,"20261113_2546621999/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/F2_05_2026_11_01_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F2_05_2026_11_01/20261113_2546621999/raw_data/F2_05_2026_11_01_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/F2_05_2026_11_01_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F2_05_2026_11_01/20261113_2546621999/raw_data/F2_05_2026_11_01_R2.fastq.gz'||X
echo -ne '\r[██████████████▍·]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F3_15_2026_11_02/"{,"20261113_2546621999/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/F3_15_2026_11_02_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F3_15_2026_11_02/20261113_2546621999/raw_data/F3_15_2026_11_02_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/F3_15_2026_11_02_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F3_15_2026_11_02/20261113_2546621999/raw_data/F3_15_2026_11_02_R2.fastq.gz'||X
echo -ne '\r[██████████████▌·]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G1_25_2026_10_19/"{,"20261113_2546621999/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/G1_25_2026_10_19_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G1_25_2026_10_19/20261113_2546621999/raw_data/G1_25_2026_10_19_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/G1_25_2026_10_19_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G1_25_2026_10_19/20261113_2546621999/raw_data/G1_25_2026_10_19_R2.fastq.gz'||X
echo -ne '\r[██████████████▋·]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G2_10_2026_10_27/"{,"20261113_2546621999/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/G2_10_2026_10_27_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G2_10_2026_10_27/20261113_2546621999/raw_data/G2_10_2026_10_27_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/G2_10_2026_10_27_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G2_10_2026_10_27/20261113_2546621999/raw_data/G2_10_2026_10_27_R2.fastq.gz'||X
echo -ne '\r[██████████████▊·]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G3_16_2026_10_27/"{,"20261113_2546621999/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/G3_16_2026_10_27_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G3_16_2026_10_27/20261113_2546621999/raw_data/G3_16_2026_10_27_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/G3_16_2026_10_27_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G3_16_2026_10_27/20261113_2546621999/raw_data/G3_16_2026_10_27_R2.fastq.gz'||X
echo -ne '\r[███████████████·]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H1_25_2026_10_24/"{,"20261113_2546621999/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/H1_25_2026_10_24_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H1_25_2026_10_24/20261113_2546621999/raw_data/H1_25_2026_10_24_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/H1_25_2026_10_24_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H1_25_2026_10_24/20261113_2546621999/raw_data/H1_25_2026_10_24_R2.fastq.gz'||X
echo -ne '\r[███████████████▏]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H2_10_2026_11_01/"{,"20261113_2546621999/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/H2_10_2026_11_01_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H2_10_2026_11_01/20261113_2546621999/raw_data/H2_10_2026_11_01_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/H2_10_2026_11_01_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H2_10_2026_11_01/20261113_2546621999/raw_data/H2_10_2026_11_01_R2.fastq.gz'||X
echo -ne '\r[███████████████▎]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H3_16_2026_11_02/"{,"20261113_2546621999/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/H3_16_2026_11_02_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H3_16_2026_11_02/20261113_2546621999/raw_data/H3_16_2026_11_02_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43797_Aviti_261113_AV196/H3_16_2026_11_02_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H3_16_2026_11_02/20261113_2546621999/raw_data/H3_16_2026_11_02_R2.fastq.gz'||X

echo -e '\r\e[K[████████████████] done.'
if (( !ALLOK )); then
		echo Some errors
		exit 1
fi;


mv -v /cluster/project/pangolin/processes/sars_cov_2/vpipe_input/samples.20261002_2538645270.tsv.staging /cluster/project/pangolin/processes/sars_cov_2/vpipe_input/samples.20261002_2538645270.tsv
mv -v /cluster/project/pangolin/processes/sars_cov_2/vpipe_input/samples.20261016_2607456428.tsv.staging /cluster/project/pangolin/processes/sars_cov_2/vpipe_input/samples.20261016_2607456428.tsv
mv -v /cluster/project/pangolin/processes/sars_cov_2/vpipe_input/samples.20261030_2546537150.tsv.staging /cluster/project/pangolin/processes/sars_cov_2/vpipe_input/samples.20261030_2546537150.tsv
mv -v /cluster/project/pangolin/processes/sars_cov_2/vpipe_input/samples.20261113_2546621999.tsv.staging /cluster/project/pangolin/processes/sars_cov_2/vpipe_input/samples.20261113_2546621999.tsv

echo All Ok
exit 0

