#!/bin/bash

DAY=`date +%d`
DAY=`printf "%01d" $DAY`

MON=`date +%m`
MON=`printf "%01d" $MON`

YEAR=`date +%Y`

YYYYMMDD=`echo ${YEAR}-${MON}-${DAY}`

echo $YYYYMMDD

TODAY_FILE="$YYYYMMDD.gnu"

cp generic_ins_temp.gnu $TODAY_FILE

sed -i s/"DATE_REPL"/"$YYYYMMDD"/g $TODAY_FILE

gnuplot $TODAY_FILE


