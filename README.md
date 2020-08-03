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
**Execution**: When asked by the program, enter the corresponding number which is, 1, for the FIXME feature. There will be no explicit output 
since the names are in the file fixme.log. However, if you do cat fixme.log it will output the names of the file.
## Feature 2- Find Tag
### Description
- The feature prompts the user to input a single word, this word is referred to as the Tag. The program then looks through all python files in the repository, to 
find comments that include the Tag within it. - The comments are then printed to a file called Tag.log where Tag is the user input. If the Tag.log file already 
exits, it is overwritten. - One of the pitfalls that had just like the above feature is that you have to account for special characters in the file name but that 
was fixed by doing `IFS=$'\n'`. 

```bash 
commentPy=`cat "$f" | grep '^#' | grep "$userInput"` echo "$commentPy" >> "$userInput".log 
``` 
After looping through all python files, cat is used to go through a file sequentially, and grep is used to first find all comments and then find comments with the Tag.
 
**Execution**: When asked by the program, enter the corresponding number which is, 2, for the Find Tag feature. There will be no explicit output since the names are 
in the file Tag.log since the comments are echoed . However, if you do cat Tag.log it will output the comments on to the file.

## Feature 3 - File Type Count
### Description
- The feature prompts the user to input a file extension and the program then finds all files with that extension. It then finds all files with that extension in 
the repository. - The program then keeps count of the number of files there are with that extension and outputs the number at the end. 
```bash 
count=$( find .. -name "*.$extension" -type f | wc -l ) 
``` 
The program uses find so it recursively looks through all the directories and sub directories to find files with that  extension, all the files are then added up 
to get a total.
**Execution**:  When asked by the program, enter the corresponding number which is, 3, for the file count feature. Make sure to enter the extension **without** putting "." and simply entering "py" or any other extension.
