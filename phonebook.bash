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
	while IFS=: read -r f1 f2 f3 f4 f5
	do
		echo "$f1 $f2 $f3 $f4 $f5"
	done <"$1"
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
	check_valid_file $FILENAME
}

main