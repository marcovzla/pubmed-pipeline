#!/usr/bin/env python

# extracts protein information from uniprot_sprot.dat.gz
# and dumps it as json to stdout

# usage: zcat uniprot_sprot.dat.gz | ./getprotdata.py > uniprot.json

import re
import json
import fileinput
from collections import defaultdict

data = []
datum = defaultdict(list)

for line in fileinput.input():
    if line.startswith('ID'):
        bits = line.split()
        datum['id'] = bits[1]

    elif line.startswith('AC'):
        datum['accession'] = line[2:].strip()

    elif line.startswith('DE'):
        m = re.search(r'(?:Full|Short)=([^;]+);', line)
        if m:
            name = m.group(1)
            datum['protein'].append(name)

    elif line.startswith('GN'):
        m = re.search(r'Name=([^;]+);', line)
        if m:
            name = m.group(1)
            datum['gene'].append(name)

        m = re.search(r'Synonyms=([^;]+);', line)
        if m:
            syns = m.group(1).split(', ')
            datum['gene'] += syns

    elif line.startswith('OS'):
        datum['organism'] = line[2:].strip()

    elif re.search(r'^\s*//\s*$', line): # can this line contain spaces?
        data.append(datum)
        datum = defaultdict(list)

print json.dumps(data)

