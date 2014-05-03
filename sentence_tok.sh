#!/bin/bash

TXT_FILE="$1"
OUT_DIR="$2"

[ ! -d $OUT_DIR ] && mkdir $OUT_DIR

TLS_DIR="tls"
TOKENIZER="$TLS_DIR/GTB-tokenize.pl"

docname=$(basename $TXT_FILE)
tok_file="${OUT_DIR}/${docname}"

cat $TXT_FILE | $TOKENIZER 1> $tok_file
