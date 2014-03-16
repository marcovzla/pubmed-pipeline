#!/bin/bash


COMP_DIR='components'
if [ -d $COMP_DIR ]; then
    rm -rf $COMP_DIR
fi
mkdir $COMP_DIR
pushd $COMP_DIR


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


MCCCJ_FILENAME="bioparsingmodel-rel1.tar.gz"
MCCCJ_URL="http://bllip.cs.brown.edu/download"

# download model
curl -O "$MCCCJ_URL/$MCCCJ_FILENAME"
# unpack model
tar xzvf $MCCCJ_FILENAME


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


popd # $COMP_DIR
