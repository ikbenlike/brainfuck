#!/bin/bash

code=$1
platform=$2

if [ $platform == "windows" ]; then
    echo "[language] Ada"
    echo "[input   ] `cat $code`"
    echo "[output  ] `./build/brainfuck-ada.exe $code`"

    echo "[language] Bash"
    echo "[input   ] `cat $code`"
    echo "[output  ] `./brainfuck.bash $code`"

    echo "[language] C"
    echo "[input   ] `cat $code`"
    echo "[output  ] `./build/brainfuck-c.exe $code`"

    echo "[language] D"
    echo "[input   ] `cat $code`"
    echo "[output  ] `./build/brainfuck-d.exe $code`"

    echo "[language] F#"
    echo "[input   ] `cat $code`"
    echo "[output  ] `./build/brainfuck-fs.exe $code`"

    echo "[language] Java"
    echo "[input   ] `cat $code`"
    cd build/
    echo "[output  ] `java brainfuck brainfuck.class ../$code`"
    cd ..

    echo "[language] Lua"
    echo "[input   ] `cat $code`"
    echo "[output  ] `lua.exe brainfuck.lua $code`"

    echo "[language] Perl 6"
    echo "[input   ] `cat $code`"
    echo "[output  ] `cmd.exe /c \"perl6.bat brainfuck.pl6 $code\"`"

    echo "[language] Python 3"
    echo "[input   ] `cat $code`"
    echo "[output  ] `python.exe brainfuck.py $code`"

    echo "[language] Ruby"
    echo "[input   ] `cat $code`"
    echo "[output  ] `ruby.exe brainfuck.rb $code`"

    echo "[language] Racket"
    echo "[input   ] `cat $code`"
    echo "[output  ] `Racket.exe -t brainfuck.rkt $code`"

    echo "[language] Rust"
    echo "[input   ] `cat $code`"
    echo "[output  ] `./build/brainfuck-rs.exe $code`"
fi
