echo "Starting..."

# backup and copy
files=`ls -a | sed -e 's/README.md//' | sed -e 's/LICENSE//' | sed -e 's/.git//' | sed -e 's/setup.sh//'`
for entry in $files
do
	if [ -f "$entry" ];then
		if [ -f "$HOME/$entry" ]
		then
			mv "$HOME/$entry" "$HOME/$entry.bak"
		fi
		ln -s $(realpath "$entry") "$HOME/$entry"
	elif [[ -d "$entry" && "$entry" != "." && "$entry" != ".." ]];then
		if [ "$entry" == ".vim" ];
		then
			if [ -d "$HOME/$entry" ]
			then
				mv "$HOME/$entry" "$HOME/$entry.bak"
			fi
			ln -s $(realpath "$entry") "$HOME/$entry"
		fi

		if [ -d "$HOME/.config/$entry" ]
		then
			mv "$HOME/.config/$entry" "$HOME/.config/$entry.bak"
		fi
		ln -s $(realpath "$entry") "$HOME/.config/$entry"
		rm "$entry/$entry"

	fi
done
