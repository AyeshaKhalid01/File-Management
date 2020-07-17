#!/bin/bash
find .. -name "*.sh" -type f
echo "These are the features you want to use, enter the corrsponding number: "
echo "1. FIXME"
echo "2. Find Tag"
echo "3. File Type Count"
echo "4. Word and Vowel Count"
echo "5. Palindrome log"
echo "6. Switch to Executable"
echo "7. Backup and Delete/Restore"
read input
IFS=$'/n'

if [ $input -eq 1 ] ; then
	if [ -f fixme.log ] ; then
		rm fixme.log
	fi
	IFS=$'\n'
	for file in $( find .. -type f ) ; do
		if [ $( tail -n 1 "$file" | egrep "*#FIXME" ) ] ; then
			echo "$file" >> fixme.log
                fi
	done
fi

if [ $input -eq 2 ] ; then
	echo "Please enter a single word"
	read userInput
	if [ -f "$userInput".log ] ; then
                rm "$userInput".log
        fi
	IFS=$'\n'
	for f in $( find .. -name "*.py" -type f ); do
		commentPy=`cat "$f" | grep '^#' | grep "$userInput"`
		echo "$commentPy" >> "$userInput".log
	done
fi

if [ $input -eq 3 ] ; then
	echo "Type in the extension of the file you want example py"
	read extension
	count=$( find .. -name "*.$extension" -type f | wc -l )
	echo "There are $count files with that extension"
fi

if [ $input -eq 4 ] ; then
        echo "Enter the name of a text file without the txt extension or quotation example a file"
        read fileInput
        fileInput=$(find .. -name "$fileInput.txt" -type f)
        wordCount=$( wc -w < "$fileInput" )
        echo "There are $wordCount words in the file"
        vowelCount=0
        while read line; do
                for ((i=0 ; i < ${#line} ; i++)) ; do
                        line=${line,,}
                        if [ ${line:i:1} == "a" ] || [ ${line:i:1} == "e" ] || [ ${line:i:1} == "i" ] || [ ${line:i:1} == "o" ] || [ ${line:i:1} == "u" ] ; then
                                vowelCount=$(( $vowelCount + 1 ))
                        fi
                done
        done < "$fileInput"
        echo "There are $vowelCount vowels in this file"
fi

if [ $input -eq 5 ] ; then
        echo "Enter the name of a text file without the txt extension or quotation marks for example a file"
        read userInput
        if [ -f palindrome.log ] ; then
                        rm palindrome.log
        fi
        userInput=$(find .. -name "$userInput.txt" -type f)
        while read line; do
                aline=$(echo "$line" | tr -d ' ' | tr -d '[:punct:]' )
                aline=${aline,,}
                revS=$(echo "$aline" | rev)
                if [ "$revS" == "$aline" ]; then
                        echo "Yes $line is a palindrome after you remove any spaces or punctuation" >> palindrome.log
                fi
        done < "$userInput"
fi

if [ $input -eq 6 ] ; then
	echo "Please type in the corresponding command based on if you want to change or restore the permissions on the files: "
 	echo "1. Change"
	echo "2. Restore"
	read userInput
	IFS=$'\n'
	if [ $userInput -eq 1 ] ; then
		if [ -f permissions.log ] ; then
               		rm permissions.log
        	fi
		IFS=$'\n'
		for afile in $( find .. -name "*.sh" -type f ); do
                	fileP=$( ls -l "$afile" | awk '{print $1;}' )
                	echo "$fileP" "$afile" >> permissions.log
			if [ ${fileP:2:1} == "w" ] ; then
				chmod u+x "$afile"
			else
				chmod u-x "$afile"
			fi
			if [ ${fileP:5:1} == "w" ] ; then
				chmod g+x "$afile"
			else
                                chmod g-x "$afile"
                        fi
			if [ ${fileP:8:1} == "w" ] ; then
				chmod o+x "$afile"
			else
                                chmod o-x "$afile"
			fi
		done
	elif [ $userInput -eq 2 ] ; then
		if [ -f permissions.log ] ; then
			while read line; do
				fperm=$( echo $line | cut -c -11 )
				IFS=$'\n'
				fileName=$( echo $line | cut -b 12- )
				if [ ${fperm:2:1} == "w" ] ; then
                                        chmod u+w "$fileName"
                                else
                                        chmod u-w "$fileName"
                                fi
				if [ ${fperm:3:1} == "x" ] ; then
                                        chmod u+x "$fileName"
                                else
                                        chmod u-x "$fileName"
                                fi
                                if [ ${fperm:5:1} == "w" ] ; then
                                        chmod g+w "$fileName"
                                else
                                        chmod g-w "$fileName"
                                fi
                                if [ ${fperm:6:1} == "x" ] ; then
                                        chmod g+x "$fileName"
                                else
                                        chmod g-x "$fileName"
                                fi
				if [ ${fperm:8:1} == "w" ] ; then
                                        chmod o+w "$fileName"
                                else
                                        chmod o-w "$fileName"
                                fi
                                if [ ${fperm:9:1} == "x" ] ; then
                                       	chmod o+x "$fileName"
                                else
                                	chmod o-x "$fileName"
                                fi
			done < permissions.log
		fi
	fi

fi

if [ $input -eq 7 ] ; then
	echo "Please choose what you would like to: "
        echo "1. Backup"
        echo "2. Restore"
        read uInput
	if [ $uInput -eq 1 ] ; then
                if [ -d backup ] ; then
                        rm -r backup
                fi
		mkdir backup
		if [ -f ./backup/restore.log ] ; then
                        rm ./backup/restore.log
                fi
		IFS=$'\n'
		for tmpFile in $( find .. -name "*.tmp" -type f ); do
			absPath="$tmpFile"
			touch "./backup/restore.log"
			echo "$absPath" >> ./backup/restore.log
                        mv "$tmpFile" backup
		done
	elif [ $uInput -eq 2 ] ; then
		if [ ! -d backup ]; then
			echo "Backup Not Found"
		fi
		if [ ! -f backup/restore.log ] ; then
			echo "No stored files"
                fi
		while read files; do
			afile="${files##*/}"
			mv "./backup/${afile}" "$files"
			if [ ! -f "$files" ] ; then
				echo "This file does not exist and can not be restored"
			fi
		done < backup/restore.log

	fi
fi
