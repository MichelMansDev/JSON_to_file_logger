#!/bin/sh

SCORE_URL="https://filesamples.com/samples/code/json/sample2.json"

OUTFILE_HOME="./score_home.txt"
OUTFILE_GUEST="./score_guest.txt"

while true
do
    TIMESTAMP=`date +"%Y-%m-%d %T"`

    OUTPUT=`curl --silent $SCORE_URL`

    echo -n $TIMESTAMP
    echo -n " - "
    #SCORE_HOME=`curl --silent $SCORE_URL | jq --raw-output .age`
    SCORE_HOME=`echo "$OUTPUT" | jq --raw-output .age`

    case $SCORE_HOME in
        ''|*[!0-9]*) echo "Invalid score for 'Home', disregarding, got: '$SCORE_HOME'" ;;
        *) echo -n "Home: $SCORE_HOME - "
           echo $SCORE_HOME > $OUTFILE_HOME ;;
    esac

    #SCORE_GUEST=`curl --silent $SCORE_URL | jq --raw-output .firstname`
    SCORE_GUEST=`echo "$OUTPUT" | jq --raw-output .age`

    case $SCORE_GUEST in
        ''|*[!0-9]*) echo "Invalid score for 'Guest', disregarding, got: '$SCORE_GUEST'" ;;
        *) echo "Guest: $SCORE_GUEST"
           echo $SCORE_GUEST > $OUTFILE_GUEST ;;
    esac

    sleep 5

done
