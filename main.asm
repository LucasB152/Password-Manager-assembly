.include beta.uasm

|; Constants. DO NOT DEFINE NEW CONSTANTS IN YOUR CODE, THESE ARE JUST FOR THE TABLE T AND PASSWORDHASHES
|; You do not have to use them in your code.
nSubTablesConst = 20
|; Here, 1 block is (generally) 1 character of the password.
blockSizeInBitsConst = 8
TSizeConst = nSubTablesConst * (1 << blockSizeInBitsConst)
maxNbUsersConst = 10

|; bootstrap
CMOVE(stack__, SP)
MOVE(SP, BP)
BR(main)

.include util.asm
.include table.asm
.include password.asm
.include hash.asm

nSubTables:
    LONG(nSubTablesConst)

blockSizeInBits:
    LONG(blockSizeInBitsConst)

maxNbUsers:
    LONG(maxNbUsersConst)

|; *---------------------------------------------------------------------*
|; |                                                                     |
|; |          4 example passwords to test your implementation.           |
|; |                  (you can set up to 10 passwords)                   |
|; |                                                                     |
|; *---------------------------------------------------------------------*

password_user0:
    LONG(0x70697373) LONG(0x776f7264) LONG(0x0)

password_user1:
    LONG(0x4b657473) LONG(0x61726b75) LONG(0x3132336d) LONG(0x6f7a6761) LONG(0x6c6f6d00)

password_user2:
    LONG(0x4f476478) LONG(0x6433426d) LONG(0x52574e43) LONG(0x616b6b4b) LONG(0x0)

password_user3:
    LONG(0x2d6d6246) LONG(0x51434341) LONG(0x4a2d4100)

main:

    |; *---------------------------------------------------------------------*
    |; |                                                                     |
    |; |                        Initialization steps.                        |
    |; |                                                                     |
    |; *---------------------------------------------------------------------*


    |; initRandomTable(nSubTables, 1 << blockSizeInBits);
    LD(blockSizeInBits, R0)
    CMOVE(1, R1)
    SHL(R1, R0, R1)
    PUSH(R1)
    LD(nSubTables, R0)
    PUSH(R0)
    CALL(initRandomTable, 2)

    |; *---------------------------------------------------------------------*
    |; |                                                                     |
    |; |              Example code to test your implementation.              |
    |; |                                                                     |
    |; *---------------------------------------------------------------------*

    |; setPassword(0, password0)
    CMOVE(password_user0, R1)
    PUSH(R1)
    PUSH(R31)
    CALL(setPassword, 2)

    |; setPassword(1, password1)
    CMOVE(password_user1, R2)
    PUSH(R2)
    CMOVE(1, R0)
    PUSH(R0)
    CALL(setPassword, 2)

    |; verifyPassword(0, password1) -> should return 0 (false)
    PUSH(R2)
    PUSH(R31)
    CALL(verifyPassword, 2)

.breakpoint
    |; verifyPassword(0, password0) -> should return 1 (true)
    PUSH(R1)
    PUSH(R31)
    CALL(verifyPassword, 2)

    HALT()





    |; check for 0xDEADCAFE in the memory explorer
    |; to find the base of the stack
    LONG(0xDEADCAFE)
stack__:
    STORAGE(1024)
