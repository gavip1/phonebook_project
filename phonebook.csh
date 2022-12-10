#!/bin/csh
#Author: Gregorius Avip
#Script title: phonebook.csh
#Purpose: Maintain a phonebook using .csh and unix features

echo "What is the filename of the phonebook?"
set input=$<
set FILENAME=$PWD$input
echo $FILENAME