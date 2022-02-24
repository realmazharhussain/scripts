#!/bin/fish

function format_info
  set dirname (string replace ~/gitapps/ '' $argv[1] | string split /)
  if test $dirname[2]
    echo $dirname[2]
    echo "[$dirname[1]]"
  else
    echo $dirname
  end
end

function colorized_info
  set formatted_info (format_info $argv[1])
  set_color -o brcyan
  echo $formatted_info[1]
  set_color normal
  set_color f00
  if string match -q [AUR] $formatted_info[2]
    set_color bryellow
  end
  echo $formatted_info[2]
  set_color normal
end

function print_info
  set colorized_info (colorized_info $argv[1])
  echo -n $colorized_info
end

set up_to_date_dirs
set dirty_dirs

for dir in ~/gitapps/foreign/* ~/gitapps/AUR/* ~/gitapps/*
  if [ -d $dir/.git ]
    cd $dir
    set git_status (git status)
    if string match -q 'Your branch is ahead*' $git_status[2]
    or string match -q 'Your branch is behind*' $git_status[2]
    or test (git status -s)
      set -a dirty_dirs $dir
    else
      set -a up_to_date_dirs $dir
    end
  end
end

for dir in $up_to_date_dirs
  set colorized_info (colorized_info $dir)
  echo -n {$colorized_info[1]}\t
  set_color -o brgreen
  echo -n '(up to date)'\t
  echo -n {$colorized_info[2]}
  set_color normal
  echo
end | column --table --separator=\t

for dir in $dirty_dirs
  cd $dir
  echo
  print_info $dir
  echo
  git status -sb
end
