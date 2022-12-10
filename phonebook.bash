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

#two arguments: $1 = the filename, $2 = last name
#read the input file and find the last name provided by the second argument
search_last ()
{
	while read -r f1 f2 line
	do
		if [[ $f2 == *$2* ]]
		then
			echo "$f1 $f2 $line"
			return
		fi
	done <"$1"
	echo "the last name: $2 is not found in the record"
}

#take 2 arguments $1 = filename, $2 = birth date year
#returns the record with that year
search_birthday_year ()
{
	echo "Record(s) with this birth date year:"
	year="/$2:"
	grep $year $1
}
#take 2 arguments $1 = filename, $2 = birth date month
#returns the record with that month
search_birthday_month ()
{
	echo "Record(s) with this birth date month:"
	year=":$2/"
	grep $year $1
}

#append new data after checking whether the data is valid
#the data then will be sorted
#take one argument as the filename 
insert_record ()
{
	REGEX_name='^[A-Z][A-Za-z]* [A-Z][A-Za-z]*$'
	REGEX_phone_number='^[0-9]{3}-[0-9]{3}-[0-9]{4}$'
	REGEX_address='^[0-9]+ [A-Za-z]+( [A-Za-z]+.?)?, [A-Za-z]+( [A-Za-z]+)?, [A-Z]{2,3} [0-9]{5}$'
	REGEX_date='^[0-9][0-9]?\/[0-9][0-9]?\/[0-9][0-9]$'
	REGEX_salary='^[0-9]+$'
	echo "What is the first name and last name (separate with space)?:"
	read name
	echo "What is the home phone number? (xxx-xxx-xxxx) x is a digit"
	read number1
	echo "What is the mobile phone number? (xxx-xxx-xxxx) x is a digit"
	read number2
	echo "What is the address? (street_number Street_Address, City, State zip_number) "
	read address
	echo "What is the birth date? (month/day/year) please input the last two digit for the year"
	read birthdate
	echo "What is the salary? any digits of number"
	read salary
	if ! [[ $name =~ $REGEX_name ]]
		then
			echo "error, name in the input contains wrong format"
			echo $name
			return
		elif ! [[ $number1 =~ $REGEX_phone_number ]]
		then
			echo "error, home phone number in the input contains wrong format"
			echo $number1
			return
		elif ! [[ $number2 =~ $REGEX_phone_number ]]
		then
			echo "error, mobile phone number in the input contains wrong format"
			echo $number2
			return
		elif ! [[ $address =~ $REGEX_address ]]
		then
			echo "error, address in the input contains wrong format"
			echo $address
			return
		elif ! [[ $birthdate =~ $REGEX_date ]]
		then
			echo "error, birth date in the input file contains wrong format"
			echo $birthdate
			return 1
		elif ! [[ $salary =~ $REGEX_salary ]]
		then
			echo "error, salary in the input file contains wrong format"
			echo $salary
			return
	fi
	data="$name:$number1:$number2:$address:$birthdate:$salary"
	echo $data | tee -a $1 >/dev/null
	sort -o $1
}

#take two arguments $1 = filename, $2 = phone number
#if the number is a valid format, delete them from the record
remove_by_mobile ()
{
	REGEX_phone_number='^[0-9]{3}-[0-9]{3}-[0-9]{4}$'
	if ! [[ $2 =~ $REGEX_phone_number ]]
		then
			echo "error, mobile phone number in the input contains wrong format"
			echo $2
			return
	fi
	num=":$2:[0-9]+ "
	sed -r -i '' "/$num/d" $1
	#NOTE: on Mac OS X, doing in-place (-i) editing requires the extension to be explicitly specified
	#the quote '' is added as a work around
}

#take two arguments $1 = filename, $2 = last name
#if the name is a valid format, delete them from the record
remove_by_last ()
{
	REGEX_name='^[A-Z][A-Za-z]*$'
	if ! [[ $2 =~ $REGEX_name ]]
		then
			echo "error, name in the input contains wrong format"
			echo $2
			return
	fi
	name=" $2"
	sed -i '' "/$name/d" $1
	#NOTE: on Mac OS X, doing in-place (-i) editing requires the extension to be explicitly specified
	#the quote '' is added as a work around
}

#output the sorted record by first name
#take one argument of filename
sort_first_alphabetical ()
{
	sort $1
}
#output the reverse sorted record by first name
#take one argument of filename
sort_first_reverse_alphabetical ()
{
	sort -r $1
}
#output the sorted record by last name
#take one argument of filename
sort_last_alphabetical ()
{
	sort -k 2 $1
}
#output the reverse sorted record by last name
#take one argument of filename
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
	
	#echo "What is the last name?"
	#read input
	#search_last $FILENAME $input
	
	#echo "What is the birth date year?"
	#read input
	#search_birthday_year $FILENAME $input
	
	#echo "What is the birth date month?"
	#read input
	#search_birthday_month $FILENAME $input
	
	#insert_record $FILENAME
	echo "What is the phone number?"
	read input
	remove_by_mobile $FILENAME $input
	
	echo "What is the last name?"
	read input
	remove_by_last $FILENAME $input
}

main
