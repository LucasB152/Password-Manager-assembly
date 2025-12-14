|; The set of lookup table
T:
    STORAGE(TSizeConst)   |; STORAGE(n) allocates n 32-bits words


initRandomTable:
    PUSH(LP) PUSH(BP)
    MOVe(SP, BP)

    PUSH(R1) ; nbSubTables
    PUSH(R2) ; subTableSize
    PUSH(R3) ; i
    PUSH(R4) ; Size of the tab

    LOAD(BP, -12, R1) ; R1 <- nbSubTables
    LOAD(BP, -16, R2) ; R2 <- subTableSize
    CMOVE(0, R3)      ; R3 <- 0
    MUL(R1, R2, R4)   ; R4 <- nbSubTables * subTableSize
    
initRandomTable_loop:
    CMPLT(R3, )
