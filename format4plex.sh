#!/bin/bash

# plex formatting
# The purpose of this script is to read a directory and rename the files to
# match a format that fits with Plex Media Server's standards.

# root parameter(s) to the script
# $1 - directory

lines_read=0
files_processed=0

# uses the data from a previous command and processes it
process_list() {
    while read -r line
    do
        (( lines_read += 1 ))
        printf '%s\n' "$line"
        
        # what_type "$line"
    done

    echo
    printf "Lines read: %s\n" $lines_read
}

# seed a temporary directory with mock files in order to test this script
seed_mock_files() {
    mockFiles=(
        'ALF-S02E01-Working My Way Back to You.mp4',
        'ALF-S02E02-Somewhere Over the Rerun (aka The Ballad of Gilligan'\''s Island).avi',
        'ALF-S02E03-Take a Look at Me Now.avi',
        "ALF-S02E08-Something's Wrong With Me.avi",
        "ALF-S02E12-ALF's Special Christmas.avi",
        'ALF-S02E18-We Gotta Get Out of This Place.avi'
    )
    printf "mock files: ${mockFiles}"
}

# verifies if the target is a file or a directory
what_type() {
    printf '%s\n' "is a file: ${1}"
}

# ls $1 | process_list

# PROGRAM EXECUTE HERE
# execute command targets
if [ $# -gt 0 ]
then
    for var in "$@"
    do
        case "$@" in
            seed)
                seed_mock_files
                ;;
            *)
                # ls $var | process_list
                echo "executed default case"
        esac
    done
else
    echo
    printf "This command needs at least one target. \n"
    printf "Try a period (.) to indicate the directory you are in; or the path/to/the/directory you wish to format.\n"
    echo
fi
