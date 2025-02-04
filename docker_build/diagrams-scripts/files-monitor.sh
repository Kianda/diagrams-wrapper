#!/bin/sh

# fancy! set a timezone!
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime

# a kind of 'not so skilled' function...
function Now {
   date '+%Y-%m-%d %H:%M:%S'
}

# start the recursive monitoring for *.py files into "/diagrams-data/code"
inotifywait --format="%e %w%f" -e close_write -m -r "/diagrams-data/code" |
while read -r action fullpath; do

  # read extension
  filename=$(basename "${fullpath}")
  extension="${filename##*.}"

  # allow only *.py
  if [ "$extension" == "py" ] || [ "$extension" == "PY" ]; then

        # some handy vars
        python_file_fullpath=$fullpath
        python_filename=$filename
        python_file_path=$(dirname "${python_file_fullpath}") # no trailing slash
        images_subfolders="$( echo "$python_file_path" | sed -e 's#^/diagrams-data/code##')"
        images_file_path="/diagrams-data/images/""$images_subfolders"  # no trailing slash

        # echoing
        echo ""
        echo "[$(Now)] START: '$python_filename'"

        # do the crap
        echo "[$(Now)] Verifying path: '$images_subfolders'"
        mkdir -p "$images_file_path" && cd "$images_file_path" ; \
        echo "[$(Now)] Generating image!"
        cat "$python_file_fullpath" | python3 && echo "[$(Now)] DONE: '$python_filename'"

        # TODO: How to run the container with host $UID and don't have permissions issues?
        chmod -R 777 "/diagrams-data/images"

  fi;

done