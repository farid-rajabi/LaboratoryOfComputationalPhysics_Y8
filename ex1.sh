#!/bin/bash

# 1.a
# cd $HOME
cd ./03ex_Bash/
mkdir ./students/
if [ -e ./students/students.csv ]; then
    echo "file already exists"
else
    wget https://www.dropbox.com/s/867rtx3az6e9gm8/LCP_22-23_students.csv -O students.csv
    cp ./students.csv ./students/
fi

# 1.b
cd ./students/
grep "Physics" ./students.csv > ./students_physics.csv
grep "PoD" ./students.csv > ./students_pod.csv
sed -i 's/\n//g' <<< cut -c-1 ./students_physics.csv

# 1.c 1.d
mostChar='A'
mostRep=0
for x in {A..Z}; do
    rep=$(awk 'NR>1' ./students.csv | grep -c "^${x}")
    echo $x $rep
    if [ "$rep" -ge "$mostRep" ]; then
        mostChar=$x
        mostRep=$rep
    fi
done
echo "Mostly repeated:" $mostChar $mostRep

# 1.e
linesCount=$(awk 'NR>1' ./students.csv | wc -l)
for i in {1..18}; do
    for j in $(seq $i 18 $linesCount); do
        sed -n "$((${j}+1))p" ./students.csv >> "./group_${i}.csv"
    done
done
