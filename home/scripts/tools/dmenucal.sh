exp=$(echo -ne "HISTORY(h)\nTERM(t)\nPYTHON(py)" | dmenu -p "CALCULATE:")
if [ "$exp" = "TERM(t)" ]
then
        urxvt -e bc
elif [ "$exp" = "PYTHON(py)" ]
then
        urxvt -e python
elif [ -n "$exp" ]
then
        ans=$(echo "$exp" | bc -l)
        option=$(echo -ne "exit\ncopy" | dmenu -p "ANS: $ans")
        if [ "$option" = "copy" ]
        then
                echo -ne "$ans" | xclip -i -selection clipboard
        fi
else
        exit
fi
