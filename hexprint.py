#!/usr/bin/python3

import sys
import itertools
from pathlib import Path
import string


def printhex_content(content: bytes):
    size = len(content)

    for chunk in itertools.batched(content, 20):
        for pair in itertools.batched(chunk, 2):
            for char_int in pair:
                print("%0.2X" % char_int, end=" ")
        print(" " * 3 * (20 - len(chunk)), end='\t')
        for char_int in chunk:
            if char_int == 0:
                char = "ɸ"
            elif char_int == 10:
                char = "⏎"
            elif char_int in string.printable.encode("ascii"):
                char = chr(char_int)
            else:
                char = "⍰"
            print(char, end="")
        print()

def printhex_filename(filename: str, print_filename: bool):
        if print_filename:
            print('\033[1;34m' + filename + "\033[0m" + ":")

        with open(filename, 'rb') as f:
            printhex_content(f.read())

def main():

    if len(sys.argv) <= 1:
        pass
    elif len(sys.argv) == 2:
        printhex_filename(sys.argv[1], print_filename=False)
    else:
        printhex_filename(sys.argv[1], print_filename=True)
        for filename in sys.argv[2:]:
            print()
            printhex_filename(filename, print_filename=True)

if __name__ == '__main__':
    main()
