#!/bin/bash
# Determine if a user($1) is in the group($2), and return True/False
# ./.determine_admin.sh username sudo 
the_user=$1
# group_str=$2 #"1"=admin; "0"=not admin
str_group="1"
# method 2: via sqlite and crontab
sql_cmd="select admin from users where Name='$the_user'"
user_group_result=$(sudo sqlite3 /jupyterhub.sqlite "$sql_cmd")

echo "sqlresult=$sqlresult"

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
