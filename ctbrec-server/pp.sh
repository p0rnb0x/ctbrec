#!/bin/sh -e

# $1 directory (absolute path)
# $2 file (absolute path)
# $3 model name
# $4 site name
# $5 unixtime

# Updated simple example script that's included in CTBRec archives.
# As of 3.9.0 and earlier:
# $2 returns a directory if 'recordSingleFile = false' on CTBRec server.
# In that case '/playlist.m3u8' needs to be added otherwise ffmpeg will fail
# and the recording will be deleted by the following rm commands.

ROOT_DIR="$(dirname $1)"
MODEL_NAME="$(basename $1)"

mkdir -p "${ROOT_DIR}/DONE/${MODEL_NAME}"

# The following line will add '/playlist.m3u8' if the passed argument is a directory,
# it should work fine for running either on the standalone or server version.

if [ -d "$2" ]; then
  INPUT_FILE="$2/playlist.m3u8"
else
  INPUT_FILE="$2"
fi  

# Get the filename without path.
# NOTE: This will return playlist.m3u8 for 'recordSingleFile = false' on the server.
FILE="$(basename $2)"

# Format unixtime to human readable
# Original line below
TIME="$(date --date="@$5" +%d.%m.%Y_%H:%M)"

# Line below has time in ISO format avoiding ':' which will cause Windows to use
# 8.3 naming if the file is viewed/moved to a Windows OS.
# Comment out the above line and uncomment the one below if you want to use it.
# TIME=$(date --date="@$5" +%Y%m%d-%H%M%S)

# Define filename of end result
MP4="$(echo "$1/$4_$3_$TIME.mp4")"

# Remux ts to mp4
# This could overtax low power processors, (eg. ARM SoC in NAS), in which case you'll
# have to post-process on a PC or at a time when no recording is happening.
ffmpeg -threads 1 -i "$INPUT_FILE" -c:v copy -c:a copy -movflags faststart -f mp4 "$MP4"

# Move mp4 to target directory - needless to say, set your own output path
mv "$MP4" "${ROOT_DIR}/DONE/${MODEL_NAME}/"

# Delete the directory of the recording
rm -rf "$2"
test "$(ls -A "$1")" || rm -rf "$1"

