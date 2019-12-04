dot_configs="$(ls -l config | awk ' { print $9 } ')"
dot_home_files="$(ls -la home | awk ' { print $9 } ' | sed 's|^.$||g' | sed 's|^..$||g' | sed '/^\s*$/d')"
BACKUP=$1

handle_prev_file () {
	if [ "$BACKUP" = '--no-backup' ]
	then
		rm "$1"
	else
		mv "$1" "$2"
	fi
}

for dot_config in $dot_configs
do
	if [ -e ~/.config/$dot_config ]
	then
		handle_prev_file ~/.config/"$dot_config" ~/.config/"$dot_config".bak
	fi
	ln -s $(realpath config/"$dot_config") ~/.config/"$dot_config"

	if  [ -e config/"$dot_config/$dot_config" ]
	then
		rm  $(realpath config/"$dot_config/$dot_config")
	fi
done

for dot_files in $dot_home_files
do
	if [ -e ~/$dot_files ]
	then
		handle_prev_file ~/"$dot_files" ~/"$dot_files".bak
	fi

	ln -s $(realpath home/"$dot_files") ~/"$dot_files"

	if [ -e home/"$dot_files/$dot_files" ]
	then
		rm  $(realpath home/"$dot_files/$dot_files")
	fi
done
