wget --header="Accept: text/csv" \
  -O ../src/data/weo.csv \
  'https://api.imf.org/external/sdmx/3.0/data/dataflow/IMF.RES/WEO/9.0.0/%2A.%2A.%2A?c%5BTIME_PERIOD%5D=ge:2026-01-01'


wget --header="Accept: text/csv" \
  -O ../src/data/weoall.csv \
  'https://api.imf.org/external/sdmx/3.0/data/dataflow/IMF.RES/WEO/9.0.0/%2A.%2A.%2A?detail=full&references=all'



