#!/usr/bin/python

import sys
import subprocess
import gi

gi.require_version("GUdev", "1.0")

from pathlib import Path
from gi.repository import GUdev

name = Path(sys.argv[0]).name

def show_help():
    help = '\n'.join((
        f"Usage: {name} [COMMAND]",
        "",
        "COMMANDS:",
        "  h,help       Show this help message",
        "  l,list       List available touchscreen devices [default]",
        "  d,disable    Disable all touchscreen devices",
        "  r,reset      Reset touchscreen drivers (Re-enables all touchscreen devices)",
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
#    if len(sys.argv) > 2:
#        print("Unrecognized arguments!")
#        print(f"Run `{name} help` for usage information")
#        return 1
#    elif len(sys.argv) == 1 or 'list'.startswith(sys.argv[1]):
#        print_touchscreens()
#    elif 'disable'.startswith(sys.argv[1]):
#        return disable_touchscreens()
#    elif 'reset'.startswith(sys.argv[1]):
#        return reset_touchscreens()
#    elif 'help'.startswith(sys.argv[1]) or sys.argv[1] in ('-h', '--help'):
#        show_help()
#    else:
#        print("Unknown argument:", sys.argv[1])
#        print(f"Run `{name} help` for usage information")
#        return 1
#
#    return 0

    if len(sys.argv) > 2:
        print("Too many arguments!")
        print(f"Run `{name} help` for usage information")
        return 1

    if len(sys.argv) == 1:
        print_touchscreens()
        return

    match sys.argv[1]:
        case x if 'list'.startswith(x):
            print_touchscreens()
        case x if 'disable'.startswith(x):
            return disable_touchscreens()
        case x if 'reset'.startswith(x):
            return reset_touchscreens()
        case x if 'help'.startswith(x) or x in ('-h', '--help'):
            show_help()
        case x:
            print("Unknown argument:", x)
            print(f"Run `{name} help` for usage information")
            return 1

if __name__ == '__main__':
    sys.exit(main())
