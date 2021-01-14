#! /bin/bash
# 尚未完成
# e.g. search /home/* and return 1st depth of folders in /home/
# : ./get_folders_in_folder.sh

search_dir="/home"



# for entry in `ls $search_dir`; do
#     # echo "$entry"
#     filepath="/$search_dir/$entry"
#     echo "filepath=$filepath"
#     if [[ -d $filepath ]]; then
#         entry_basename=$(basename $filepath)
#         echo "entry_base_name=$entry_basename"
#         arrVar[${#arrVar[@]}]=$entry
#     fi
# done

function getHomeUsers
####################################################
# Load all filenames into an array. 
# Arguments:
#    $1 = name of return array (must be global)
#    $2 = first path for 'find' command to search
#    ...  other paths for 'find' to search
#
{
   # store the name of the global array for return.
   local h_rtnArr=$1
   # discard first argument in argv
   shift

   # mapfile does heavy lifting.  See: help mapfile
   mapfile $h_rtnArr < <(find $@ -type d -maxdepth 1)

   # TODO: return error code
}

declare -a arrVar=()

getHomeUsers arrVar /home

# List results to stdout
arrSz=${#arrVar[@]}
for (( ndx=0; ndx < $arrSz; ++ndx )); do
   echo -n "${ndx}: ${arrVar[$ndx]}"
done
