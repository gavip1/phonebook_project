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
	case 8:
		set REGEX_name='^[A-Za-z]\+ [A-Za-z]\+$'
		set REGEX_phone_number='^[0-9]\{3\}-[0-9]\{3\}-[0-9]\{4\}$'
		set REGEX_address='^[0-9]\+ [A-Za-z]\+\( [A-Za-z]\+.\?\)\?, [A-Za-z]\+\( [A-Za-z]\+\)\?, [A-Z]\{2,3\} [0-9]\{5\}$'
		set REGEX_date='^[0-9][0-9]\?\/[0-9][0-9]\?\/[0-9][0-9]$'
		set REGEX_salary='^[0-9]\+$'
		echo "What is the first name and last name (separate with space)?:"
		set name=$<
		echo "What is the home phone number? (xxx-xxx-xxxx) x is a digit"
		set number1=$<
		echo "What is the mobile phone number? (xxx-xxx-xxxx) x is a digit"
		set number2=$<
		echo "What is the address number? (any digit number) "
		set street_number="$<"
		echo "What is the street address? (Capitilize first character of every word) "
		set street_address="$<"
		echo "What is the city address? (Ex:Pomona)"
		set city_address="$<"
		echo "What is the state? (shorten capital letters only Ex:CA)"
		set state="$<"
		echo "What is the zip number? (5 digit numbers)"
		set zip="$<"
		set address="${street_number} ${street_address}, ${city_address}, ${state} ${zip}"
		echo $address
		echo "What is the birth date? (month/day/year) please input the last two digit for the year"
		set birthdate=$<
		echo "What is the salary? any digits of number"
		set salary=$<
		if ( "${name}" !~ "${REGEX_name}" ) then
			echo "error, name in the input contains wrong format"
			echo $name
			breaksw
		else if ( "${number1}" !~ "${REGEX_phone_number}" ) then
			echo "error, home phone number in the input contains wrong format"
			echo $number1
			breaksw
		else if ( "${number2}" !~ "${REGEX_phone_number}" ) then
			echo "error, mobile phone number in the input contains wrong format"
			echo $number2
			breaksw
		else if ( "${address}" !~ "${REGEX_address}" ) then
			echo "error, address in the input contains wrong format"
			echo $address
			breaksw
		else if ( "${birthdate}" !~ "${REGEX_date}" ) then
			echo "error, birth date in the input file contains wrong format"
			echo $birthdate
			breaksw
		else if ( "${salary}" !~ "${REGEX_salary}" ) then
			echo "error, salary in the input file contains wrong format"
			echo $salary
			breaksw
		endif
		set data="${name}:${number1}:${number2}:${address}:${birthdate}:${salary}"
		echo $data
		echo $data | tee -a $FILENAME >/dev/null
		sort -o $FILENAME $FILENAME
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
