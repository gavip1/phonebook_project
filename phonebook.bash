#!/bin/bash
#Author: Gregorius Avip
#Script title: Phonebook.bash
#Purpose: Maintain a phonebook using .bash and unix features

#Ask the user input for a file and check if the file exists in the current directory
#returns true if the file exsists and return false if it does not
#filename is asked in main and passed as the first argument
look_file ()
{
	if [ ! -f "$1" ]
	then
		echo "File does not exist. hint: check if the file is in the directory or if the input file contains the right file extension"
		return 1
	fi
	return 0
}

#Checking if the input file is a valid file via regular expression
#If any field does not match, tell the user that there is an error in that field along with the current field
#returns true if everything is valid and returns false otherwise
#does not support for checking valid date or valid state (only the format)
#does not check if there is more than 6 field (ignore extra fields)
check_valid_file ()
{
	REGEX_name='^[A-Z][A-Za-z]* [A-Z][A-Za-z]*$'
	REGEX_phone_number='^[0-9]{3}-[0-9]{3}-[0-9]{4}$'
	REGEX_address='^[0-9]+ [A-Za-z]+( [A-Za-z]+.?)?, [A-Za-z]+( [A-Za-z]+)?, [A-Z]{2,3} [0-9]{5}$'
	REGEX_date='^[0-9][0-9]?\/[0-9][0-9]?\/[0-9][0-9]$'
	REGEX_salary='^[0-9]+$'
	while IFS=: read -r f1 f2 f3 f4 f5 f6
	do
		if ! [[ $f1 =~ $REGEX_name ]]
		then
			echo "error, name in the input file contains wrong format"
			echo $f1
			return 1
		elif ! [[ $f2 =~ $REGEX_phone_number ]]
		then
			echo "error, home phone number in the input file contains wrong format"
			echo $f2
			return 1
		elif ! [[ $f3 =~ $REGEX_phone_number ]]
		then
			echo "error, mobile phone number in the input file contains wrong format"
			echo $f3
			return 1
		elif ! [[ $f4 =~ $REGEX_address ]]
		then
			echo "error, address in the input file contains wrong format"
			echo $f4
			return 1
		elif ! [[ $f5 =~ $REGEX_date ]]
		then
			echo "error, birth date in the input file contains wrong format"
			echo $f5
			return 1
		elif ! [[ $f6 =~ $REGEX_salary ]]
		then
			echo "error, salary in the input file contains wrong format"
			echo $f6
			return 1
		fi
	done <"$1"
	return 0
}

sort_first_alphabetical ()
{
	sort $1
}

sort_first_reverse_alphabetical ()
{
	sort -r $1
}

sort_last_alphabetical ()
{
	sort -k 2 $1
}

sort_last_reverse_alphabetical ()
{
	sort -k 2r $1
}

#main drive program
main()
{
	echo "What is the filename of the phonebook?"
	read input
	FILENAME=$PWD\/$input
	if ! look_file $FILENAME
	then
		return 0
	fi
	if ! check_valid_file $FILENAME
	then
		return 0
	fi
	sort_first_alphabetical $FILENAME
	echo "\n"
	sort_last_alphabetical $FILENAME
	echo "\n"
	sort_first_reverse_alphabetical $FILENAME
	echo "\n"
	sort_last_reverse_alphabetical $FILENAME
	echo "\n"
}

main
