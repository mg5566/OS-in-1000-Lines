#!/bin/bash
set -xue

QEMU=/opt/homebrew/bin/qemu-system-riscv32

# clang 경로와 컴파일 옵션
CC=/opt/homebrew/opt/llvm/bin/clang  # Ubuntu 등 환경에 따라 경로 조정: CC=clang
CFLAGS="-std=c11 -O2 -g3 -Wall -Wextra --target=riscv32-unknown-elf -fno-stack-protector -ffreestanding -nostdlib -fuse-ld=lld"

# 커널 빌드
$CC $CFLAGS -Wl,-Tkernel.ld -Wl,-Map=kernel.map -o kernel.elf \
    kernel.c common.c

# QEMU 실행
$QEMU -machine virt -bios default -nographic -serial mon:stdio --no-reboot \
    -kernel kernel.elf
