#!/bin/zsh

if [ -f ./start ]; then
    rm ./start
fi
nasm -f macho32 main.asm -DMAC 
ld -macosx_version_min 10.0 -e _start -o start main.o
if [ -f ./start ]; then
    ./start
fi


