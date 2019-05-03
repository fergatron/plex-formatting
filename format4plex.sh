#!/bin/bash

# plex formatting
# The purpose of this script is to read a directory and rename the files to
# match a format that fits with Plex Media Server's standards.

# The MVP of this script will just rename file names to be lowercase and replace
# spaces with hypens. I'll worry myself with more advanced stuff later.

# root parameter(s) to the script
# $1 - directory or OPTIONS
# $2 - OPTIONS

# fail immediately if any errors occur
set -e

MY_DIR="$(dirname "$0")"

# import helper scripts
source ${MY_DIR}/common/mock.sh

# global variables
lines_read=0
files_processed=0

# display final results and some stats
function display_results() {
    echo
    printf "Lines read: %s\n" ${lines_read}

    if [ ${files_processed} -gt 0 ]
    then
        printf "Directory list:\n"
        ls
    else
        printf "No files successfully processed.\n"
    fi
}

# uses the data from a previous command and processes the output
function process_list() {
    IFS=""
    while read -r line
    do
        lines_read=$(( $lines_read + 1 ))
        lowercase="$(echo ${line} | tr '[:upper:]' '[:lower:]')" # convert to lowercase
        lowercase="$(echo ${lowercase} | xargs -0)" # remove trailing whitespace
        lowercase=$(echo $lowercase | sed 's/ /-/g') # replace spaces with hypens
        
        # format different punctuations
        lowercase=$(echo ${lowercase} | tr '\342\200\231' '_')
        lowercase=$(echo ${lowercase} | tr '\342\200\262' '_')
        lowercase=$(echo ${lowercase} | tr '\47' '_') # '
        lowercase=$(echo ${lowercase} | tr ',' '_')
        lowercase=$(echo ${lowercase} | tr '(' '_')
        lowercase=$(echo ${lowercase} | tr ')' '_')

        # actually processing the file based on filters
        # $(mv ${line} ${lowercase})
        # $(echo $lowercase)
        if [ $(echo $lowercase) ]; then
            files_processed=$(( $files_processed + 1 ))
        fi
    done
    printf "lines read (%s) processed (%s)." ${lines_read} ${files_processed}
    
    export files_processed=$files_processed
    export lines_read=$lines_read
}

# PROGRAM EXECUTES HERE
# execute command with targets (arguments)
if [ $# -gt 0 ]
then
    echo # make a space for any upcoming output
    for var in "$@"
    do
        case "$@" in
            --clean)
                clean_mock_files
                ;;
            --seed)
                seed_mock_files
                ;;
            *)
                ls $var | process_list
                display_results
        esac
    done
else
    echo
    printf "This command needs at least one target. \n"
    printf "Try a period (.) to indicate the directory you are in; or the path/to/the/directory you wish to format.\n"
    echo
fi
