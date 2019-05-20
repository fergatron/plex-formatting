#!/bin/bash

declare MEDIA_NAME
declare MEDIA_SEASON
declare MEDIA_PATTERN
declare MEDIA_PATTERN_PROMPT

function welcome() {
    clear
    printf "Welcome to a Plex formatting script. It will collect some information before formatting your files:\n\n"

    echo -n "What is the name of the TV series? "
    read MEDIA_NAME

    echo -n "What season? [1/2/..] "
    read MEDIA_SEASON

    echo -n "Are there any patterns you would like removed? [Y/n] "
    read MEDIA_PATTERN_PROMPT

    if [[ $MEDIA_PATTERN_PROMPT =~ ^([yY][eE][sS]|[yY])+$ ]]; then
        printf "\nHere is an example of a pattern to remove:\n\n"
        printf "\tFull House 1x02 Our Very First Night(dvdrip)(dark stalker).avi\n"
        printf "\tYou want to remove '(dvdrip)(dark stalker)'.\n\n"

        echo -n "What pattern would you like removed? "
        read MEDIA_PATTERN
    fi

    echo
}