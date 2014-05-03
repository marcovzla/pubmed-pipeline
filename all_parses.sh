#!/bin/bash

TXT_DIR="$1"
OUT_DIR="$2"

N_PROCS=5

[ ! -d $OUT_DIR ] && mkdir -p $OUT_DIR

find $TXT_DIR -name \*.txt -print0 | xargs -0 -n 1 -P $N_PROCS -i ./sentence_parse.sh {} $OUT_DIR
