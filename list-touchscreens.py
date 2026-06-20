#!/usr/bin/python

import sys
import subprocess
import gi

gi.require_version("GUdev", "1.0")

from pathlib import Path
from gi.repository import GUdev

def show_help():
    name = Path(sys.argv[0]).name
    help = '\n'.join((
        f"Usage: {name} [OPTION]",
        "",
        "OPTIONS:",
        "  -h,--help       Show this help message",
        "  -l,--list       List available touchscreen devices",
        "  -d,--disable    Disable all touchscreen devices",
        "  -r,--reset      Reset touchscreen drivers (Re-enables all touchscreen devices)",
    ))
    print(help)

def get_touchscreens():
    client = GUdev.Client.new(['hid', 'input'])
    inputs = client.query_by_subsystem('input')
    hid_touchscreens = [
        x.get_parent_with_subsystem('hid')
        for x in inputs
        if x.get_property_as_boolean('ID_INPUT_TOUCHSCREEN')
    ]
    named_touchscreens = dict([x.get_name(), x] for x in hid_touchscreens)
    return named_touchscreens

def print_touchscreens():
    names = get_touchscreens().keys()
    if len(names) > 0:
        print(*get_touchscreens().keys(), sep="\n")

def disable_touchscreens():
    retval = 0
    for (name, item) in get_touchscreens().items():
        path = Path(item.get_sysfs_path()) / 'driver' / 'unbind'
        retval += subprocess.run(f"sudo sh -c 'echo {name} > {path}'", shell=True).returncode
    return retval

def reset_touchscreens():
    res = subprocess.run('sudo modprobe -r hid-multitouch && sudo modprobe hid-multitouch', shell=True)
    return res.returncode

def main():
    if len(sys.argv) > 2:
        show_help()
        return

    if len(sys.argv) == 1:
        print_touchscreens()
        return

    match sys.argv[1]:
        case '-l' | '--list':
            print_touchscreens()
        case '-d' | '--disable':
            return disable_touchscreens()
        case '-r' | '--reseet':
            return reset_touchscreens()
        case _:
            show_help()

if __name__ == '__main__':
    sys.exit(main())
