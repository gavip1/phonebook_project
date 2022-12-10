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

set occur = `grep -v '^[A-Za-z]+ [A-Za-z]+' $FILENAME | wc -l`
set occur2 = `grep -v '[A-Za-z]:[0-9]{3}-[0-9]{3}-[0-9]{4}' $FILENAME | wc -l`
set occur3 = `grep -v '[0-9]:[0-9]{3}-[0-9]{3}-[0-9]{4}' $FILENAME | wc -l`
set occur4 = `grep -v '[0-9]+ [A-Za-z]+( [A-Za-z]+.?)?, [A-Za-z]+( [A-Za-z]+)?, [A-Z]{2,3} [0-9]{5}' $FILENAME | wc -l`
set occur5 = `grep -v '[0-9][0-9]?\/[0-9][0-9]?\/[0-9][0-9]' $FILENAME | wc -l`
set occur6 = `grep -v '[0-9]+$' $FILENAME | wc -l`
echo $occur
echo $occur2
echo $occur3
echo $occur4
echo $occur5
echo $occur6
if ( $occur > 0 ) then
	echo "Error, file contains wrong format"
	exit 2
endif
