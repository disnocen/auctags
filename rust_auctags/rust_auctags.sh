#!/bin/sh

crates_folder="/home/disnocen/.cargo/registry/src/github.com-1ecc6299db9ec823"

# dependencies=$(sed -n /[dependencies]/, Cargo.toml| grep -v dependencies | tr -d '"'|awk -F" = " '{print "/home/disnocen/.cargo/registry/src/github.com-1ecc6299db9ec823/"$1"-"$2)
# sed -n '/\[dependencies\]/,$p' Cargo.toml| grep -v dependencies | tr -d '"'|awk -F" = " '{print "/home/disnocen/.cargo/registry/src/github.com-1ecc6299db9ec823/"$1"-"$2"/src"}' > .tags_file_list.txt

[ -f "Cargo.toml" ] || (echo "no Cargo.toml file" && exit 1)
# get name and version of libraries needed
crates_names=$(sed -n '/\[dependencies\]/,$p' Cargo.toml| grep -v dependencies | tr -d '"'|awk -F" = " '{print $1":"$2}')
echo "crates names are"
echo $crates_names

# identify the directory and  add it to the list of files
# TODO: create subroutine and remove redundant code
for i in $crates_names; do
    dir_name=$(echo $i|cut -d":" -f1)
    ver_num=$(echo $i|cut -d":" -f2)


    echo "current dirname is $dir_name"
    echo "current vernum is $ver_num"

    if [ "$ver_num" = "{" ]; then
        # get the whole line in Cargo.toml
        # if path, then that is the path
        echo "bad version num"
        dep=$(grep $dir_name Cargo.toml)
        if [ -n "$(echo $dep| grep path)" ];then
            dep_dir=$(echo $dep| tr "," "\n"|grep -o "path.*\""|grep -o "\".*\""|tr -d '"')
            echo "$dep_dir" >> .tags_file_list.txt
        elif [ -n "$(echo $dep| grep version)" ];then
            # TODO: this block should be a subroutine
            ver_num=$(echo $dep| tr "," "\n"|grep -o "version.*\""|grep -o "\".*\""|tr -d '"')
            if [ -d $crates_folder/$dir_name-$ver_num ]; then
                echo "$crates_folder/$dir_name-$ver_num/src" >> .tags_file_list.txt
            else
                dir_found=$(ls $crates_folder| grep $dir_name- |head -n1)
                if [ -n "$dir_found" ]; then
                    echo "$crates_folder/$dir_found/src" >> .tags_file_list.txt
                fi
        fi
        else
            echo "Neither 'path' nor 'version' present in $dep"
        fi
    else
        # TODO: this block should be a subroutine
        # if that version exists add it to lists
        if [ -d $crates_folder/$dir_name-$ver_num ]; then
            echo "$crates_folder/$dir_name-$ver_num/src" >> .tags_file_list.txt
        else
            dir_found=$(ls $crates_folder| grep $dir_name- |head -n1)
            if [ -n "$dir_found" ]; then
                echo "$crates_folder/$dir_found/src" >> .tags_file_list.txt
            fi
        fi
    fi
done
echo "." >> .tags_file_list.txt

uctags -R -L .tags_file_list.txt
rm -f .tags_file_list.txt
