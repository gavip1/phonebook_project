#!/bin/csh
#Author: Gregorius Avip
#Script title: phonebook.csh
#Purpose: Maintain a phonebook using .csh and unix features

echo "What is the filename of the phonebook?"
set input=$<
set FILENAME=$PWD\/$input
if ( ! -f $FILENAME ) then
	echo "File does not exist. hint: check if the file is in the directory or if the input file contains the right file extension"
	exit 1
endif

set occur = `grep -vr '^[A-Za-z]\+ [A-Za-z]\+' $FILENAME | wc -l`
set occur2 = `grep -vr '[A-Za-z]:[0-9]\{3\}-[0-9]\{3\}-[0-9]\{4\}' $FILENAME | wc -l`
set occur3 = `grep -vr '[0-9]:[0-9]\{3\}-[0-9]\{3\}-[0-9]\{4\}' $FILENAME | wc -l`
set occur4 = `grep -vr '[0-9]\+ [A-Za-z]\+\( [A-Za-z]\+.\?\)\?, [A-Za-z]\+\( [A-Za-z]\+\)\?, [A-Z]\{2,3\} [0-9]\{5\}' $FILENAME | wc -l`
set occur5 = `grep -vr '[0-9][0-9]\?\/[0-9][0-9]\?\/[0-9][0-9]' $FILENAME | wc -l`
set occur6 = `grep -vr '[0-9]\+$' $FILENAME | wc -l`
if ( $occur > 0 ) then
	echo "Error, file contains wrong format"
	exit 2
else if ( $occur2 > 0 ) then
	echo "Error, file contains wrong format"
	exit 2
else if ( $occur3 > 0 ) then
	echo "Error, file contains wrong format"
	exit 2
else if ( $occur4 > 0 ) then
	echo "Error, file contains wrong format"
	exit 2
else if ( $occur5 > 0 ) then
	echo "Error, file contains wrong format"
	exit 2
else if ( $occur6 > 0 ) then
	echo "Error, file contains wrong format"
	exit 2
endif
