#!/bin/bash

# convert the entire phrase to lowercase
function lower() {
    local w="$(echo ${1} | tr '[:upper:]' '[:lower:]')"
    export word=$w
}

# remove patterns from phrase
function pattern() {
    local w=${1}
    if [ $MEDIA_PATTERN ]; then
        w=$(echo ${w} | sed -e "s/${MEDIA_PATTERN}//g")
        export word=$w
    fi
}

# replace certain punctuations
function punc() {
    local w=${1}
    
    # different variations of apostrophe (')
    # w=$(echo ${w} | tr '\342\200\231' '_')
    # w=$(echo ${w} | tr '\342\200\262' '_')
    # w=$(echo ${w} | tr '\47' '_')
    w=$(echo ${w} | sed -e "s/(')//g")

    w=$(echo ${w} | sed -e "s/,//g")
    w=$(echo ${w} | sed -e "s/[(,)]/_/g")

    export word=$w
}

# convert spaces to hyphens
function spaces() {
    local w=${1}
    w=$(echo ${w} | sed "s/\s-\s/ /g")
    w=$(echo ${w} | sed 's/\s/-/g')
    export word=$w
}

# remove trailing whitespace
function whitespace() {
    local w="$(echo ${1} | xargs -0)"
    export word=$w
}