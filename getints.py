#!/usr/bin/env python3
def getints (string, *, size=4):
    str_bytes = string.encode()
    count, remaining = divmod(len(str_bytes), size)

    int_list = []
    for i in range(count):
        int_list += [int.from_bytes(str_bytes[i*size:(i+1)*size], 'little')]
    int_list  += [int.from_bytes(str_bytes[count*size:], 'little')]

    return int_list

from sys import argv
if len(argv) == 3:
    print(*getints(argv[1], size=int(argv[2])), sep=', ')
elif len(argv) == 2:
    print(*getints(argv[1]), sep=', ')
else:
    print(1801680198, 1717989152, 33, sep=', ')
