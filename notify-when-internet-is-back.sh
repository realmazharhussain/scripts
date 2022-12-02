#!/usr/bin/bash
server=google.com
interval=10s
title='Internet Connection Status'
message='Internet is back.'

pretty_name=$(basename "$0")
if [[ "$(realpath "$(type -P "$pretty_name")")" = "$(realpath "$0")" ]]; then
  usage_name="$pretty_name"
else
  usage_name=$(realpath -s --relative-base=$PWD "$0")
  if [[ "$usage_name" != /* ]]; then
    usage_name=./"$usage_name"
  fi
fi

usage() {
  echo -n "Show a desktop notification when internet is available
Usage: $usage_name [OPTIONS]

Options:
    -h,--help                 Show this help message
    -i,--interval INTERVAL    Wait INTERVAL seconds before rechecking the connection
    -m,--message MESSAGE      Use MESSAGE as notification text
    -s,--server SERVER        Ping SERVER instead of google.com
    -t,--title TITLE          Use TITLE as notification title
"
}

TEMP=$(getopt \
       -n "$pretty_name" \
       -o 'hi:m:s:t:' \
       --long 'help,interval:,message:,server:,title:' \
       -- "$@")

retval=$?

if [ $retval -eq 1 ]; then
  echo "Use '--help' for usage information" >&2
  exit 1
elif [ $retval -gt 1 ]; then
	echo 'Terminating...' >&2
	exit 1
fi

eval set -- "$TEMP"
unset TEMP

while true; do
	case "$1" in
		'-h'|'--help')
			usage
		  exit 0
		;;
		'-s'|'--server')
		  server=$2
			shift 2
			continue
		;;
		'-i'|'--interval')
		  interval=$2
			shift 2
			continue
		;;
		'-m'|'--message')
		  message=$2
			shift 2
			continue
		;;
		'-t'|'--title')
		  title=$2
			shift 2
			continue
		;;
		'--')
			shift
			break
		;;
		*)
			echo 'Internal error!' >&2
			exit 1
		;;
	esac
done

if test -n "$*"; then
  echo 'Positional arguments are not allowed!' >&2
  exit 1
fi


while ! ping -c 1 "$server" &>/dev/null; do
  sleep "$interval"
done

notify-send "$title" "$message"
