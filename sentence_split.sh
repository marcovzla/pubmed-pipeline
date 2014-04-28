#!/bin/bash

TXT_FILE="$1"
OUT_DIR="$2"

[ ! -d $OUT_DIR ] && mkdir $OUT_DIR

SRC_DIR="src"
GENIASS="$SRC_DIR/geniass_ss.sh"

docname=$(basename $TXT_FILE)
ss_file="${OUT_DIR}/${docname}"

cat $TXT_FILE | $GENIASS 1> $ss_file
