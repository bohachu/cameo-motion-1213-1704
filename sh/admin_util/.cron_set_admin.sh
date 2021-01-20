#!/bin/bash
# Determine if a user($1) is in the group($2), and return True/False
# ./.determine_admin.sh username sudo 

# group_str=$2 #"1"=admin; "0"=not admin
str_group=1
# method 2: via sqlite and crontab
sql_cmd="select name from users where admin=$str_group"
user_result=$(sudo sqlite3 /jupyterhub.sqlite "$sql_cmd")
# sample: 
#rsa-key-20201205@iek-dev2:~$ sudo sqlite3 /jupyterhub.sqlite "select name from users where admin=1"
#cameo
#hanes
#caro
#cameo2
#iek
#isadmin20210120-1

# echo "loop users and grant admin permission"

for Item in ${user_result[*]};
  do
    sudo bash .post_add_admin.sh $Item
  done



