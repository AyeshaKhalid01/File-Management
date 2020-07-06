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
