#!/bin/bash

let st=0
let sw=0

for i in {1..100}
do
    #create 3 doors
    door[1]="win"
    door[2]="lose"
    door[3]="lose"

    x=$((RANDOM % 3 + 1)) #pick a random door
    p=${door[$x]} #save players choice
    door=(${door[@]:0:$x} ${door[@]:$(($x + 1))}) #remove players choice from array

    #check remaining 2 doors
    a=${door[1]}
    b=${door[2]}
    #if either door is a winner switching will win
    if [ "$a" = "win" ] || [ "$b" = "win" ]
    then
        z="win"
        let sw+=1
    else
        z="lose" #if both are lose then switching will lose
        let st+=1
    fi

    #display out come
    echo "$p -- $z"
done

echo "switching wins $sw% of the time"
echo "staying wins $st% of the time"
