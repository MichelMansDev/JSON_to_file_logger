#!/bin/sh

# This program relies on the JSON parsing with 'jq'. To install, use 'apt install jq' and off you go

# define the URL to grab. This should be a... JSON format...

SCORE_URL="https://filesamples.com/samples/code/json/sample2.json"

# define the 2 seperate files to write to

OUTFILE_HOME="./score_home.txt"
OUTFILE_GUEST="./score_guest.txt"

# change the JSON-tag to address the correct one 

JSON_TAG_HOME=".age"
JSON_TAG_GUEST=".age"

# how long do we sleep before we get new data (seconds)

SLEEP_SECS=5

# Do not make changes from here on...

while true
do
    TIMESTAMP=`date +"%Y-%m-%d %T"`

    OUTPUT=`curl --silent $SCORE_URL`

    echo -n $TIMESTAMP
    echo -n " - "
    
    SCORE_HOME=`echo "$OUTPUT" | jq --raw-output $JSON_TAG_HOME`

    case $SCORE_HOME in
        ''|*[!0-9]*) echo "Invalid score for 'Home', disregarding, got: '$SCORE_HOME'" ;;
        *) echo -n "Home: $SCORE_HOME - "
           echo $SCORE_HOME > $OUTFILE_HOME ;;
    esac

    SCORE_GUEST=`echo "$OUTPUT" | jq --raw-output $JSON_TAG_GUEST`

    case $SCORE_GUEST in
        ''|*[!0-9]*) echo "Invalid score for 'Guest', disregarding, got: '$SCORE_GUEST'" ;;
        *) echo "Guest: $SCORE_GUEST"
           echo $SCORE_GUEST > $OUTFILE_GUEST ;;
    esac

    sleep $SLEEP_SECS

done
