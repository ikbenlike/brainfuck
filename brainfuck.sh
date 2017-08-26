#!/bin/bash

code=$(cat $1)
#echo $code
len=${#code}
data[30000]=0
dptr=0
iptr=0

#echo $len
#echo ${code:0:1}

while [[ $iptr -lt $((len + 1)) ]]; do
    #echo "ran"
    #echo ${code:$iptr:1}
    case ${code:$iptr:1} in
        '>') dptr=$((dptr+1));;
        '<') dptr=$((dptr-1));;
        '+') data[$dptr]=$((data[$dptr] + 1));;
        '-') data[$dptr]=$((data[$dptr] - 1));;
        '.') printf "\x` printf %x ${data[$dptr]}`";;
        ',') read -n1 s; echo $s
             ${#data[$dptr]}=`printf "%d" \`$s` ;;
        '[');;
        ']');;
    esac
    iptr=$((iptr+1))
    #echo $iptr
done
