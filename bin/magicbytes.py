#!/usr/bin/python3

import sys

magic_byte_type_dict = {
    "pdf":  "25 50 44 46 2D 31 2E 33 0A 25",
    "jpg":  "FF D8 FF E0",
    "png":  "89 50 4E 47 0D 0A 1A 0A",
    "gif":  "47 49 46 38 37 61",
    "zip":  "50 4B 03 04",
    "rar":  "52 61 72 21 1A 07 00",
    "7z":   "37 7A BC AF 27 1C",
    "mp3":  "49 44 33",
    "mp4":  "00 00 00 18 66 74 79 70 69 73 6F 6D",
    "flac": "66 4C 61 43",
    "pdf":  "25 50 44 46 2D 31 2E 35 0A 25",
}

if len(sys.argv) > 2:
    magic_type = sys.argv[1].lower()
    file_path = sys.argv[2]
else:
    print("usage: htb-magic.py [magic_type] [file_path]")
    [print(f'  {k}\t{v}') for k,v in magic_byte_type_dict.items()]
    exit(1)

selected_magic_byte = magic_byte_type_dict[magic_type]
file_content = b""

with open(file_path, "rb") as file:
    file_content = file.read()

with open(file_path, "wb") as file:
    file.write(bytes.fromhex(selected_magic_byte))
    file.write(b"\n")
    file.write(file_content)

print(f"Magic byte {magic_type} written to file: {file_path}")
