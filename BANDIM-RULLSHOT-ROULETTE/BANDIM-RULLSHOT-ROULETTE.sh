set -euo pipefail

echo "ROULETTE" #Ironically a field I'm good in
# This script was made to inflict pain

chips=500
current_bet=0
my_bet=1

while true;
do
	clear
	echo "$chips Chips"
	echo "Current Bet: $current_bet"

	read -p "Input: " input || break

	if [[ "$input" == "red" ]]; then 
		my_bet = "$input"
	fi

	if [[ "$input" == "black" ]]; then
		my_bet="$input"
	fi

	if [[ "$input" =~ ^[0-9]+$ ]] && (( input > 0 && input <= 30 )); then
		my_bet="$input"
	fi

	if [[ "$input" == "raise" ]] && (( chips >= 20 )); then
		current_bet=$(( current_bet+20 ))
		chips=$(( chips-20 ))
	fi
	
	if [[ "$input" == "lower" ]] && (( current_bet >= 20 )); then
		current_bet=$(( current_bet-20 ))
		chips=$(( chips+20 ))
	fi

	if [[ "$input" == "help" ]]; then
		printf "Commands\n\t-help\n\t-raise\n\t-lower\n\t-place\n\t-1-30"
	fi

	if [[ "$input" == "place" ]]; then
		echo "You bet $current_bet on $my_bet"

		roll=$(( RANDOM%30+1 ))

		if [[ "$my_bet" == "$roll" ]]; then
			echo "You won $current_bet chips"
			chips=$(( chips+current_bet*2 ))
		elif [[ "$my_bet" == "red" ]] && [[ roll % 2 == 1 ]]
			echo "You won $current_bet chips"
			chips=$(( chips+current_bet*2 ))
		elif [[ "$my_bet" == "black" ]] && [[ roll % 2 == 0 ]]
			echo "You won $current_bet chips"
			chips=$(( chips+current_bet*2 ))
		else
			echo "You lost"
		fi
		
		current_bet=0
	fi
done
