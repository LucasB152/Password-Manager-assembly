.macro DOUBLE_TABLE_INDEX(Rx, Ry, Rdest) LDR(blockSizeInBits, Rdest) CMOVE(1, R0) SHL(R0, Rdest, Rdest) MUL(Ry, Rdest, Rdest) ADD(Rdest, Rx, Rdest) LD(Rdest, 0, Rdest)

hashPassword:
    |; Place your code here


hashPasswordRec:
    PUSH(LP)
    PUSH(BP)
    MOVE(SP, BP)

    PUSH(R1) |; password
    PUSH(R2) |; recursionDepth
    PUSH(R3) |; Additionnal temporary register
    PUSH(R4) |; Second additionnal temporary register
    PUSH(R5)

    LD(BP, -12, R1) |; R1 <- password
    LD(BP, -16, R2) |; R2 <- recursionDepth
    ANDC(R1, 0xFFFFFFFC, R0) |; Compute the 32-bt aligned base adresse for password[recursionDepth]

    LD(R0, 0, R4) |; Load the 32-bit word that contains the desired character password[recursionDepth]

    |; Compute the number of bytes to shift right
    |; number_of_bytes_to_shift = 3 - (password_i_address % 4)
    CMOVE(4, R3) |; Put 4 in R3
    MOD(R1, R3, R5) |; password_i_address % 4
    CMOVE(3, R3) |; Put 3 in R3
    SUB(R3, R5, R0) |; 3 - (password_i_address % 4)

    |; Convert this value to bits
    |; number_of_bits_to_shift = number_of_bytes_to_shift × 8
    MULC(R0, 8, R0)

    |; Shift the loaded word (in R4) right by the number of bits founded (in R0)
    SHR(R4, R0, R4)
    ANDC(R4, 0xFF , R4)
    
    |; if (!password[recursionDepth]) return 0
    BF(R4, hashPasswordRec_base)

    |; recursionDepth % N_SUB_TABLES
    LDR(nSubTables, R3) |; Get N_SUB_TABLES in R3
    MOD(R2, R3, R3)
    .breakpoint
    DOUBLE_TABLE_INDEX(R4, R3, R5) |; Get the currentDepthHash and store it in R4
    
    MOVE(R5, R0)
    |; Recursive call
    ADDC(R1, 1, R1) |; password + 1
    ADDC(R2, 1, R2) |; recursionDepth + 1

    PUSH(R2)
    PUSH(R1)
    CALL(hashPasswordRec, 2)

    |; XOR the actual result and the result of the recursive call
    |; The result of the recursive call will be store in R0
    XOR(R5, R0, R0)

    BR(hashPasswordRec_end)


hashPasswordRec_base:
    CMOVE(0, R0)

hashPasswordRec_end:
    POP(R5)
    POP(R4)
    POP(R3)
    POP(R2)
    POP(R1)
    POP(BP)
    POP(LP)
    RTN()



checkHash:
    |; Place your code here

