#!/bin/sh -e
url=$1
shift
branches=("$@")
repo_name=${url##*/}
repo_name=${repo_name%.git}

git clone --depth=1 "$url"

cd "$repo_name"

main_branch=$(git symbolic-ref --short HEAD)

for branch_name in "${branches[@]}"; do
  git switch --orphan "$branch_name"
  git remote set-branches --add origin "$branch_name"
  git pull --depth=1 --set-upstream origin "$branch_name"
done

git switch "$main_branch"
