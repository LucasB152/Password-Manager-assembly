|; MOD(Ra, Rb, Rc)         Reg[Rc] <- Reg[Ra] % Reg[Rb]        (note: Rc should be a different register than Ra and Rb)
.macro MOD(Ra, Rb, Rc) DIV(Ra, Rb, Rc) MUL(Rc, Rb, Rc) SUB(Ra, Rc, Rc)

|; DOUBLE_ARR_OFFSET(...) 
.macro DOUBLE_ARR_OFFSET() |; complete this macro

.macro DOUBLE_TABLE_INDEX(Rx, Ry, Rdest) LDR(blockSizeInBits, Rdest) CMOVE(1, R0) SHL(R0, Rdest, Rdest) MUL(Ry, Rdest, Rdest) ADD(Rdest, Rx, Rdest) LD(Rdest, 0, Rdest)


