|; The array to store the hashes of the user's passwords
passwordHashes:
    STORAGE(maxNbUsersConst)   |; STORAGE(n) allocates n 32-bits words


verifyPassword:
    PUSH(LP)
    PUSH(BP)
    MOVE(SP, BP)

    PUSH(R1) |; userId
    PUSH(R2) |; password

    LD(BP, -12, R1) |; R1 <- userId
    LD(BP, -16, R2) |; R2 <- password
 
    |; Verif if userId < maxNbUsers
    LDR(maxNbUsers, R0)
    CMPLTC(R1, 10, R0)
    BF(R0, verifyPassword_end) |; If userId >= maxNbUsers, then return

    |; Else hash the password
    PUSH(R2)
    CALL(hashPassword, 1) |; The result hashed password is stored in R0

    |; Chech if the hashed password is equals to the hash stored in the tab
    PUSH(R0)
    PUSH(R1)
    CALL(checkHash, 2) |; The result of the verification will be stored in R0

verifyPassword_end:
    POP(R2)
    POP(R1)
    POP(BP)
    POP(LP)
    RTN()


setPassword:
    PUSH(LP)
    PUSH(BP)
    MOVE(SP, BP)

    PUSH(R1) |; userId
    PUSH(R2) |; password

    LD(BP, -12, R1) |; R1 <- userId
    LD(BP, -16, R2) |; R2 <- password

    |; Verif if userId < maxNbUsers
    LDR(maxNbUsers, R0)
    CMPLTC(R1, 10, R0)
    BF(R0, setPassword_end) |; If userId >= maxNbUsers, then return

    |; Else, hash the password
    PUSH(R2)
    CALL(hashPassword, 1)
    |; The hashed password is stored in R0

    MULC(R1, 4, R1) |; Compute the offset to get to passwordHashes[userId]
    CMOVE(passwordHashes, R2) |; R2 <- address of the start of the tab passwordHashesh
    ADD(R1, R2, R2) |; Add the start address of the tab and the offset

    |; Store the hash (in R0) at the address in R2
    ST(R0, 0, R2)

setPassword_end:
    POP(R2)
    POP(R1)
    POP(BP)
    POP(LP)
    RTN()

