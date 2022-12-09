#!/bin/bash
#Author: Gregorius Avip
#Script title: Phonebook.bash
#Purpose: Maintain a phonebook using .bash and unix features

#Ask the user input for a file and check if the file exists in the current directory
#Stop the script if the file does not exist

look_file ()
{
	if [ ! -f "$1" ]
	then
		echo "File does not exist. hint: check if the file is in the directory or if the input file contains the right file extension"
		return 1
	fi
	return 0
}

check_valid_file ()
{
	REGEX_name='^[A-Z][a-z]* [A-Z][a-z]*$'
	while IFS=: read -r f1 f2 f3 f4 f5
	do
		if ! [[ $f1 =~ $REGEX_name ]]
		then
			echo "error, name in the input file contains wrong format"
			echo $f1
			return 1
		fi
	done <"$1"
	return 0
}

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
}

main