// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

    // save initial keyboard value
    @KBD
    D=M
    @key
    M=D

(INPUT)
    // has the key value changed
    @KBD
    D=M
    @key
    D=D-M

    // if so set the new color
    @SET
    D;JNE

    @INPUT
    0;JMP

(SET)
    // save the current key value
    @KBD
    D=M
    @key
    M=D

    // set color based on key value
    @BLACK
    D;JNE
    @WHITE
    D;JEQ

    (FILL)
        // start at first row
        @SCREEN
        D=M
        @32
        D=D+M
        @row
        M=D

        // set every row to color
        (LOOP)
            // stop at the last row
            @row
            D=M
            @24575
            D=D-A
            @INPUT
            D;JGT

            // set row to color
            @color
            D=M
            @row
            A=M
            M=D            

            // go to next row
            @32
            D=M
            @row
            M=M+D

            @LOOP
            D;JGE

// set color to black
(BLACK)
    @color
    M=-1
    @FILL
    0;JMP

// set color to white
(WHITE)
    @color
    M=0
    @FILL
    0;JMP

// just in case
(END)
    @END
    0;JMP
