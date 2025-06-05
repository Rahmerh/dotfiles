#!/bin/bash

cal=$(LC_ALL="en_US.UTF-8" cal | sed -E ':a;N;$!ba;s/\r{0,1}\n/\\\\n/g' | grep --color -EC6 "\b$(date +%e | sed "s/ //g")")

printf "{\"text\": \"$cal\"}"
