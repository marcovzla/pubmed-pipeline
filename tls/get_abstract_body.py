#!/usr/bin/env python

# this script reads the text and standoff files produced by nxml2txt and extracts body and abstract
# ignoring section titles, figures and tables

import sys
import re

def first(it):
    return next(iter(it))

def span_contains(span1, span2):
    return span2[0] >= span1[0] and span2[1] <= span1[1]

def get_spans(name, standoff):
    pat = r'\t' + re.escape(name) + r' (?P<start>\d+) (?P<end>\d+)'
    for m in re.finditer(pat, standoff):
        start = int(m.group('start'))
        end = int(m.group('end'))
        yield (start, end)

def keep_spans(span, ignore):
    start, end = span
    for s in sorted(ignore):
        yield (start, s[0])
        start = s[1]
    yield (start, end)

def extract(text, standoff, tag, ignore_tags):
    span = first(get_spans(tag, standoff))
    ignore = []
    for t in ignore_tags:
        for s in get_spans(t, standoff):
            if span_contains(span, s):
                ignore.append(s)
    result = ''
    for (start, end) in keep_spans(span, ignore):
        result += text[start:end]
    return result

def extract_body(text, standoff):
    return extract(text, standoff, 'body', ['title', 'table-wrap', 'fig'])

def extract_abstract(text, standoff):
    return extract(text, standoff, 'abstract', ['title', 'table-wrap', 'fig'])

if __name__ == '__main__':
    textfn = sys.argv[1]
    sofn = sys.argv[2]

    with open(textfn) as f:
        text = f.read()

    with open(sofn) as f:
        standoff = f.read()

    print extract_body(text, standoff)
