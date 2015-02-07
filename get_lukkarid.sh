#!/bin/bash

if [ -z "$1" ]
   then 
        echo "No output file specified for full dump."
        exit;
fi
export TEMP=.kamkdump
./dump_kamk.sh -o $TEMP -g TTV14SP && ./enc_charset.sh $TEMP && perl parse.pl $TEMP "$1" && rm $TEMP 
