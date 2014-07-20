#!/usr/bin/env python

import os
import re
import sys
import codecs

def read_mapping(f, fn="mapping data"):
    """
    Reads in mapping from Unicode to ASCII from the given input stream
    and returns a dictionary keyed by Unicode characters with the
    corresponding ASCII characters as values. The expected mapping
    format defines a single mapping per line, each with the format
    CODE\tASC where CODE is the Unicode code point as a hex number and
    ASC is the replacement ASCII string ("\t" is the literal tab
    character). Any lines beginning with "#" are skipped as comments.
    """

    # read in the replacement data
    linere = re.compile(r'^([0-9A-Za-z]{4,})\t(.*)$')
    mapping = {}

    for i, l in enumerate(f):
        # ignore lines starting with "#" as comments
        if len(l) != 0 and l[0] == "#":
            continue

        m = linere.match(l)
        assert m, "Format error in %s line %s: '%s'" % (fn, i+1, l.replace("\n","").encode("utf-8"))
        c, r = m.groups()

        # work with python narrow build
        #c = unichr(int(c, 16))
        c = (r'\U' + c.zfill(8)).decode('unicode-escape')
        assert c not in mapping or mapping[c] == r, "ERROR: conflicting mappings for %.4X: '%s' and '%s'" % (ord(c), mapping[c], r)

        # exception: literal '\n' maps to newline
        if r == '\\n':
            r = '\n'

        mapping[c] = r

    return mapping


def mapchar(c, mapping):
    return mapping[c] if c in mapping else ''


def process(text, mapping):
    s = u''
    for c in text:
        if ord(c) >= 128:
            s += mapchar(c, mapping)
        else:
            s += c
    return s


if __name__ == '__main__':
    fn = sys.argv[1]
    outdir = sys.argv[2]

    if not os.path.exists(outdir):
        os.makedirs(outdir)

    outfile = os.path.join(outdir, os.path.basename(fn))

    mapfn = 'entities.dat'
    with codecs.open(mapfn, encoding="utf-8") as f:
        mapping = read_mapping(f, mapfn)

    with codecs.open(fn, encoding='utf-8') as f:
        data = process(f.read(), mapping)

    with open(outfile, 'w') as f:
        f.write(data)
