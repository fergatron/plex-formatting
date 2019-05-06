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
source ${MY_DIR}/common/data.sh
source ${MY_DIR}/common/filter.sh
source ${MY_DIR}/common/mock.sh
source ${MY_DIR}/common/processing.sh
source ${MY_DIR}/common/welcome.sh

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
                welcome
                ls $var | process_list
        esac
    done
else
    echo
    printf "This command needs at least one target. \n"
    printf "Try a period (.) to indicate the directory you are in; or the path/to/the/directory you wish to format.\n"
    echo
fi
