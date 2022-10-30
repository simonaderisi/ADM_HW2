#!/bin/sh

#initialize the iterators
READ=0
ITER=2

#iterate while you haven't found 10 descriptions longer than 100 characters
while (($READ < 10))
do
    #take the iter-nth row
    cat instagram_posts.csv | head -$ITER | tail -1  > line
    #cut the description
    descr=$(cut -f8 line)
    
    #check the length of the description
    if ((${#descr} >= 100))
    then
    #cut the user
        USER=$(cut -f 4 line)
        #if you find the profile, print all the infos, if not print user not foun
        if PROFILE=$(grep $USER instagram_profiles.csv)
        then
            echo $PROFILE
        else
            echo "User not found!"
        fi

        let "READ += 1"
    fi

    let "ITER += 1"
    rm line
done
