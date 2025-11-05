#!/bin/bash

# 2.a
cd ./03ex_Bash/
# grep -v "^#" ./data.csv > ./data.txt
# sed -i 's/,//g' ./data.txt

CountEven=0
CountLarger=0
CountSmaller=0
while read line; do
    # 2.b
    # split each line with space and newline
    for num in $(echo "$line" | tr " " "\n"); do
        if [ $(($num % 2)) -eq 0 ]; then
            let "CountEven++"
        fi
    done
    # 2.c
    # turn a string of nums separated by space into an array
    nums=( $line )
    tmp=$(echo "sqrt(${nums[0]}^2 + ${nums[1]}^2 + ${nums[2]}^2)" | bc)
    if [ $tmp -gt $(echo "100 * sqrt(3) / 2" | bc) ]; then
        let "CountLarger++"
    else
        let "CountSmaller++"
    fi
    # 2.d
    # from 1...up to the user input
    for i in $(seq 1 1 $1); do
        NumsDivided=""
        # loop over each num in a line
        for num in "${nums[@]}"; do
            numsDivided=$(echo "$(($num / $i))")
            NumsDivided="${NumsDivided} ${numsDivided}"
        done
        echo $NumsDivided >> "./data_${i}.txt"
    done
done < ./data.txt
echo "${CountEven} even numbers"
echo "${CountLarger} larger"
echo "${CountSmaller} smaller"
