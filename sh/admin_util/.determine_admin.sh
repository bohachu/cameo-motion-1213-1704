#!/bin/bash
# Determine if a user($1) is in the group($2), and return True/False
# ./.determine_admin.sh username sudo 
the_user=$1
# group_str=$2 #"1"=admin; "0"=not admin
str_group=1
# method 2: via sqlite and crontab
sql_cmd="select admin from users where Name='$the_user'"
user_group_result=$(sudo sqlite3 /jupyterhub.sqlite "$sql_cmd")
# sample: rsa-key-20201205@iek-dev2:~$ sudo sqlite3 /jupyterhub.sqlite "select * from users where Name='cameo'"
# 2|cameo|1|2020-12-11 04:29:30.015911|2021-01-18 16:07:19.002000|f93d966d76f047c596fa00ced0052fa8|{}|


# echo "user_group_result=$user_group_result"

if [[ $user_group_result == *$str_group* ]]
then
  #echo "this user is admin"
  echo "True"
else
  #echo "this user is not admin"
  echo "False"
fi

# # method 1 failed

# user_group_result=$(groups $the_user)
# # echo "user_group_result=$user_group_result"

# group_str=$2 #"sudo"
# # echo "group_str=$group_str"

# # check if user in sudo
# # string='My long string'
# if [[ $user_group_result == *$group_str* ]]
# then
#   #echo "this user is admin"
#   echo "True"
# else
#   #echo "this user is not admin"
#   echo "False"
# fi
