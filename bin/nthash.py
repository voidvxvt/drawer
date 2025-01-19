#!/usr/bin/python3

import hashlib
import sys

rc4hash = lambda x : hashlib.new('md4',x.encode('utf-16le')).hexdigest().lower()
print(rc4hash(sys.argv[1]))
