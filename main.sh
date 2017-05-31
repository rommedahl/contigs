#!/bin/bash

## Add path to script folders
PATH=$PATH:/bin:/bin/

## User input
echo "Enter path to .m4 input data, use tab for completion."
read -e -p "File: " inputM4path

while true; do
    read -p "Should the M4-file be sorted? (y/n):" yn
    case $yn in
        [Yy]* ) m4sort=1; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

if [ -n ${m4sort+x} ]; then echo Sorting "${inputM4path}"; sortM4.sh "${inputM4path}" > "${inputM4path}".sortM4 ; fi

