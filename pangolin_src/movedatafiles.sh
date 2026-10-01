
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

[[ -d '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189' ]] || fail 'Not a directory:' '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189'
echo -ne '\r[················]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A1_05_2026_08_12/"{,"20260904_2539478507/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/A1_05_2026_08_12_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A1_05_2026_08_12/20260904_2539478507/raw_data/A1_05_2026_08_12_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/A1_05_2026_08_12_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A1_05_2026_08_12/20260904_2539478507/raw_data/A1_05_2026_08_12_R2.fastq.gz'||X
echo -ne '\r[▎···············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A2_15_2026_08_11/"{,"20260904_2539478507/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/A2_15_2026_08_11_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A2_15_2026_08_11/20260904_2539478507/raw_data/A2_15_2026_08_11_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/A2_15_2026_08_11_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A2_15_2026_08_11/20260904_2539478507/raw_data/A2_15_2026_08_11_R2.fastq.gz'||X
echo -ne '\r[▋···············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A3_17_2026_08_20/"{,"20260904_2539478507/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/A3_17_2026_08_20_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A3_17_2026_08_20/20260904_2539478507/raw_data/A3_17_2026_08_20_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/A3_17_2026_08_20_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A3_17_2026_08_20/20260904_2539478507/raw_data/A3_17_2026_08_20_R2.fastq.gz'||X
echo -ne '\r[▉···············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B1_05_2026_08_14/"{,"20260904_2539478507/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/B1_05_2026_08_14_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B1_05_2026_08_14/20260904_2539478507/raw_data/B1_05_2026_08_14_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/B1_05_2026_08_14_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B1_05_2026_08_14/20260904_2539478507/raw_data/B1_05_2026_08_14_R2.fastq.gz'||X
echo -ne '\r[█▎··············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B2_15_2026_08_14/"{,"20260904_2539478507/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/B2_15_2026_08_14_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B2_15_2026_08_14/20260904_2539478507/raw_data/B2_15_2026_08_14_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/B2_15_2026_08_14_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B2_15_2026_08_14/20260904_2539478507/raw_data/B2_15_2026_08_14_R2.fastq.gz'||X
echo -ne '\r[█▋··············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B3_17_2026_08_22/"{,"20260904_2539478507/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/B3_17_2026_08_22_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B3_17_2026_08_22/20260904_2539478507/raw_data/B3_17_2026_08_22_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/B3_17_2026_08_22_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B3_17_2026_08_22/20260904_2539478507/raw_data/B3_17_2026_08_22_R2.fastq.gz'||X
echo -ne '\r[█▉··············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C1_10_2026_08_12/"{,"20260904_2539478507/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/C1_10_2026_08_12_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C1_10_2026_08_12/20260904_2539478507/raw_data/C1_10_2026_08_12_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/C1_10_2026_08_12_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C1_10_2026_08_12/20260904_2539478507/raw_data/C1_10_2026_08_12_R2.fastq.gz'||X
echo -ne '\r[██▎·············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C2_16_2026_08_12/"{,"20260904_2539478507/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/C2_16_2026_08_12_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C2_16_2026_08_12/20260904_2539478507/raw_data/C2_16_2026_08_12_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/C2_16_2026_08_12_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C2_16_2026_08_12/20260904_2539478507/raw_data/C2_16_2026_08_12_R2.fastq.gz'||X
echo -ne '\r[██▌·············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C3_25_2026_08_20/"{,"20260904_2539478507/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/C3_25_2026_08_20_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C3_25_2026_08_20/20260904_2539478507/raw_data/C3_25_2026_08_20_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/C3_25_2026_08_20_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C3_25_2026_08_20/20260904_2539478507/raw_data/C3_25_2026_08_20_R2.fastq.gz'||X
echo -ne '\r[██▉·············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D1_10_2026_08_14/"{,"20260904_2539478507/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/D1_10_2026_08_14_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D1_10_2026_08_14/20260904_2539478507/raw_data/D1_10_2026_08_14_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/D1_10_2026_08_14_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D1_10_2026_08_14/20260904_2539478507/raw_data/D1_10_2026_08_14_R2.fastq.gz'||X
echo -ne '\r[███▎············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D2_16_2026_08_15/"{,"20260904_2539478507/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/D2_16_2026_08_15_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D2_16_2026_08_15/20260904_2539478507/raw_data/D2_16_2026_08_15_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/D2_16_2026_08_15_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D2_16_2026_08_15/20260904_2539478507/raw_data/D2_16_2026_08_15_R2.fastq.gz'||X
echo -ne '\r[███▌············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D3_25_2026_08_22/"{,"20260904_2539478507/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/D3_25_2026_08_22_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D3_25_2026_08_22/20260904_2539478507/raw_data/D3_25_2026_08_22_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/D3_25_2026_08_22_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D3_25_2026_08_22/20260904_2539478507/raw_data/D3_25_2026_08_22_R2.fastq.gz'||X
echo -ne '\r[███▉············]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E1_17_2026_08_12/"{,"20260904_2539478507/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/E1_17_2026_08_12_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E1_17_2026_08_12/20260904_2539478507/raw_data/E1_17_2026_08_12_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/E1_17_2026_08_12_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E1_17_2026_08_12/20260904_2539478507/raw_data/E1_17_2026_08_12_R2.fastq.gz'||X
echo -ne '\r[████▏···········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E2_05_2026_08_20/"{,"20260904_2539478507/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/E2_05_2026_08_20_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E2_05_2026_08_20/20260904_2539478507/raw_data/E2_05_2026_08_20_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/E2_05_2026_08_20_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E2_05_2026_08_20/20260904_2539478507/raw_data/E2_05_2026_08_20_R2.fastq.gz'||X
echo -ne '\r[████▌···········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E3_15_2026_08_19/"{,"20260904_2539478507/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/E3_15_2026_08_19_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E3_15_2026_08_19/20260904_2539478507/raw_data/E3_15_2026_08_19_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/E3_15_2026_08_19_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E3_15_2026_08_19/20260904_2539478507/raw_data/E3_15_2026_08_19_R2.fastq.gz'||X
echo -ne '\r[████▉···········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F1_17_2026_08_14/"{,"20260904_2539478507/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/F1_17_2026_08_14_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F1_17_2026_08_14/20260904_2539478507/raw_data/F1_17_2026_08_14_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/F1_17_2026_08_14_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F1_17_2026_08_14/20260904_2539478507/raw_data/F1_17_2026_08_14_R2.fastq.gz'||X
echo -ne '\r[█████▏··········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F2_05_2026_08_22/"{,"20260904_2539478507/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/F2_05_2026_08_22_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F2_05_2026_08_22/20260904_2539478507/raw_data/F2_05_2026_08_22_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/F2_05_2026_08_22_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F2_05_2026_08_22/20260904_2539478507/raw_data/F2_05_2026_08_22_R2.fastq.gz'||X
echo -ne '\r[█████▌··········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F3_15_2026_08_23/"{,"20260904_2539478507/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/F3_15_2026_08_23_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F3_15_2026_08_23/20260904_2539478507/raw_data/F3_15_2026_08_23_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/F3_15_2026_08_23_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F3_15_2026_08_23/20260904_2539478507/raw_data/F3_15_2026_08_23_R2.fastq.gz'||X
echo -ne '\r[█████▉··········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G1_25_2026_08_12/"{,"20260904_2539478507/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/G1_25_2026_08_12_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G1_25_2026_08_12/20260904_2539478507/raw_data/G1_25_2026_08_12_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/G1_25_2026_08_12_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G1_25_2026_08_12/20260904_2539478507/raw_data/G1_25_2026_08_12_R2.fastq.gz'||X
echo -ne '\r[██████▏·········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G2_10_2026_08_20/"{,"20260904_2539478507/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/G2_10_2026_08_20_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G2_10_2026_08_20/20260904_2539478507/raw_data/G2_10_2026_08_20_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/G2_10_2026_08_20_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G2_10_2026_08_20/20260904_2539478507/raw_data/G2_10_2026_08_20_R2.fastq.gz'||X
echo -ne '\r[██████▌·········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G3_16_2026_08_20/"{,"20260904_2539478507/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/G3_16_2026_08_20_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G3_16_2026_08_20/20260904_2539478507/raw_data/G3_16_2026_08_20_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/G3_16_2026_08_20_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G3_16_2026_08_20/20260904_2539478507/raw_data/G3_16_2026_08_20_R2.fastq.gz'||X
echo -ne '\r[██████▊·········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H1_25_2026_08_14/"{,"20260904_2539478507/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/H1_25_2026_08_14_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H1_25_2026_08_14/20260904_2539478507/raw_data/H1_25_2026_08_14_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/H1_25_2026_08_14_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H1_25_2026_08_14/20260904_2539478507/raw_data/H1_25_2026_08_14_R2.fastq.gz'||X
echo -ne '\r[███████▏········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H2_10_2026_08_22/"{,"20260904_2539478507/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/H2_10_2026_08_22_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H2_10_2026_08_22/20260904_2539478507/raw_data/H2_10_2026_08_22_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/H2_10_2026_08_22_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H2_10_2026_08_22/20260904_2539478507/raw_data/H2_10_2026_08_22_R2.fastq.gz'||X
echo -ne '\r[███████▌········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H3_16_2026_08_23/"{,"20260904_2539478507/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/H3_16_2026_08_23_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H3_16_2026_08_23/20260904_2539478507/raw_data/H3_16_2026_08_23_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43165_Aviti_260904_AV189/H3_16_2026_08_23_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H3_16_2026_08_23/20260904_2539478507/raw_data/H3_16_2026_08_23_R2.fastq.gz'||X
[[ -d '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191' ]] || fail 'Not a directory:' '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191'
echo -ne '\r[███████▊········]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A1_05_2026_08_24/"{,"20260918_2538537303/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/A1_05_2026_08_24_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A1_05_2026_08_24/20260918_2538537303/raw_data/A1_05_2026_08_24_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/A1_05_2026_08_24_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A1_05_2026_08_24/20260918_2538537303/raw_data/A1_05_2026_08_24_R2.fastq.gz'||X
echo -ne '\r[████████▏·······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A2_15_2026_08_27/"{,"20260918_2538537303/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/A2_15_2026_08_27_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A2_15_2026_08_27/20260918_2538537303/raw_data/A2_15_2026_08_27_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/A2_15_2026_08_27_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A2_15_2026_08_27/20260918_2538537303/raw_data/A2_15_2026_08_27_R2.fastq.gz'||X
echo -ne '\r[████████▍·······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"A3_17_2026_09_01/"{,"20260918_2538537303/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/A3_17_2026_09_01_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A3_17_2026_09_01/20260918_2538537303/raw_data/A3_17_2026_09_01_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/A3_17_2026_09_01_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/A3_17_2026_09_01/20260918_2538537303/raw_data/A3_17_2026_09_01_R2.fastq.gz'||X
echo -ne '\r[████████▊·······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B1_05_2026_08_30/"{,"20260918_2538537303/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/B1_05_2026_08_30_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B1_05_2026_08_30/20260918_2538537303/raw_data/B1_05_2026_08_30_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/B1_05_2026_08_30_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B1_05_2026_08_30/20260918_2538537303/raw_data/B1_05_2026_08_30_R2.fastq.gz'||X
echo -ne '\r[█████████▏······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B2_15_2026_08_31/"{,"20260918_2538537303/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/B2_15_2026_08_31_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B2_15_2026_08_31/20260918_2538537303/raw_data/B2_15_2026_08_31_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/B2_15_2026_08_31_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B2_15_2026_08_31/20260918_2538537303/raw_data/B2_15_2026_08_31_R2.fastq.gz'||X
echo -ne '\r[█████████▍······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"B3_17_2026_09_04/"{,"20260918_2538537303/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/B3_17_2026_09_04_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B3_17_2026_09_04/20260918_2538537303/raw_data/B3_17_2026_09_04_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/B3_17_2026_09_04_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/B3_17_2026_09_04/20260918_2538537303/raw_data/B3_17_2026_09_04_R2.fastq.gz'||X
echo -ne '\r[█████████▊······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C1_10_2026_08_25/"{,"20260918_2538537303/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/C1_10_2026_08_25_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C1_10_2026_08_25/20260918_2538537303/raw_data/C1_10_2026_08_25_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/C1_10_2026_08_25_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C1_10_2026_08_25/20260918_2538537303/raw_data/C1_10_2026_08_25_R2.fastq.gz'||X
echo -ne '\r[██████████······]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C2_16_2026_08_28/"{,"20260918_2538537303/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/C2_16_2026_08_28_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C2_16_2026_08_28/20260918_2538537303/raw_data/C2_16_2026_08_28_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/C2_16_2026_08_28_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C2_16_2026_08_28/20260918_2538537303/raw_data/C2_16_2026_08_28_R2.fastq.gz'||X
echo -ne '\r[██████████▍·····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"C3_25_2026_09_01/"{,"20260918_2538537303/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/C3_25_2026_09_01_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C3_25_2026_09_01/20260918_2538537303/raw_data/C3_25_2026_09_01_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/C3_25_2026_09_01_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/C3_25_2026_09_01/20260918_2538537303/raw_data/C3_25_2026_09_01_R2.fastq.gz'||X
echo -ne '\r[██████████▊·····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D1_10_2026_08_30/"{,"20260918_2538537303/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/D1_10_2026_08_30_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D1_10_2026_08_30/20260918_2538537303/raw_data/D1_10_2026_08_30_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/D1_10_2026_08_30_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D1_10_2026_08_30/20260918_2538537303/raw_data/D1_10_2026_08_30_R2.fastq.gz'||X
echo -ne '\r[███████████·····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D2_16_2026_08_31/"{,"20260918_2538537303/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/D2_16_2026_08_31_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D2_16_2026_08_31/20260918_2538537303/raw_data/D2_16_2026_08_31_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/D2_16_2026_08_31_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D2_16_2026_08_31/20260918_2538537303/raw_data/D2_16_2026_08_31_R2.fastq.gz'||X
echo -ne '\r[███████████▍····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"D3_25_2026_09_04/"{,"20260918_2538537303/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/D3_25_2026_09_04_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D3_25_2026_09_04/20260918_2538537303/raw_data/D3_25_2026_09_04_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/D3_25_2026_09_04_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/D3_25_2026_09_04/20260918_2538537303/raw_data/D3_25_2026_09_04_R2.fastq.gz'||X
echo -ne '\r[███████████▊····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E1_17_2026_08_24/"{,"20260918_2538537303/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/E1_17_2026_08_24_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E1_17_2026_08_24/20260918_2538537303/raw_data/E1_17_2026_08_24_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/E1_17_2026_08_24_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E1_17_2026_08_24/20260918_2538537303/raw_data/E1_17_2026_08_24_R2.fastq.gz'||X
echo -ne '\r[████████████····]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E2_05_2026_09_01/"{,"20260918_2538537303/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/E2_05_2026_09_01_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E2_05_2026_09_01/20260918_2538537303/raw_data/E2_05_2026_09_01_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/E2_05_2026_09_01_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E2_05_2026_09_01/20260918_2538537303/raw_data/E2_05_2026_09_01_R2.fastq.gz'||X
echo -ne '\r[████████████▍···]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"E3_15_2026_09_01/"{,"20260918_2538537303/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/E3_15_2026_09_01_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E3_15_2026_09_01/20260918_2538537303/raw_data/E3_15_2026_09_01_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/E3_15_2026_09_01_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/E3_15_2026_09_01/20260918_2538537303/raw_data/E3_15_2026_09_01_R2.fastq.gz'||X
echo -ne '\r[████████████▋···]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F1_17_2026_08_30/"{,"20260918_2538537303/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/F1_17_2026_08_30_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F1_17_2026_08_30/20260918_2538537303/raw_data/F1_17_2026_08_30_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/F1_17_2026_08_30_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F1_17_2026_08_30/20260918_2538537303/raw_data/F1_17_2026_08_30_R2.fastq.gz'||X
echo -ne '\r[█████████████···]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F2_05_2026_09_04/"{,"20260918_2538537303/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/F2_05_2026_09_04_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F2_05_2026_09_04/20260918_2538537303/raw_data/F2_05_2026_09_04_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/F2_05_2026_09_04_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F2_05_2026_09_04/20260918_2538537303/raw_data/F2_05_2026_09_04_R2.fastq.gz'||X
echo -ne '\r[█████████████▍··]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"F3_15_2026_09_04/"{,"20260918_2538537303/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/F3_15_2026_09_04_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F3_15_2026_09_04/20260918_2538537303/raw_data/F3_15_2026_09_04_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/F3_15_2026_09_04_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/F3_15_2026_09_04/20260918_2538537303/raw_data/F3_15_2026_09_04_R2.fastq.gz'||X
echo -ne '\r[█████████████▋··]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G1_25_2026_08_24/"{,"20260918_2538537303/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/G1_25_2026_08_24_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G1_25_2026_08_24/20260918_2538537303/raw_data/G1_25_2026_08_24_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/G1_25_2026_08_24_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G1_25_2026_08_24/20260918_2538537303/raw_data/G1_25_2026_08_24_R2.fastq.gz'||X
echo -ne '\r[██████████████··]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G2_10_2026_09_01/"{,"20260918_2538537303/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/G2_10_2026_09_01_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G2_10_2026_09_01/20260918_2538537303/raw_data/G2_10_2026_09_01_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/G2_10_2026_09_01_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G2_10_2026_09_01/20260918_2538537303/raw_data/G2_10_2026_09_01_R2.fastq.gz'||X
echo -ne '\r[██████████████▎·]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"G3_16_2026_09_01/"{,"20260918_2538537303/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/G3_16_2026_09_01_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G3_16_2026_09_01/20260918_2538537303/raw_data/G3_16_2026_09_01_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/G3_16_2026_09_01_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/G3_16_2026_09_01/20260918_2538537303/raw_data/G3_16_2026_09_01_R2.fastq.gz'||X
echo -ne '\r[██████████████▋·]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H1_25_2026_08_30/"{,"20260918_2538537303/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/H1_25_2026_08_30_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H1_25_2026_08_30/20260918_2538537303/raw_data/H1_25_2026_08_30_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/H1_25_2026_08_30_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H1_25_2026_08_30/20260918_2538537303/raw_data/H1_25_2026_08_30_R2.fastq.gz'||X
echo -ne '\r[███████████████·]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H2_10_2026_09_04/"{,"20260918_2538537303/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/H2_10_2026_09_04_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H2_10_2026_09_04/20260918_2538537303/raw_data/H2_10_2026_09_04_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/H2_10_2026_09_04_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H2_10_2026_09_04/20260918_2538537303/raw_data/H2_10_2026_09_04_R2.fastq.gz'||X
echo -ne '\r[███████████████▎]\r'

