#!/bin/bash

# uses the data from a previous command and processes the output
function process_list() {
    declare lines_read=0
    declare files_processed=0

    IFS=""
    while read -r line
    do
        lines_read=$(( $lines_read + 1 ))
        gather_data $line

        word="$(echo ${line} | tr '[:upper:]' '[:lower:]')" # convert to lowercase
        word="$(echo ${word} | xargs -0)" # remove trailing whitespace
        word=$(echo $word | sed 's/ /-/g') # replace spaces with hypens
        
        # format different punctuations
        punc $word

        # actually processing the file based on filters
        # $(mv ${line} ${lowercase})
        # $(echo $lowercase)
        if [ true ]; then
            files_processed=$(( $files_processed + 1 ))
            printf "%s\n" ${word}
        fi
    done
    printf "lines read (%s) processed (%s)." ${lines_read} ${files_processed}
    
    export files_processed=$files_processed
    export lines_read=$lines_read
}