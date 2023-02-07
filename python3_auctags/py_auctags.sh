#!/bin/sh

python_version='3.9'
libs_folder="$HOME/.local/lib/python$python_version/site-packages"
libs_general_folder="/usr/local/lib/python$python_version"

libs_names=$(grep -e "^import" -e "^from .* import " *.py|cut -d" " -f2)

echo "libs names are"
echo $libs_names

for name in $libs_names; do
    # check if in libs_folder
    if [ "$(ls $libs_folder | grep -w $name)" ]; then
        real_name=$(ls $libs_folder | grep -w $name |grep -v dist-info)

        if [ -d "$libs_folder/$real_name" ];then
            # if the file is a directory, add all the py files
           for i in $libs_folder/$real_name/*py;do
                echo $i >> .tags_file_list.txt
            done
        else
            echo $libs_folder/$real_name >> .tags_file_list.txt
        fi

    # check if in libs_general_folder
    elif [ "$(ls $libs_general_folder | grep -w $name)" ]; then
        real_name=$(ls $libs_general_folder | grep -w $name |grep -v dist-info)
        if [ -d "$libs_general_folder/$real_name" ];then
            # if the file is a directory, add all the py files
           for i in $libs_general_folder/$real_name/*py;do
                echo $i >> .tags_file_list.txt
            done
        else
            echo $libs_general_folder/$real_name >> .tags_file_list.txt
        fi
    else
        #nowhere to be found
        echo $name not found in $libs_folder and $lib_general_folder
    fi
done


# echo $libs_names >> .tags_file_list.txt
echo "." >> .tags_file_list.txt

uctags -R -L .tags_file_list.txt
cat .tags_file_list.txt
rm -f .tags_file_list.txt
