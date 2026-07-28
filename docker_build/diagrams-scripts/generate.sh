#!/bin/sh

# Generate the image for a single *.py file.
#
#   Usage: generate.sh /diagrams-data/code/<subfolders>/<file>.py
#
# The image is written to /diagrams-data/images/<subfolders>/ because the
# diagram code is executed with that folder as the working directory, so the
# path of the *.py inside 'code' is replicated inside 'images'.
#
# Shared by files-monitor.sh (on file-save) and runall.sh (regenerate all), so
# the path logic lives in exactly one place.

Now() {
   date '+%Y-%m-%d %H:%M:%S'
}

python_file_fullpath="$1"
python_filename=$(basename "$python_file_fullpath")

# allow only *.py
case "$python_filename" in
  *.py|*.PY) ;;
  *) exit 0 ;;
esac

python_file_path=$(dirname "$python_file_fullpath")  # no trailing slash
images_subfolders="$( echo "$python_file_path" | sed -e 's#^/diagrams-data/code##')"
images_file_path="/diagrams-data/images/""$images_subfolders"  # no trailing slash

echo ""
echo "[$(Now)] START: '$python_filename'"

echo "[$(Now)] Verifying path: '$images_subfolders'"
mkdir -p "$images_file_path" || exit 1

# subshell: keeps the 'cd' from leaking to the caller
(
  cd "$images_file_path" || exit 1
  echo "[$(Now)] Generating image!"
  python3 < "$python_file_fullpath" && echo "[$(Now)] DONE: '$python_filename'"
)

# TODO: How to run the container with host $UID and don't have permissions issues?
chmod -R 777 "/diagrams-data/images"
