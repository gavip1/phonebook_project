#!/bin/csh
#Author: Gregorius Avip
#Script title: phonebook.csh
#Purpose: Maintain a phonebook using .csh and unix features

#Find the file and stop script if file not found
echo "What is the filename of the phonebook?"
set input=$<
set FILENAME=$PWD\/$input
if ( ! -f $FILENAME ) then
	echo "File does not exist. hint: check if the file is in the directory or if the input file contains the right file extension"
	exit 1
endif

#Check if the file is valid
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

#User Menu
while (1)
	echo "MENU: (input the number without parantheses)"
	echo "1) Show the record sorted in alphabetical order of first name"
	echo "2) Show the record sorted in alphabetical order of last name"
	echo "3) Show the record sorted in reverse alphabetical order of first name"
	echo "4) Show the record sorted in reverse alphabetical order of last name"
	echo "5) Search for a record by Last Name"
	echo "6) Search for a record by birthday in a given year"
	echo "7) Search for a record by birthday in a given month"
	echo "8) Insert Record"
	echo "9) Delete a record by mobile phone number"
	echo "10) Delete a record by last name"
	echo "11) Exit Script"
	set input=$<
	switch ("$input")
	case 1:
		sort $FILENAME
		breaksw
	case 2:
		sort -k 2 $FILENAME
		breaksw
	case 3:
		sort -r $FILENAME
		breaksw
	case 4:
		sort -k 2r $FILENAME
		breaksw
	case 5:
		echo "What is the last name?"
		set input_name=$<
		echo "Record(s) with this last name:"
		set regex="[A-Za-z]"
		grep "${regex} ${input_name}:" $FILENAME
		breaksw
	case 6:
		echo "What is the birth date year?"
		set input_year=$<
		echo "Record(s) with this birth date year:"
		grep "/${input_year}:" $FILENAME
		breaksw
	case 7:
		echo "What is the birth date month?"
		set input_month=$<
		echo "Record(s) with this birth date month:"
		set month=":${input_month}/"
		grep "${month}" $FILENAME
		breaksw
	case 11:
		echo "Exiting the program..."
		sort $FILENAME #$FILENAME
		exit 0
		breaksw
	default:
		echo "Please input the right command"
		breaksw
	endsw
end
