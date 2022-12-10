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

set occur = `grep -vr '^[A-Za-z][A-Za-z]* [A-Za-z][A-Za-z]*' $FILENAME | wc -l`
if (occur > 0) then
	echo "Error, file contains wrong format"
	exit 2
endif