#!/bin/bash

RAW_DIR="$1"
RAW_FILES="${RAW_DIR}/*.txt"

SS_DIR="${RAW_DIR}/../ss"
[ ! -d $SS_DIR ] && mkdir $SS_DIR
TOK_DIR="${RAW_DIR}/../tok"
[ ! -d $TOK_DIR ] && mkdir $TOK_DIR
PARSE_DIR="${RAW_DIR}/../parse"
[ ! -d $PARSE_DIR ] && mkdir $PARSE_DIR
SDEP_DIR="${RAW_DIR}/../sdep"
[ ! -d $SDEP_DIR ] && mkdir $SDEP_DIR
SDEPCC_DIR="${RAW_DIR}/../sdepcc"
[ ! -d $SDEPCC_DIR ] && mkdir $SDEPCC_DIR
TAG_DIR="${RAW_DIR}/../tag"
[ ! -d $TAG_DIR ] && mkdir $TAG_DIR

SRC_DIR="src"
TLS_DIR="tls"
EXT_DIR="$TLD_DIR/ext"
GENIASS="$SRC_DIR/geniass_ss.sh"
TOKENIZER="$TLS_DIR/GTB-tokenize.pl"
BLLIP="$SRC_DIR/mcccj_ptb.sh"
SDEP="$SRC_DIR/ptb_to_sdep.sh"
GENIA="$SRC_DIR/tagger.sh"


for f in $RAW_FILES; do
    fname=$(basename $f)

    echo "processing $fname ..."

    ss_file="${SS_DIR}/${fname}"
    tok_file="${TOK_DIR}/${fname}"
    parse_file="${PARSE_DIR}/${fname}"
    sdep_file="${SDEP_DIR}/${fname}"
    sdepcc_file="${SDEPCC_DIR}/${fname}"
    tag_file="${TAG_DIR}/${fname}"

    cat $f | $GENIASS 1> $ss_file 2> /dev/null
    cat $ss_file | $TOKENIZER 1> $tok_file 2> /dev/null
    cat $ss_file | $BLLIP 1> $parse_file 2> /dev/null
    cat $parse_file | $SDEP 1> $sdep_file 2> /dev/null
    cat $parse_file | $SDEP -c 1> $sdepcc_file 2> /dev/null
    cat $ss_file | $GENIA 1> $tag_file 2> /dev/null
done
