#!/bin/bash

code=$(cat $1)
#echo $code
len=${#code}
data[30000]=0
dptr=0
iptr=0

while [[ $iptr -lt $((len + 1)) ]]; do
    count=1
    case ${code:$iptr:1} in
        '>') dptr=$((dptr+1));;
        '<') dptr=$((dptr-1));;
        '+') data[$dptr]=$((data[$dptr] + 1));;
        '-') data[$dptr]=$((data[$dptr] - 1));;
        '.') printf "\x` printf %x ${data[$dptr]}`";;
        ',') read -n1 s; data[$dptr]=`printf "%d" \'$s` ;;
        '[') 
            if [[ data[$dptr] == 0 ]]; then
                iptr=$((iptr+1))
                while [[ $count -gt 0 ]]; do
                    if [[ ${code:$iptr:1} == '[' ]]; then count=$((count+1)); fi
                    if [[ ${code:$iptr:1} == ']' ]]; then count=$((count-1)); fi
                    iptr=$((iptr+1))
                done
                iptr=$((iptr-1))
            fi;;
        ']')
            if [[ data[$dptr] -ne 0 ]]; then
                iptr=$((iptr-1))
                while [[ $count -gt 0 ]]; do
                    if [[ ${code:$iptr:1} == ']' ]]; then count=$((count+1)); fi
                    if [[ ${code:$iptr:1} == '[' ]]; then count=$((count-1)); fi
                    iptr=$((iptr-1))
                done
            fi;;
    esac
    iptr=$((iptr+1))
done
