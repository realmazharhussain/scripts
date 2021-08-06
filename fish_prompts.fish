#!/bin/fish
set n 1
for prompt in /usr/share/fish/tools/web_config/sample_prompts/*
  echo -n "$n. "; basename $prompt | sed 's/.fish$//g'
  source $prompt
  fish_prompt
  echo
  set n (math $n+1)
end
