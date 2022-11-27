#!/bin/sh -e
url=$1
shift
branches=("$@")
repo_name=${url##*/}
repo_name=${repo_name%.git}
repo_dir=${PWD}/${repo_name}

if test -n "$branches"; then
  main_branch="${branches[0]}"
  mkdir "$repo_dir"
  cd "$repo_dir"
  
  git init
  git remote add origin "$url" -t "$main_branch"

  "$(dirname $0)"/branch-grafted.sh "${branches[@]}"

  if test ${#branches[@]} -gt 1; then
    git switch "$main_branch"
  fi

else
  git clone --depth=1 "$url"
fi
