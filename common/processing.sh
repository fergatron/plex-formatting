#!/bin/bash

# `word` is the main variable being exported within the different
# functions. After a function manipulates it, it'll then export it.

# uses the data from a previous command and processes the output
function process_list() {
    declare lines_read=0
    declare files_processed=0

    IFS=""
    while read -r line
    do
        lines_read=$(( $lines_read + 1 )) # count the amount of lines read
        word=$line

        #gather_data $line
        pattern $word # remove certain patterns

        lower $word # convert to lowercase
        whitespace $word # remove trailing whitespace
        spaces $word # replace spaces with hypens
        punc $word # format different punctuations

        # actually processing the file based on filters
        # $(mv ${line} ${word})
        # $(echo $lowercase)
        if [ $(mv ${line} ${word}) ]; then
            files_processed=$(( $files_processed + 1 )) # count the amount of lines proccessed
            #printf "%s\n" ${word}
        fi
    done

    echo
    printf "=====\n"
    printf "lines read: %s\n" ${lines_read}
    printf "lines processed: %s\n\n" ${files_processed}
    ls

    export files_processed=$files_processed
    export lines_read=$lines_read
}