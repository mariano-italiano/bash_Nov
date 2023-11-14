NUMBERS=(1 2 3 "Anna K." "Mateusz Z.")
osoby=("Anna K." "Mateusz Z.")

for i in $(seq 1 5)
do
	echo $i
done

for (( i=1; i<=5; i++ ))
do
	echo $i
done

#########################

for (( i=0; i<=${#osoby[@]}; i++ ))
do
	echo "${osoby[$i]}"
done


MATCH=0
for i in "${osoby[@]}"
do 
	if [[ $MATCH -eq 0 ]]; then
		for j in "${NUMBERS[@]}"
		do 
			if [[ $i == $j ]]; then 
				echo "Mamy match: $i"
				MATCH=1
				break;

			else 
				echo "Brak zgodnosci"
				continue;
			fi  
		done 
	else
		echo "Skipuje element $i"
		continue;
	fi
done
