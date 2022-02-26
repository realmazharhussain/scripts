# vim:fdm=marker foldlevel=0 tabstop=2 shiftwidth=2 filetype=fish

set dirs
for dir in ~/gitapps/AUR/*
  if test -d $dir/.git
  and test -f $dir/PKGBUILD
    set -a dirs (basename $dir)
  end
end

complete -x -c update-aur-pkg -n "not __fish_seen_subcommand_from --git $dirs" -ka "--git $dirs"
