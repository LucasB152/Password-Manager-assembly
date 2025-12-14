T:
    STORAGE(TSizeConst)   |; STORAGE(n) allocates n 32-bits words


initRandomTable:
    PUSH(LP) PUSH(BP)
    MOVE(SP, BP)

    PUSH(R1) |; nbSubTables
    PUSH(R2) |; subTableSize
    PUSH(R3) |; i
    PUSH(R4) |; Used to store intermediate values

    LD(BP, -12, R1) |; R1 <- nbSubTables
    LD(BP, -16, R2) |; R2 <- subTableSize
    CMOVE(0, R3)      |; R3 <- 0
    
initRandomTable_loop:
    MUL(R1, R2, R4)   |; R4 <- nbSubTables * subTableSize
    CMPLT(R3, R4, R0) |; i < size of the tab
    BF(R0, initRandomTable_end) |; if false, branch to initRandomTable_end

    RANDOM() |; Generate a rendom number and store it in R0

    MULC(R3, 4, R4) |; Get the of offset in the tab and store it in R4
    ADD(T, R4, R4)  |; Get the address of i in the tab with the offset and store it in R4
    ST(R0, 0, R4) |; Store the random value (R0) at the address i (R4) in the tab 

    ADDC(R3, 1, R3) |; Increment i

    BR(initRandomTable_loop)

initRandomTable_end:
    POP(R4) 
    POP(R3)
    POP(R2)
    POP(R1)
    POP(BP)
    POP(LP)
    RTN()