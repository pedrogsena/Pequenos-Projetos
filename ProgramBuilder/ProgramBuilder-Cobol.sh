#!/bin/bash

clear
echo "Welcome to the COBOL Program Creator."
read -p "Program name (eight characters): " tempname
progname="${tempname^^}"
read -p "Author (your) name: " tempname
authname="${tempname^^}"
read -p "Extension (cbl/cob): " extension
filename="$progname.$extension"
read -p "Custom display ('HELLO WORLD.' if empty): " tempname
cdisplay="${tempname^^}"
if [[ ! -e "$filename" ]]; then
    touch "$filename"
fi

echo "      **************************************************************************" > "$filename"
echo "      * THIS IS YOUR COBOL PROGRAM." >> "$filename"
echo "      * DON'T WORRY, THESE ARE COMMENTS." >> "$filename"
echo "      * PROGRAM NAME. $progname." >> "$filename"
echo "      * AUTHOR NAME. $authname." >> "$filename"
echo "       IDENTIFICATION DIVISION." >> "$filename"
echo "       PROGRAM-ID. $progname." >> "$filename"
echo "       ENVIRONMENT DIVISION." >> "$filename"
# echo "       DATA DIVISION." >> "$filename"
echo "       PROCEDURE DIVISION." >> "$filename"
if [[ -z "$cdisplay" ]]; then
    echo "           DISPLAY 'HELLO WORLD.'." >> "$filename"
else
    echo "           DISPLAY '$cdisplay'." >> "$filename"
fi
echo "           STOP RUN." >> "$filename"

echo "Testing with GnuCobol..."
status=$(cobc "$filename" -x -o "$progname")
if [[ "$status" -eq 0 ]]; then
    echo "Program compiled successfully."
else
    echo "There was a problem when compiling your program."
fi
