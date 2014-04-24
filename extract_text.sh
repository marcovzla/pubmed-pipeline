#!/bin/bash

PMC_DIR="$1"
OUT_DIR="$2"

[ ! -d $OUT_DIR ] && mkdir -p $OUT_DIR

RAW_DIR="${OUT_DIR}/raw"
[ ! -d $RAW_DIR ] && mkdir -p $RAW_DIR

ABSTRACT_DIR="${OUT_DIR}/abstract/text"
[ ! -d $ABSTRACT_DIR ] && mkdir -p $ABSTRACT_DIR

BODY_DIR="${OUT_DIR}/body/text"
[ ! -d $BODY_DIR ] && mkdir -p $BODY_DIR

TLS_DIR="tls"
EXT_DIR="$TLS_DIR/ext"
NXML2TXT="$EXT_DIR/nxml2txt/nxml2txt"
ABSTRACT_BODY="$TLS_DIR/get_abstract_body.py"

for f in `find $PMC_DIR -name \*.nxml`; do
    fname=$(basename $f)
    docname="${fname%.*}"

    echo "processing $fname ..."

    txt_file="${RAW_DIR}/${docname}.txt"
    so_file="${RAW_DIR}/${docname}.so"
    abstract_file="${ABSTRACT_DIR}/${docname}.txt"
    body_file="${BODY_DIR}/${docname}.txt"

    $NXML2TXT $f $txt_file $so_file
    $ABSTRACT_BODY $txt_file $so_file $abstract_file $body_file

    echo ""
done
