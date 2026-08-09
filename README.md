Tests that failed:
- Test that checks that the context is not corrupted after a call in initRandomTable
- Test hashPasswordRec with the whole student's program
- Test checkHash with the whole student's program
- Test hashPasswordRec in isolation
- Test checkHash in isolation
- Too many registers used in hashPassword

+ in the macro definition, I directly use the r0 register. Instead of that, I should use a parameter and give the r0 register when the function call.

**=> to update when possible**
