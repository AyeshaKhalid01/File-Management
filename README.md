# File Management
Created using BASH
 
**Execution**: Execute manage.sh, which is already made executable by doing "chmod +x manage.sh". By 
running the file it will prompt for user Input to select a feature they want to use.

**Available feature the user can choose from:** 
1. FIXME Log 
2. Find Tag
3. File Type Count 
4. Word and Vowel Count
5. Palindrome log 
6. Switch to Executable
7. Backup and Delete / Restore

## Feature 1 - FIXME Log
### Description
- This feature looks through all the files in your repository to find files that have the word **#FIXME** in the last line of the files. - All those files names are 
then listed in a new line in a file called fixme.log to track the files that have the word in them. If fixme.log already exists then it is overwritten. - One of the 
pitfalls for this feature that had to be accounted for is if there was a special character like a white space in the file name, the special character had to be 
dealt with so the program is still looking into the file. This was fixed by doing `IFS=$'\n'`. As the internal field separator is originally a white space and once 
you set it to new line then the file names with a space won't conflict. 

```bash 
if [ $( tail -n 1 "$file" | egrep "*#FIXME" ) ] ; then
echo "$file" >> fixme.log fi 
``` 
After looping through the files the program checks if the last line of the file has #FIXME by using egrep, the "e" is for regular expressions. If it is true then the file
name is appended to fixme.log. 
