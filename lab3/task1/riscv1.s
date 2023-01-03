.text
__start:
.globl __start
    #VARS
    #a2(arr)
    #a3(len)
    #a4(interval_right)
    #a5(left)
    #a6(right)
    #a7(median)

    #t1(i)
    #t2(j)

    la a2, array #a2(arr) адрес начала массива
    lw a3, array_length #a3(len) длина
    slli t1, a3, 2
    add a4, a2, t1 #a4 (interval_right) = arr[size]
    mv a5, a2 # a5(left) = a2(arr)
    addi a7, a3, -1 
    li t1, 2 #временная двойка для выполнения деления
    divu a7, a3, t1 # a7(median) = (a3(len) - 1) / 2
endless_loop:
    addi t1, a5, 4 #t1(i) = a5(left) + 1
    addi a6, a4, -4 #a6(right) = a4(interval_right) - 1    

find_swap_index_loop:
#while
    bgeu t1, a4, end_find_swap_index_loop #if !(interval_right > i) goto end_find_swap_index_loop
#if
    lw t3, 0(a5) #загрузка *left
    lw t4, 0(t1) #загрузка *i
    blt t4, t3,  endif_find_swap #if !(*left <= *i)  goto endif_find_swap
    addi a6, a6, -4 #right--
endif_find_swap:
    addi t1, t1, 4 #i++
    j find_swap_index_loop
end_find_swap_index_loop:
#swap
    lw t4, 0(a6) #загрузка *right
    sw t3, 0(a6) #right = left(из регистра)
    sw t4, 0(a5) #left = right(из регистра)
#endswap
    mv t1, a5 #t1(i) = left
    addi t2, a6, 4 #t2(j) = right + 1
assig_addres_loop:
#while
    bgeu t1, a6,  end_assig_addres_loop  #if !(right > i) goto end_assig_addres_loop
#if
    lw t3, 0(t1) #загрузка *i
    lw t4, 0(a6) #загрузка *right
    blt t3, t4, end_assig_addres_if  #if !(*right <= *i) goto end_assig_addres_if
assig_addres_loop_j:
#while
    lw t3, 0(t2) #загрузка *j
    blt t3, t4, end_assig_addres_loop_j #if !(*right <= *j ) goto end_assig_addres_loop_j
    addi t2, t2, 4
    j assig_addres_loop_j
end_assig_addres_loop_j:
#swap    
    lw t4, 0(t1) #загружаем *i
    sw t3, 0(t1) #i = j(из регистра)
    sw t4, 0(t2) #j = i(из регистра)
#endswap
    addi t2, t2, 4 #j++
end_assig_addres_if:    
    addi t1, t1, 4 #i++
    j assig_addres_loop
end_assig_addres_loop:
    sub t3, a6, a2
    li t5, 4 #временная двойка для выполнения деления
    divu t3, t3, t5 # t3 = t3 / 4 для получения индекса
    beq t3, a7, loop_exit #if (right[index] == median) goto loop_exit
    bgeu a7, t3, move_left #if  !(right > median) goto move_left
    mv a4, a6 
    j endless_loop
move_left:
    addi a5, a6, 4 
    j endless_loop    
loop_exit:    
    lw a1, 0(a6)
    li a0, 10 
    ecall
.rodata
array_length:
    .word 5
.data
array:
    .word -2, -10, 10, 15, 100