#!/bin/fish

function print_info
  set dirname (string replace /mnt/Data/gitapps/ '' $argv[1] | string split /)
  set_color -o brcyan
  if test $dirname[2]
    echo -n $dirname[2]
    set_color normal
    set_color f00
    if string match -q AUR $dirname[1]
      set_color fb0
    end
    echo " [$dirname[1]]"
  else
    echo $dirname
  end
  set_color normal
end

set first true
for dir in /mnt/Data/gitapps/foreign/* /mnt/Data/gitapps/AUR/* /mnt/Data/gitapps/*
  if [ -d $dir/.git ]
    cd $dir
    set git_status (git status)
    set git_status_short (git status -s)
    if string match -q 'Your branch is ahead*' $git_status[2]
    or string match -q 'Your branch is behind*' $git_status[2]
    or test -n "$git_status_short"
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
