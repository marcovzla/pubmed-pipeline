#!/bin/bash

TXT_FILE="$1"
OUT_DIR="$2"

[ ! -d $OUT_DIR ] && mkdir -p $OUT_DIR

SRC_DIR="src"
BLLIP="$SRC_DIR/mcccj_ptb.sh"

docname=$(basename $TXT_FILE)
out_file="${OUT_DIR}/${docname}"

cat $TXT_FILE | $BLLIP 1> $out_file
