#!/usr/bin/env bash

nasm -f elf proyecto.asm &&
ld -m elf_i386 -s -o proyecto proyecto.o &&
./proyecto
