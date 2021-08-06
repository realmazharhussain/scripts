#!/bin/fish
for dir in ~/gitapps/*
               if [ -d "$dir"/.git ]
                   cd "$dir"
                   fish_prompt 
                   echo
                   git status
               end
           end
