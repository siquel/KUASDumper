#!/bin/bash

if [ -z "$1" ]
   then
      echo "No dumped file specified"
      exit;
fi
iconv -f ISO-8859-1 -t UTF-8 "$1" | sponge "$1"
