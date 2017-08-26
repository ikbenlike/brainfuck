#!/bin/bash

code=$(cat $1)
#echo $code
len=${#code}
data[30000]=0
dptr=0
iptr=0

while [[ $iptr -lt $((len + 1)) ]]; do
    case ${code:$iptr:1} in
        '>') dptr=$((dptr+1));;
        '<') dptr=$((dptr-1));;
        '+') data[$dptr]=$((data[$dptr] + 1));;
        '-') data[$dptr]=$((data[$dptr] - 1));;
        '.') printf "\x` printf %x ${data[$dptr]}`";;
        ',') read -n1 s;
             data[$dptr]=`printf "%d" \'$s` ;;
        '[') ;;
        ']');;
    esac
    iptr=$((iptr+1))
done
