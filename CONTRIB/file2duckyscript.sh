#!/bin/sh

# Create ducky script that will inject a file (Linux target)

if [ \! -e "$1" ]; then
  echo Usage: $(basename $0) <filename> [<remote path>]
  exit 0
fi

file=$(basename $1)

# Start terminal
cat <<EOF
REM file2duckyscript
DELAY 3000
ALT F2
DELAY 250
STRING gnome-terminal
ENTER
DELAY 500
EOF

# Go to folder
if [ \! -z "$2" ];then
  echo "STRING cd $2"
  echo "ENTER"
  echo "DELAY 50"
fi

# Start base64 decoder
cat <<EOF
STRING base64 -id > $file
ENTER
DELAY 100
EOF

# base64 encode out file and convert output to ducky script
cat $1 | base64 | awk '{print "STRING",$0,"\nENTER"}'

# Done... Exit
cat <<EOF
CTRL d
DELAY 100
CTRL d
REM Done...
EOF

