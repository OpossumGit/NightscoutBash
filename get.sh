#!/bin/bash

json=$(curl -s https://xxx.herokuapp.com/api/v1/entries.json?count=1)

sgv=$(echo "$json" | jq .[].sgv)
epoch=$(echo "$json" | jq .[].date)

#echo "$json"
mmol=$(echo "$sgv*0.0555" |bc -l)
unixtime=$(echo "$epoch" | cut -c1-10)
when=$(date -d @$unixtime)
direction=$(echo "$json" | jq .[].direction)

if [[ $direction == "\"DoubleDown\"" ]]
then
  dir="vv"
elif [[ $direction == "\"SingleDown\"" ]]
then
  dir="v"
elif [[ $direction == "\"FortyFiveDown\"" ]]
then
  dir="\\"
elif [[ $direction == "\"FortyFiveUp\"" ]]
then
  dir="\/"
elif [[ $direction == "\"SingleUp\"" ]]
then
  dir="^"
elif [[ $direction == "\"DoubleUp\"" ]]
then
  dir="^^"
else
  dir="-"
fi

  
echo "$mmol $dir @ $when"

