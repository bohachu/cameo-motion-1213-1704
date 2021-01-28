#!/bin/bash
the_user=$1

sql_cmd="update users set admin=1 where Name='$the_user'"
sudo sqlite3 /jupyterhub.sqlite "$sql_cmd"

