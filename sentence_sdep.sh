#!/bin/bash

PTB_FILE="$1"
OUT_DIR="$2"

[ ! -d $OUT_DIR ] && mkdir -p $OUT_DIR

SRC_DIR="src"
SDEP="$SRC_DIR/ptb_to_sdep.sh"

docname=$(basename $PTB_FILE)
out_file="${OUT_DIR}/${docname}"

echo $PTB_FILE
cat $PTB_FILE | $SDEP 1> $out_file
