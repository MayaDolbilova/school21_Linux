#!/bin/bash
chmod +x print_func.sh
source print_func.sh
print_func

read -p "Do you want to save the data in a file? (Y/N):" answer
if [[ $answer == Y ]] || [[ $answer == y ]]; then
	filename="$(date +"%d_%m_%y_%H_%M_%S").status"
        print_func >> $filename
        echo 'Saving is completed'
else
        echo 'We will not save your file'
fi
