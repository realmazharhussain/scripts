#!/bin/fish

function print_info
  set dirname (string replace ~/gitapps/ '' $argv[1] | string split /)
  set_color -o brcyan
  if test $dirname[2]
    echo -n $dirname[2]
    set_color normal
    set_color f00
    if string match -q AUR $dirname[1]
      set_color bryellow
    end
    echo " [$dirname[1]]"
  else
    echo $dirname
  end
  set_color normal
end

set first true
for dir in ~/gitapps/foreign/* ~/gitapps/AUR/* ~/gitapps/*
  if [ -d $dir/.git ]
    cd $dir
    set git_status (git status)
    if string match -q 'Your branch is ahead*' $git_status[2]
    or string match -q 'Your branch is behind*' $git_status[2]
    or test (git status -s)
      if $first
        set first false
      else
        echo
      end
      print_info $dir
      git status -sb
    end
  end
end
