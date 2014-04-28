#!/bin/bash

TXT_FILE="$1"
SO_FILE="${TXT_FILE%.*}.so"

OUT_DIR="$2"
[ ! -d $OUT_DIR ] && mkdir $OUT_DIR
ABSTRACT_DIR="${OUT_DIR}/abstract"
[ ! -d $ABSTRACT_DIR ] && mkdir $ABSTRACT_DIR
BODY_DIR="${OUT_DIR}/body"
[ ! -d $BODY_DIR ] && mkdir $BODY_DIR

TLS_DIR="tls"
ABSTRACT_BODY="$TLS_DIR/get_abstract_body.py"

docname=$(basename $TXT_FILE)
abstract_file="$ABSTRACT_DIR/$docname"
body_file="$BODY_DIR/$docname"

$ABSTRACT_BODY $TXT_FILE $SO_FILE $abstract_file $body_file
