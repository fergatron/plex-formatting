#!/bin/bash

# remove temporarily files and directory
function clean_mock_files() {
    rm -rf tmp
    printf "Removed the tmp directory.\n"
}

# seed a temporary directory with mock files in order to test this script
function seed_mock_files() {
    # create tmp directory
    if [ ! -d "./tmp" ]
    then
        mkdir -p tmp
        printf "Created a temporary directory.\n"
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
    printf "Created temporary files.\n"
}