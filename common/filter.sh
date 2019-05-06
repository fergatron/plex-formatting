#!/bin/bash

function lower() {
    local word="$(echo ${1} | tr '[:upper:]' '[:lower:]')"
    export word=$word
}

function punc() {
    local w=${1}
    
    word=$(echo ${w} | tr '\342\200\231' '_')
    word=$(echo ${w} | tr '\342\200\262' '_')
    word=$(echo ${w} | tr '\47' '_') # '
    word=$(echo ${w} | tr ',' '_')
    word=$(echo ${w} | tr '(' '_')
    word=$(echo ${w} | tr ')' '_')

    printf "\nword: $w input: $1\n"

    export word=$w
}