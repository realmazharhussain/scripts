#!/bin/sh -e
for branch_name in "$@"; do
  git switch --orphan "$branch_name"
  git remote set-branches --add origin "$branch_name"
  git pull --depth=1 --set-upstream origin "$branch_name"
done
