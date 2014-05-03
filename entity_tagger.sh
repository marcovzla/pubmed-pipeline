#!/bin/bash

TXT_FILE="$1"
OUT_DIR="$2"

[ ! -d $OUT_DIR ] && mkdir -p $OUT_DIR

SRC_DIR="src"
GENIA="$SRC_DIR/tagger.sh"

docname=$(basename $TXT_FILE)
out_file="${OUT_DIR}/${docname}"

cat $TXT_FILE | $GENIA 1> $out_file
