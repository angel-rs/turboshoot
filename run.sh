#!/usr/bin/env bash

nasm -f elf64 turboshoot.asm &&
ld -m elf_x86_64 -s -o turboshoot turboshoot.o &&
./turboshoot
