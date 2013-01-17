#!/bin/sh
echo "-------------------------------------------------------WELCOME TO REDSKY TECHNOLOGIES ----------------------------------------------------------"
echo "Please Enter Your Choice"
echo "1. Existing Employee"
echo "2. New Employee"
echo "3. Admin Login"
echo "4. Exit"
read a
if [ $a -eq 1 ]
then
echo -n "Please Enter Your Username:"
read x
c=`grep $x data | cut -d "|" -f 5 `
while [ $x != $c ]
do
echo "User Doesn't Exist!!"
echo -n "Please Enter Your Username:"
read x
done
stty -echo
echo -n "Please Enter Your Password:"
read p
echo
stty echo
d=`grep $x data | cut -d "|" -f 6`
decrypt=`perl -e 'print pack "H*"',$p`
while [ $decrypt != $d ]
do
stty -echo
echo "Oops!! You Entered Wrong Password"
echo -n "Please Enter Your Password Correctly:"
read p
decrypt=`perl -e 'print pack "H*"',$p`
echo
stty echo
done
echo "  WELCOME TO" `grep $x data | cut -d "|" -f 4` "DEPARTMENT AT REDSKY TECHNOLOGIES"
echo "		--EMPLOYEE DETAILS--		"
echo "	NAME:" `grep $x data | cut -d "|" -f 2`
echo "	AGE:" `grep $x data | cut -d "|" -f 3`
echo "	DEPARTMENT:" `grep $x data | cut -d "|" -f 4`
echo "	LAST LOGIN:" `grep $x data | cut -d "|" -f 7`
change=`date | cut -d " " -f 2,3,4`
ln=`grep $x data | cut -d "|" -f 7`
engi=`sed 's/'"$ln"'/'"$change"'/' data`
echo -n >data
echo -n "$engi">>data 
echo "->> PRESS 0 TO CHANGE YOUR PASSWORD"
read r
if [ $r -eq 0 ]
then
echo -n "Enter Old Password:"
stty -echo
read op
echo
dep=`perl -e 'print pack "H*"',$op`
if [ $dep = $d ]
then
echo -n "Plese Enter New Password:"
read npass
echo
echo -n "Confirm Your Password:"
read npass1
echo
stty echo
while [ $npass != $npass1 ]
do
stty -echo
echo -n "Re-Enter Your Password:"
read npass
echo
echo -n "Confirm Your Password:"
read npass1
echo
stty echo
clear
done
new=`perl -e 'print pack "H*"',$npass`
eng=`sed 's/'"$d"'/'"$new"'/' data`
echo -n >data
echo -n "$eng">>data 
echo "Password Changed"
else
echo "Wrong Password"
fi
fi
#echo -n "`date | cut -d " " -f 4`	" | grep $x data |  -d "|" -f 7 >>data
elif [ $a -eq 2 ]
then
echo "Please Enter Your Name"
read nm
echo "Please Enter Your Age"
read age
echo "Please Enter Your Department"
read dp
echo "Please Enter a Desired Username"
read us
test=`grep $dp data | cut -d "|" -f 5`
salt='ab'
stty -echo
echo -n "Plese Enter Your Password:"
read pass
echo
echo -n "Confirm Your Password:"
read pass1
echo
stty echo
while [ $pass != $pass1 ]
do
stty -echo
echo -n "Re-Enter Your Password:"
read pass
echo
echo -n "Confirm Your Password:"
read pass1
echo
stty echo
done
clear
echo "Congrats You Have Been Added to the Company Database. You Could Login Now and see Your Details."
encrypt=`perl -e 'print pack "H*"',$pass`
lines=`wc -l data | cut -d " " -f 1`
t=`expr $lines + 1001 `
echo -n "$t	|">>data
echo -n "$nm		|">>data
echo -n "$age	|">>data
echo -n "$dp		|">>data
echo -n "$us		|">>data
echo -n "$encrypt	|">>data
echo "`date | cut -d " " -f 2,3,4`">>data
elif [ $a -eq 3 ]
then
echo "HELLO"
elif [ $a -eq 4 ]
then
exit
else
echo "Wrong Choice Entered"
fi
