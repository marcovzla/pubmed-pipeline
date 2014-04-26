#!/bin/bash

PMC_DIR="$1"
OUT_DIR="$2"

N_PROCS=10

[ ! -d $OUT_DIR ] && mkdir -p $OUT_DIR

find $PMC_DIR -name \*.nxml -print0 | xargs -0 -n 1 -P $N_PROCS -i ./extract_text.sh {} $OUT_DIR
