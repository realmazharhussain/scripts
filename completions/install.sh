#!/bin/sh
progDir=$(dirname "$0")

sudo cp "$progDir"/*.fish -t /etc/fish/completions/
