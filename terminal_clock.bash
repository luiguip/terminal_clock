#!/bin/bash

#ASCII Clock for terminal
#
#Author: Luigui
#
#I created this bash clock to study bash and have a clock to start the
#terminal.
#You can customize changing the bits to display what you want. If you
#want to change the height and width you have to change the number
#design too.

#Versions
#V.1.0 Customizable terminal clock


##Constants

#colors
green="\e[1;42m"
endcolor="\e[0m"

#bits
void=" "
on="#"
twopoints="O"

#padrons
line="$void$on$on$on$void"
left="$void$on$void$void$void"
right="$void$void$void$on$void"
both="$void$on$void$on$void"

#sizes
height=5
width=5

#numbers design
zero="$line$both$both$both$line"
one="$right$right$right$right$right"
two="$line$right$line$left$line"
three="$line$right$line$right$line"
four="$both$both$line$right$right"
five="$line$left$line$right$line"
six="$line$left$line$both$line"
seven="$line$right$right$right$right"
eight="$line$both$line$both$line"
nine="$line$both$line$right$line"
dots="$void$twopoints$void$twopoints$void"

#initialize array hour
actual_hour=""

#setting array actual hour
set_hour(){
	number=""
	case $1 in
		0) number=${zero} ;;
		1) number=${one} ;;
		2) number=${two} ;;
		3) number=${three} ;;
		4) number=${four} ;;
		5) number=${five} ;;
		6) number=${six} ;;
		7) number=${seven} ;;
		8) number=${eight} ;;
		9) number=${nine} ;;
		*) exit 1 ;;
	esac
	actual_hour+=$number
}

#get date
get_date(){
	actual_hour=""
	hour="$(date +%H%M%S)"
	for n in `seq 0 5`
	do
		set_hour ${hour:$n:1}
	done
}
#display numbers
display(){
	get_date
	ascii_hour=""
	for i in `seq 0 $(($height-1))`
	do

		for j in `seq 0 5` #format +%H:%M:%S
		do
			x="$i*$width"
			y="$j*$width*$height"
			ascii_hour+="${actual_hour:$x+$y:$width}"
			
			if test $j -eq 1 || test $j -eq 3
			then
				ascii_hour+="${dots:$i:1}"

			fi
		done
		if test $i -ne $(($height-1))
		then
			ascii_hour+="\n"
		fi
	done

	#inserting colors
	ascii_hour=${ascii_hour//[$on|$twopoints]/${green} ${endcolor}}
	echo -e "${ascii_hour}" 
}

#routine
d="$(date +%H%M%S)"

while test 1 -eq 1
do
	actual="$(date +%H%M%S)"
	if test $d -ne $actual
	then
		clear
		display
		d=$actual
	fi
done
