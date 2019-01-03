#!/usr/bin/env bash

nasm -f elf turboshoot.asm &&
ld -m elf_i386 -s -o turboshoot turboshoot.o &&
./turboshoot
