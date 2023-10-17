#!/bin/bash

date=20200409
link=--link
target=../sampleset

#Data Set Type: FASTQ_GZ Index: GATATCCA-GGATTAAC, External Sample Name: 100848_112_H5, Contact Person: Timothy Vaughan;Sarah Nadeau;Jeremie Scire;Sophie Seidel
#https://openbis-dsu.ethz.ch/openbis?viewMode=SIMPLE#entity=DATA_SET&permId=20200425131608350-60692023

truncate --size 0 ${target}/samples.tsv.new
cat e-mail.txt | while read line; do
	if [[ $line =~ ^Data\ Set\ Type:\ FASTQ_GZ ]]; then
		if [[ $line =~ Sample\ Name:\ ((([[:digit:]]{6}|neg)_[[:digit:]]+_[[:alpha:]][[:digit:]]{,2})|(pos|H2O|EMPTY)[^,]+) ]]; then
			temp=${BASH_REMATCH[1]}
			tmp2=${temp//[\.\/]/_}
			name=${tmp2//__/_}
			id=
			continue
		else
			echo -e '\e[31;1mInfo line parsing error:\e[0m'
			echo $line
			exit 1
		fi
	elif [[ $line =~ ^https ]]; then
		if [[ $line =~ Id=([[:digit:]]+-[[:digit:]]+)$ ]]; then
			id=${BASH_REMATCH[1]}
		else
			echo -e '\e[31;1mURL line parsing error:\e[0m'
			echo $line
			exit 1
		fi
	elif [[ -z "$line" ]]; then
		continue
	else
		id=
		name=
	fi

	if [[ -z "$name" || -z "$id" ]]; then
		echo -e '\e[31;1mParsing fail:\e[0m'
		echo $line
		exit 1
	fi

# $ 20200425131508718-60692018/original/BSSE_QGF_137972_000000000_J3JCY_1_MM_1/ :
# BSSE_QGF_137972_000000000_J3JCY_1_100845_112_G6_ACAGTTGA_GCTCCGAT_S89_L001_MM_1_metadata.tsv
# BSSE_QGF_137972_000000000_J3JCY_1_100845_112_G6_ACAGTTGA_GCTCCGAT_S89_L001_R2_001_MM_1.fastq.gz
# BSSE_QGF_137972_000000000_J3JCY_1_100845_112_G6_ACAGTTGA_GCTCCGAT_S89_L001_R1_001_MM_1.fastq.gz

	if [[ ! -d "$id" ]]; then
		echo -e '\e[31;1mNot a directory:\e[0m'
		echo $id
		exit 1
	fi

	fastq=( ${id}/original/*/*_${name}_*_R[1-2]_*.fastq.gz )

	if [[ "${fastq[*]}" =~ \* ]]; then
		echo -e '\e[31;1mCannot list fastq files:\e[0m'
		echo $id : $name
		exit 1
	elif (( ${#fastq[@]} != 2 )); then 
		echo -e '\e[31;1mNumber of fastq files not 2:\e[0m'
		echo "${#fastq[@]} : ${fastq[@]}"
		exit 1
	fi

	dst=${target}/$name/$date/raw_data
	mkdir -p "$dst"
	for file in "${fastq[@]}"; do
		destname="${file##*/}"
		if [[ $file =~ _L[[:digit:]]+_R[[:digit:]](_[[:digit:]]+(_[^\.]+)?.fastq.gz)$ ]]; then
			destname="${destname//${BASH_REMATCH[1]}/.fastq.gz}"
		fi
		cp -v ${link} "${file}" "${dst}/${destname}"
	done
	
	echo -e "${name}\t${date}\t250" >> ${target}/samples.tsv.new
done
