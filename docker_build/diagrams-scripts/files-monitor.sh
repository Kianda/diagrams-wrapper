#!/bin/sh

# fancy! set a timezone!
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime

# start the recursive monitoring for *.py files into "/diagrams-data/code"
# generate.sh does the filtering and the drawing
inotifywait --format="%w%f" -e close_write -m -r "/diagrams-data/code" |
while read -r fullpath; do
  /bin/sh /diagrams-scripts/generate.sh "$fullpath"
done
