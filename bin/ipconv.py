#!/usr/bin/env python3

import sys

def ip2hex(ip):
    return "".join([hex(int(x))[2:].zfill(2) for x in ip.split('.')])

def ip2dec(ip):
    return int(ip2hex(ip),16)

def ip2oct(ip):
    return '0' + oct(ip2dec(ip))[2:]

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("usage: ./ipconv.py <IPv4 Address>")
        exit(0)

    ip = sys.argv[1]
    
    print(f"ip2hex:\t{ip2hex(ip)}")
    print(f"ip2dec:\t{ip2dec(ip)}")
    print(f"ip2oct:\t{ip2oct(ip)}")