mkdir ${mode} -p "/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/"{,"H3_16_2026_09_04/"{,"20260918_2538537303/"{,raw_data,extracted_data}}}
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/H3_16_2026_09_04_R1.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H3_16_2026_09_04/20260918_2538537303/raw_data/H3_16_2026_09_04_R1.fastq.gz'||X
cp -vf ${link} '/cluster/project/pangolin/data/fgcz_raw/p23224/o43271_Aviti_260918_AV191/H3_16_2026_09_04_R2.fastq.gz' '/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/H3_16_2026_09_04/20260918_2538537303/raw_data/H3_16_2026_09_04_R2.fastq.gz'||X

echo -e '\r\e[K[████████████████] done.'
if (( !ALLOK )); then
		echo Some errors
		exit 1
fi;


mv -v /cluster/project/pangolin/processes/sars_cov_2/vpipe_input/samples.20260904_2539478507.tsv.staging /cluster/project/pangolin/processes/sars_cov_2/vpipe_input/samples.20260904_2539478507.tsv
mv -v /cluster/project/pangolin/processes/sars_cov_2/vpipe_input/samples.20260918_2538537303.tsv.staging /cluster/project/pangolin/processes/sars_cov_2/vpipe_input/samples.20260918_2538537303.tsv

echo All Ok
exit 0

