#!/bin/bash

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
