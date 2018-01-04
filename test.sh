#!/bin/bash

code=$1
platform=$2
out=$3

if [ $platform == "windows" ]; then
    echo "[language] Ada"
    echo "[input   ] `cat $code`"
    outact=$(./build/brainfuck-ada.exe $code)
    echo "[output  ] $outact"
    echo -n "[passed  ] "
    if [ "$outact" == "$out" ]; then echo -e 'Yes\n'; else echo -e 'No\n'; fi;

    echo "[language] Bash"
    echo "[input   ] `cat $code`"
    outact=$(./brainfuck.bash $code)
    echo "[output  ] $outact"
    echo -n "[passed  ] "
    if [ "$outact" == "$out" ]; then echo -e 'Yes\n'; else echo -e 'No\n'; fi;

    echo "[language] C"
    echo "[input   ] `cat $code`"
    outact=$(./build/brainfuck-c $code)
    echo "[output  ] $outact"
    echo -n "[passed  ] "
    if [ "$outact" == "$out" ]; then echo -e 'Yes\n'; else echo -e 'No\n'; fi;

    echo "[language] D"
    echo "[input   ] `cat $code`"
    outact=$(./build/brainfuck-d $code)
    echo "[output  ] $outact"
    echo -n "[passed  ] "
    if [ "$outact" == "$out" ]; then echo -e 'Yes\n'; else echo -e 'No\n'; fi;

    echo "[language] F#"
    echo "[input   ] `cat $code`"
    outact=$(./build/brainfuck-fs $code)
    echo "[output  ] $outact"
    echo -n "[passed  ] "
    if [ "$outact" == "$out" ]; then echo -e 'Yes\n'; else echo -e 'No\n'; fi;

    echo "[language] Java"
    echo "[input   ] `cat $code`"
    cd build/
    outact=$(java brainfuck brainfuck.class ../$code)
    echo "[output  ] $outact"
    echo -n "[passed  ] "
    if [ "$outact" == "$out" ]; then echo -e 'Yes\n'; else echo -e 'No\n'; fi;
    cd ..

    echo "[language] Lua"
    echo "[input   ] `cat $code`"
    outact=$(lua.exe brainfuck.lua $code)
    echo "[output  ] $outact"
    echo -n "[passed  ] "
    if [ "$outact" == "$out" ]; then echo -e 'Yes\n'; else echo -e 'No\n'; fi;

    echo "[language] Odin"
    echo "[input   ] `cat $code`"
    outact=$(./build/brainfuck-odin.exe $code)
    echo "[output  ] $outact"
    if [ "$outact" == "$out" ]; then echo -e 'Yes\n'; else echo -e 'No\n'; fi;

    echo "[language] Perl 6"
    echo "[input   ] `cat $code`"
    outact=$(cmd.exe /c "perl6.bat brainfuck.pl6 $code")
    echo "[output  ] $outact"
    echo -n "[passed  ] "
    if [ "$outact" == "$out" ]; then echo -e 'Yes\n'; else echo -e 'No\n'; fi;

    echo "[language] Python 3"
    echo "[input   ] `cat $code`"
    outact=$(python brainfuck.py $code)
    echo "[output  ] $outact"
    echo -n "[passed  ] "
    if [ "$outact" == "$out" ]; then echo -e 'Yes\n'; else echo -e 'No\n'; fi;

    echo "[language] Ruby"
    echo "[input   ] `cat $code`"
    outact=$(ruby brainfuck.rb $code)
    echo "[output  ] $outact"
    echo -n "[passed  ] "
    if [ "$outact" == "$out" ]; then echo -e 'Yes\n'; else echo -e 'No\n'; fi;

    echo "[language] Racket"
    echo "[input   ] `cat $code`"
    outact=$(racket -t brainfuck.rkt $code)
    echo "[output  ] $outact"
    echo -n "[passed  ] "
    if [ "$outact" == "$out" ]; then echo -e 'Yes\n'; else echo -e 'No\n'; fi;

    echo "[language] Rust"
    echo "[input   ] `cat $code`"
    outact=$(./build/brainfuck-rs $code)
    echo "[output  ] $outact"
    echo -n "[passed  ] "
    if [ "$outact" == "$out" ]; then echo -e 'Yes\n'; else echo -e 'No\n'; fi;
fi
