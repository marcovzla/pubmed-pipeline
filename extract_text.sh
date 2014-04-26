#!/bin/bash

NXML_FILE="$1"
OUT_DIR="$2"

[ ! -d $OUT_DIR ] && mkdir -p $OUT_DIR

TLS_DIR="tls"
EXT_DIR="$TLS_DIR/ext"
NXML2TXT="$EXT_DIR/nxml2txt/nxml2txt"

docname=$(basename $NXML_FILE .nxml)
txt_file="${OUT_DIR}/${docname}.txt"
so_file="${OUT_DIR}/$docname}.so"

$NXML2TXT $NXML_FILE $txt_file $so_file
