#!/bin/bash

subtract_years() {
    local date="$1"
    local years="$2"
    date -d "$date -$years years" +%Y-%m-%d
}

DATE=$(date +%Y-%m-%d)
YEARS=5
RESULT=$(subtract_years "$DATE" "$YEARS")

wget --header="Accept: text/csv" \
  -O ../src/data/weo.csv \
  "https://api.imf.org/external/sdmx/3.0/data/dataflow/IMF.RES/WEO/9.0.0/%2A.%2A.%2A?c%5BTIME_PERIOD%5D=ge:$RESULT"


wget --header="Accept: text/csv" \
  -O ../src/data/weoall.csv \
  'https://api.imf.org/external/sdmx/3.0/data/dataflow/IMF.RES/WEO/9.0.0/%2A.%2A.%2A?detail=full&references=all'



