.text
main:
.globl main
    la a0, array_1 #arr
    lw a1, array_length_1 #lenght = 5
    mv s1, ra
    call findMedian
    mv ra, s1
    ret

.rodata
array_length_1:
    .word 5
.data
array_1:
    .word 1,2,3,4,5