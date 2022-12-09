!/bin/bash
#Author: Gregorius Avip
#Script title: Phonebook.bash
#Purpose: Maintain a phonebook using .bash and unix features

#Ask the user input for a file and check if the file exists in the current directory
#Close the program if the file does not exist
echo "What is the filename of the phonebook?"
read input
FILENAME=$PWD\/$input
if [ ! -f "$FILENAME" ]
then
	echo "File does not exist. hint: check if the file is in the directory or if the input file contains the right file extension"
	exit
fi

