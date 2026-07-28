#!/bin/sh

echo "Clearing images folder!"

rm -rf /diagrams-data/images/*

echo "Generating all images!"

# Call the generator directly, one *.py at a time. This used to append a newline
# to every *.py just to wake up the file-monitor, which edited all your source
# files only to redraw them. Nothing is modified now.
find "/diagrams-data/code" -type f \( -name "*.py" -o -name "*.PY" \) \
  -exec /bin/sh /diagrams-scripts/generate.sh {} \;

echo "DONE!"
