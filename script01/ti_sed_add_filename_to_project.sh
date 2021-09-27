#!/bin/bash

if [ -z "$1" ] ; then
    echo
    echo " Usage : $0 <aaaa_without_ext>"
    echo
    exit
fi

sed -i \
    \
    -e "s;\(\S*\)\bmain\b\(\S*\);\1$1\2 \1main\2;g"   \
    \
    subdir_vars.mk makefile
