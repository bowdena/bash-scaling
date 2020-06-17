#!/bin/bash

# This bash script uses fdupes to find all duplicates, then
# (without bias), selects any duplicates and moves them to 
# the duplicates directory specified using the same directory
# structure as initially found.
# Best called as ./progname > output.txt so that you can
# see what has happened.

export sourceDirectory="/mnt/smb/source"
export duplicateFolder="/mnt/smb/duplicates"
#export sourceDirectory="/mnt/smb/temp"
#export duplicateFolder="/mnt/smb/tempDuplicate"
mkdir -p "${duplicateFolder}"

IFS=$(echo -en "\n\b")
for file in $(fdupes -r -f "${sourceDirectory}" | grep -v '^$')
do
	DIRNAME=$(dirname "${file}"| sed 's/^\.//')
	DIRNAME="${duplicateFolder}${DIRNAME}"
	mkdir -p "${DIRNAME}"
	mv "${file}" "${DIRNAME}"
	echo "MOVING ${file}"
	#echo "${file}"
done
