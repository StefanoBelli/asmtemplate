.extern main
.global _start

_start:
    xorq %rdi, %rdi

    movl (%rsp), %edi    # direct value (argc)
    movq %rsp, %rsi       
    addq $8, %rsi        # argv
     
    movq %rsp, %rdx
__entry_get_envp_start:
    movq (%rdx), %rax
    testq %rax, %rax
    jz __entry_get_envp_done

    addq $8, %rdx
    jmp __entry_get_envp_start

__entry_get_envp_done:
    pushq %rdi
    pushq %rsi

    addq $8, %rdx
    movq %rdx, %rbx # rbx : envp

# edi : argc
# rsi : argv
# rbx : envp
    callq main

    xorq %rdi, %rdi
    xchgl %eax, %edi
    movq $60, %rax
    syscall
