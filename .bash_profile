#!/bin/bash

#Prints the username
echo "Hello $(whoami)"

#creates env variable and export it
COURSE_ID='DevOpsTheHardWay'
export "$COURSE_ID"

#Check if .token exist, and if it has the right permissions
FILE="/home/$USER/.token"

if [ -f "$FILE" ]; then
  echo "$FILE **does*** exist in your system"

  if [ $(stat -c "%a" "$FILE") -ne 600 ]; then
    echo "Warning: .token file has too open permissions"
  fi
fi

#Change the default newly created files with read write only to users and groups
umask 006


#Add /home/<username>/usercommands to the end of the PATH env var.
export PATH="/home/$USER/usercommands:$PATH"


#Print the current date on screen.
date -u +%Y-%m-%dT%H:%M:%S


#Define a command alias, as follows -whenever the user is executing ltxt,all files with .txt extension are printed
echo "alias ltxt='ls *.txt'" >> ~/.bashrc


#If it doesnt exist, create the ~/tmp directory on the user's home dir. If it exists, clean it
TMP_DIR=~/tmp
if [ -d "$TMP_DIR" ]; then
    echo "Cleaning $TMP_DIR directory..."
    rm -rf "${TMP_DIR:?}/"*
else

    echo "Creating $TMP_DIR directory..."
    mkdir "$TMP_DIR"
fi


# Check if any process is using port 8080
PID=$(lsof -t -i :8080)

if [ -n "$PID" ]; then
    echo "Killing process $PID bound to port 8080..."
    kill "$PID"
    echo "Process killed."
else
    echo "No process found bound to port 8080."
fi
