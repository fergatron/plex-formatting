#!/bin/bash

# plex formatting
# The purpose of this script is to read a directory and rename the files to
# match a format that fits with Plex Media Server's standards.

# The MVP of this script will just rename file names to be lowercase and replace
# spaces with hypens. I'll worry myself with more advanced stuff later.

# root parameter(s) to the script
# $1 - directory

lines_read=0
files_processed=0

# remove temporarily files and directory
clean_mock_files() {
    rm -rf tmp
}

# uses the data from a previous command and processes the output
process_list() {
    IFS=""
    while read -r line
    do
        (( lines_read += 1 ))
        lowercase="$(echo ${line} | tr '[:upper:]' '[:lower:]')" # convert to lowercase
        lowercase="$(echo ${lowercase} | xargs -0)" # remove trailing whitespace
        lowercase=$(echo $lowercase | sed 's/ /-/g') # replace spaces with hypens
        
        # format different punctuations
        lowercase=$(echo ${lowercase} | tr '\342\200\231' '_')
        lowercase=$(echo ${lowercase} | tr '\342\200\262' '_')
        lowercase=$(echo ${lowercase} | tr '\47' '_') # '
        lowercase=$(echo ${lowercase} | tr ',' '_')

        # printf '%s\n' ${lowercase}
        mv ${line} ${lowercase}
    done

    echo
    printf "Lines read: %s\n" ${lines_read}
    printf "Directory list:\n"
    ls
}

# seed a temporary directory with mock files in order to test this script
seed_mock_files() {
    # create tmp directory
    if [ ! -d "./tmp" ]
    then
        mkdir -p tmp
    fi

    mockFiles=(
        'ALF-S02E01-Working My Way Back to You.mp4'
        'ALF-S02E02-Somewhere Over the Rerun (aka The Ballad of Gilligan'\''s Island).avi'
        'ALF-S02E03-Take, a Look at Me Now.avi'
        "ALF-S02E08-Something's Wrong With Me.avi"
        "ALF-S02E12-ALF's Special Christmas.avi"
        'ALF-S02E18-We Gotta Get Out of This Place.avi'
    )
    IFS=""
    for file in ${mockFiles[@]}
    do
        # printf "%s\n" ${file}
        touch tmp/${file}
    done
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
        esac
    done
else
    echo
    printf "This command needs at least one target. \n"
    printf "Try a period (.) to indicate the directory you are in; or the path/to/the/directory you wish to format.\n"
    echo
fi
