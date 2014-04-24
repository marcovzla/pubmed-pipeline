#!/bin/bash

PMC_DIR="$1"
OUT_DIR="$2"

[ ! -d $OUT_DIR ] && mkdir $OUT_DIR

RAW_DIR="${OUT_DIR}/raw"
[ ! -d $RAW_DIR ] && mkdir $RAW_DIR

ABSTRACT_DIR="${OUT_DIR}/abstract"
[ ! -d $ABSTRACT_DIR ] && mkdir $ABSTRACT_DIR
ABS_TXT_DIR="${ABSTRACT_DIR}/text"
[ ! -d $ABS_TXT_DIR ] && mkdir $ABS_TXT_DIR
ABS_SS_DIR="${ABSTRACT_DIR}/ss"
[ ! -d $ABS_SS_DIR ] && mkdir $ABS_SS_DIR
ABS_TOK_DIR="${ABSTRACT_DIR}/tok"
[ ! -d $ABS_TOK_DIR ] && mkdir $ABS_TOK_DIR
ABS_PARSE_DIR="${ABSTRACT_DIR}/parse"
[ ! -d $ABS_PARSE_DIR ] && mkdir $ABS_PARSE_DIR
ABS_SDEP_DIR="${ABSTRACT_DIR}/sdep"
[ ! -d $ABS_SDEP_DIR ] && mkdir $ABS_SDEP_DIR
ABS_SDEPCC_DIR="${ABSTRACT_DIR}/sdepcc"
[ ! -d $ABS_SDEPCC_DIR ] && mkdir $ABS_SDEPCC_DIR
ABS_TAG_DIR="${ABSTRACT_DIR}/tag"
[ ! -d $ABS_TAG_DIR ] && mkdir $ABS_TAG_DIR

BODY_DIR="${OUT_DIR}/body"
[ ! -d $BODY_DIR ] && mkdir $BODY_DIR
BODY_TXT_DIR="${BODY_DIR}/text"
[ ! -d $BODY_TXT_DIR ] && mkdir $BODY_TXT_DIR
BODY_SS_DIR="${BODY_DIR}/ss"
[ ! -d $BODY_SS_DIR ] && mkdir $BODY_SS_DIR
BODY_TOK_DIR="${BODY_DIR}/tok"
[ ! -d $BODY_TOK_DIR ] && mkdir $BODY_TOK_DIR
BODY_PARSE_DIR="${BODY_DIR}/parse"
[ ! -d $BODY_PARSE_DIR ] && mkdir $BODY_PARSE_DIR
BODY_SDEP_DIR="${BODY_DIR}/sdep"
[ ! -d $BODY_SDEP_DIR ] && mkdir $BODY_SDEP_DIR
BODY_SDEPCC_DIR="${BODY_DIR}/sdepcc"
[ ! -d $BODY_SDEPCC_DIR ] && mkdir $BODY_SDEPCC_DIR
BODY_TAG_DIR="${BODY_DIR}/tag"
[ ! -d $BODY_TAG_DIR ] && mkdir $BODY_TAG_DIR


SRC_DIR="src"
TLS_DIR="tls"
EXT_DIR="$TLS_DIR/ext"
NXML2TXT="$EXT_DIR/nxml2txt/nxml2txt"
ABSTRACT_BODY="$TLS_DIR/get_abstract_body.py"
GENIASS="$SRC_DIR/geniass_ss.sh"
TOKENIZER="$TLS_DIR/GTB-tokenize.pl"
BLLIP="$SRC_DIR/mcccj_ptb.sh"
SDEP="$SRC_DIR/ptb_to_sdep.sh"
GENIA="$SRC_DIR/tagger.sh"


for f in `find $PMC_DIR -name \*.nxml`; do
    fname=$(basename $f)
    docname="${fname%.*}"

    echo "processing $fname ..."

    txt_file="${RAW_DIR}/${docname}.txt"
    so_file="${RAW_DIR}/${docname}.so"
    abstract_file="${ABS_TXT_DIR}/${docname}.txt"
    body_file="${BODY_TXT_DIR}/${docname}.txt"
    abs_ss_file="${ABS_SS_DIR}/${docname}"
    abs_tok_file="${ABS_TOK_DIR}/${docname}"
    abs_parse_file="${ABS_PARSE_DIR}/${docname}"
    abs_sdep_file="${ABS_SDEP_DIR}/${docname}"
    abs_sdepcc_file="${ABS_SDEPCC_DIR}/${docname}"
    abs_tag_file="${ABS_TAG_DIR}/${docname}"
    body_ss_file="${BODY_SS_DIR}/${docname}"
    body_tok_file="${BODY_TOK_DIR}/${docname}"
    body_parse_file="${BODY_PARSE_DIR}/${docname}"
    body_sdep_file="${BODY_SDEP_DIR}/${docname}"
    body_sdepcc_file="${BODY_SDEPCC_DIR}/${docname}"
    body_tag_file="${BODY_TAG_DIR}/${docname}"

    $NXML2TXT $f $txt_file $so_file
    $ABSTRACT_BODY $txt_file $so_file $abstract_file $body_file

    if [ -e $abstract_file ]; then
        cat $abstract_file | $GENIASS 1> $abs_ss_file
        cat $abs_ss_file | $TOKENIZER 1> $abs_tok_file
        cat $abs_ss_file | $BLLIP 1> $abs_parse_file
        cat $abs_parse_file | $SDEP 1> $abs_sdep_file
        cat $abs_parse_file | $SDEP -c 1> $abs_sdepcc_file
        cat $abs_ss_file | $GENIA 1> $abs_tag_file
    fi

    if [ -e $body_file ]; then
        cat $body_file | $GENIASS 1> $body_ss_file
        cat $body_ss_file | $TOKENIZER 1> $body_tok_file
        cat $body_ss_file | $BLLIP 1> $body_parse_file
        cat $body_parse_file | $SDEP 1> $body_sdep_file
        cat $body_parse_file | $SDEP -c 1> $body_sdepcc_file
        cat $body_ss_file | $GENIA 1> $body_tag_file
    fi

    echo ""
done
