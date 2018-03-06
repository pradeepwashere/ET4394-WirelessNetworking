#!/bin/bash

words=$(cat finaldatamrt_05_2018.txt | wc -l)
chars=$(cat finaldatamrt_05_2018.txt | wc -m)

avg_word_size=$(( ${chars} / ${words} ))
echo "Total number of unique SSIDs: ${words}" >> statistics.txt
echo "Average SSID length is: ${avg_word_size}" >> statistics.txt

