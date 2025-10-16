#! /bin/bash


#set a counter equal to zero
COUNTER1=0
COUNTER2=10


#while the value of my counter is less than 150
while [ $COUNTER -lt 150 ]
do 
	my_array[$COUNTER1]=$COUNTER2 #populate the element with the value 0>
	echo ${my_array[$COUNTER1]} >> my_arraylist2.txt #echo value of th>
	let COUNTER1=COUNTER1+1 #increase the couunter by 1
done #close the while loop 
