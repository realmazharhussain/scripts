#!/bin/fish
for prompt in /usr/share/fish/tools/web_config/sample_prompts/*
  source $prompt
  fish_prompt
  basename $prompt | sed 's/.fish$//g'
end
