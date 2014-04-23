#!/bin/bash


TLS_DIR="tls"
EXT_DIR="$TLS_DIR/ext"

# start from scratch
if [ -d $EXT_DIR ]; then
    rm -rf $EXT_DIR
fi
mkdir $EXT_DIR

# get into EXT_DIR
pushd $EXT_DIR





# install charniak parser

# nothing special about this commit (hash)
# it was the most recent when I wrote this script
BLLIP_HASH="0bc8b2c8cfe5aa040677108d09b48ffe501852b3"
BLLIP_FILENAME="${BLLIP_HASH}.tar.gz"
BLLIP_URL="https://github.com/BLLIP/bllip-parser"
BLLIP_BASE="bllip-parser"

# download parser
curl -L -O "$BLLIP_URL/archive/$BLLIP_FILENAME"
# unpack parser
tar xzvf $BLLIP_FILENAME
# make symbolic link
ln -s "${BLLIP_BASE}-${BLLIP_HASH}" $BLLIP_BASE
# build parser
pushd $BLLIP_BASE
make
popd





# install biomodel for charniak parser

MCCCJ_FILENAME="bioparsingmodel-rel1.tar.gz"
MCCCJ_URL="http://bllip.cs.brown.edu/download"

# download model
curl -O "$MCCCJ_URL/$MCCCJ_FILENAME"
# unpack model
tar xzvf $MCCCJ_FILENAME





# install genia sentence splitter

# nothing special about this commit (hash)
# it was the most recent when I wrote this script
GENIASS_HASH="d9cd8e5afe73e0f7084b0fce0f4dc219c9196e33"
GENIASS_FILENAME="${GENIASS_HASH}.tar.gz"
GENIASS_URL="https://github.com/marcovzla/geniass"
GENIASS_BASE="geniass"

curl -L -O "$GENIASS_URL/archive/$GENIASS_FILENAME"
tar xzvf $GENIASS_FILENAME
ln -s "${GENIASS_BASE}-${GENIASS_HASH}" $GENIASS_BASE
pushd $GENIASS_BASE
make
popd





# install stanford parser

STANFORD_FILENAME="stanford-parser-full-2014-01-04.zip"
STANFORD_URL="http://www-nlp.stanford.edu/software"
STANFORD_BASE="stanford-parser"

curl -O "$STANFORD_URL/$STANFORD_FILENAME"
unzip $STANFORD_FILENAME
ln -s ${STANFORD_FILENAME%.*} $STANFORD_BASE





# install genia tagger
GENIA_HASH='dee879e12ff5bc991eb9002ce467348226b08df2'
GENIA_FILENAME="${GENIA_HASH}.tar.gz"
GENIA_URL="https://github.com/marcovzla/geniatagger"
GENIA_BASE="geniatagger"

curl -L -O "$GENIA_URL/archive/$GENIA_FILENAME"
tar xzvf $GENIA_FILENAME
ln -s "${GENIA_BASE}-${GENIA_HASH}" $GENIA_BASE
pushd $GENIA_BASE
make
popd





# install nxml2txt
NXML_HASH='27f02baec3ca407a162df5db8e2dd398255f50a2'
NXML_FILENAME="${NXML_HASH}.tar.gz"
NXML_URL='https://github.com/marcovzla/nxml2txt'
NXML_BASE='nxml2txt'

curl -L -O "$NXML_URL/archive/$NXML_FILENAME"
tar xzvf $NXML_FILENAME
ln -s "${NXML_BASE}-${NXML_HASH}" $NXML_BASE





popd # $EXT_DIR
