#!/bin/bash

echo "Clearing images folder!"

rm -rf /diagrams-data/images/*

echo "Generating all images! Check the logs!"

# THIS IS KIND-OF-NASTY
find "/diagrams-data/code" -type f \( -name "*.py" -o -name "*.PY" \) -exec sh -c "sleep 0.25 && echo '' >> {}" \;

echo "DONE!"
