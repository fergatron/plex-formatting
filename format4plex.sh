#!/bin/bash

# plex formatting
# The purpose of this script is to read a directory and rename the files to
# match a format that fits with Plex Media Server's standards.

# The MVP of this script will just rename file names to be lowercase and replace
# spaces with hypens. I'll worry myself with more advanced stuff later.

# TODO
# 1. Figure out how to convert '1x01' to 's01e01'
# 2. Remove certain patterns (use external file as a database) - have user input pattern to remove
# if it only removes formatting then don't go through the entire process of filtering and renaming
# ie: --pattern-to-remove DVDrip.Xvid.mp3

# root parameter(s) to the script
# $1 - directory or OPTIONS
# $2 - OPTIONS

# global variables
declare -i lines_read=0
declare -i files_processed=0

# remove temporarily files and directory
clean_mock_files() {
    rm -rf tmp
    printf "Successfully removed the tmp directory.\n"
}

# display final results and some stats
display_results() {
    echo
    printf "Lines read: %s\n" ${lines_read}

    if [ files_processed -gt 0 ]
    then
        printf "Directory list:\n"
        ls
    else
        printf "No files successfully processed.\n"
    fi
}

# uses the data from a previous command and processes the output
process_list() {
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
        if [ $(mv ${line} ${lowercase}) ]; then
            files_processed=$(( $files_processed + 1 ))
        fi
    done
    printf "lines read (%s) processed (%s)." ${lines_read} ${files_processed}
}

# seed a temporary directory with mock files in order to test this script
seed_mock_files() {
    # create tmp directory
    if [ ! -d "./tmp" ]
    then
        mkdir -p tmp
        printf "Successfully created tmp directory.\n"
    fi

    mockFiles=(
        'ALF-S02E01-Working My Way Back to You.mp4'
        'ALF-S02E02-Somewhere Over the Rerun (aka The Ballad of Gilligan'\''s Island).avi'
        'ALF-S02E03-Take, a Look at Me Now.avi'
        "ALF-S02E12-ALF's Special Christmas.avi"
        'Full House 1x00 - Pilot Unaired Pilot(Dvdrip)(Dark_Stalker).avi'
        'Full House 1x02 - Our Very First Night(Dvdrip)(Dark_Stalker).avi'
        'Darkwing Duck - 122 - Double Darkwings.avi'
        'Darkwing Duck - 123 - Aduckyphobia.avi'
    )
    IFS=""
    for file in ${mockFiles[@]}
    do
        # printf "%s\n" ${file}
        touch tmp/${file}
    done
    printf "Successfully created temporary files.\n"
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
