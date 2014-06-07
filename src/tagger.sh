#!/bin/bash

set -e

SCRIPT_DIR=`dirname "$0"`
TLS_DIR="$SCRIPT_DIR/../tls"
EXT_DIR="$TLS_DIR/ext"
GENIA_DIR="$EXT_DIR/geniatagger"

TMP_INPUT=`mktemp`
trap 'rm -f "${TMP_INPUT}"' EXIT INT TERM HUP
cat > "${TMP_INPUT}"
pushd $GENIA_DIR > /dev/null
cat "${TMP_INPUT}" | ./geniatagger -nt  # input should be already tokenized
rm -rf "${TMP_INPUT}"
popd > /dev/null
