#!/bin/bash

SRC_DIR="src"
TLS_DIR="tls"
EXT_DIR="$TLD_DIR/ext"
GENIASS="$SRC_DIR/geniass_ss.sh"
TOKENIZER="$TLS_DIR/GTB-tokenize.pl"
BLLIP="$SRC_DIR/mcccj_ptb.sh"
SDEP="$SRC_DIR/ptb_to_sdep.sh"
GENIA="$SRC_DIR/tagger.sh"



cat abstract.txt | $GENIASS > abstract.txt.ss
cat abstract.txt.ss | $TOKENIZER > abstract.txt.tok
cat abstract.txt.ss | $BLLIP > abstract.txt.ptb
cat abstract.txt.ptb | $SDEP > abstract.txt.sdep
cat abstract.txt.ptb | $SDEP -c > abstract.txt.sdepcc
cat abstract.txt.ss | $GENIA > abstract.txt.tag
