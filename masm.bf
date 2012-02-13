========= Instructions ==========
(None)      : 1
G #N        : 2
G $N        : 3
S #N        : 4
S $N        : 5
(plus) #N   : 6
(plus) $N   : 7
(minus) #N  : 8
(minus) $N  : 9
J #N        : 10
J $N        : 11
C #N        : 12
C $N        : 13
R           : 14
W           : 15
=================================

============ Symbols ============
#0  char
#1  instruction
#2  isDesiredChar
#3  tmp
#4  readChar
#5  continueParsingLine
#6  continueParsingLineCopy
=================================


>>>>+                                       #readChar = true
>+                                          #continueParsingLine = true
<                                           #go to readChar
[                                           #while readChar:
    -                                           #readChar = false
    <<<<,                                       #char = readch()
    +[-                                         #if char != EOF:
        >>>>+                                       #readChar = true
        <<<<                                        #go to char

        ============ Reading ';' (comment marker) ==================================
        >>+                                         #isDesiredChar = true
        <<  -----------------------------------------------------------
        [                                           #if char != 'G'
            +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            >>-                                         #isDesiredChar = false
            <<[->>>+<<<]                                #tmp = char
        ]
        >>>[-<<<+>>>]                               #char = tmp
        <[                                          #if isDesiredChar:
            >>>[-]                                      #continueParsingLine = false
            <<<-                                        #isDesiredChar = false
        ]
        <<                                          #go to char
        ============================================================================

        >>>>>                                       #go to continueParsingLine
        [                                           #if continueParsingLine
            <<<<<                                       #go to char

            ============ Reading 'G' instruction ======================================
            >>+                                         #isDesiredChar = true
            <<  -----------------------------------------------------------------------
            [                                           #if char != 'G'
                +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                >>-                                         #isDesiredChar = false
                <<[->>>+<<<]                                #tmp = char
            ]
            >>>[-<<<+>>>]                               #char = tmp
            <[                                          #if isDesiredChar:
                <++                                         #instruction = 2
                >-                                          #isDesiredChar = false
            ]
            <<                                          #go to char
            ============================================================================


            ============ Reading 'S' instruction ======================================
            >>+                                         #isDesiredChar = true
            <<  -----------------------------------------------------------------------------------
            [                                           #if char != 'S'
                +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                >>-                                         #isDesiredChar = false
                <<[->>>+<<<]                                #tmp = char
            ]
            >>>[-<<<+>>>]                               #char = tmp
            <[                                          #if isDesiredChar:
                <++++                                       #instruction = 4
                >-                                          #isDesiredChar = false
            ]
            <<                                          #go to char
            ============================================================================


            ============ Reading (plus) instruction ======================================
            >>+                                         #isDesiredChar = true
            <<  -------------------------------------------
            [                                           #if char != (plus)
                +++++++++++++++++++++++++++++++++++++++++++
                >>-                                         #isDesiredChar = false
                <<[->>>+<<<]                                #tmp = char
            ]
            >>>[-<<<+>>>]                               #char = tmp
            <[                                          #if isDesiredChar:
                <++++++                                     #instruction = 6
                >-                                          #isDesiredChar = false
            ]
            <<                                          #go to char
            ============================================================================


            ============ Reading (minus) instruction ======================================
            >>+                                         #isDesiredChar = true
            <<  ---------------------------------------------
            [                                           #if char != (minus)
                +++++++++++++++++++++++++++++++++++++++++++++
                >>-                                         #isDesiredChar = false
                <<[->>>+<<<]                                #tmp = char
            ]
            >>>[-<<<+>>>]                               #char = tmp
            <[                                          #if isDesiredChar:
                <++++++++                                   #instruction = 8
                >-                                          #isDesiredChar = false
            ]
            <<                                          #go to char
            ============================================================================


            ============ Reading 'J' instruction ======================================
            >>+                                         #isDesiredChar = true
            <<  --------------------------------------------------------------------------
            [                                           #if char != 'J'
                ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                >>-                                         #isDesiredChar = false
                <<[->>>+<<<]                                #tmp = char
            ]
            >>>[-<<<+>>>]                               #char = tmp
            <[                                          #if isDesiredChar:
                <++++++++++                                 #instruction = 10
                >-                                          #isDesiredChar = false
            ]
            <<                                          #go to char
            ============================================================================


            ============ Reading 'C' instruction ======================================
            >>+                                         #isDesiredChar = true
            <<  -------------------------------------------------------------------
            [                                           #if char != 'C'
                +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                >>-                                         #isDesiredChar = false
                <<[->>>+<<<]                                #tmp = char
            ]
            >>>[-<<<+>>>]                               #char = tmp
            <[                                          #if isDesiredChar:
                <++++++++++++                               #instruction = 12
                >-                                          #isDesiredChar = false
            ]
            <<                                          #go to char
            ============================================================================


            ============ Reading 'R' instruction ======================================
            >>+                                         #isDesiredChar = true
            <<  ----------------------------------------------------------------------------------
            [                                           #if char != 'R'
                ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                >>-                                         #isDesiredChar = false
                <<[->>>+<<<]                                #tmp = char
            ]
            >>>[-<<<+>>>]                               #char = tmp
            <[                                          #if isDesiredChar:
                <++++++++++++++                             #instruction = 14
                >-                                          #isDesiredChar = false
            ]
            <<                                          #go to char
            ============================================================================


            ============ Reading 'W' instruction ======================================
            >>+                                         #isDesiredChar = true
            <<  ---------------------------------------------------------------------------------------
            [                                           #if char != 'W'
                +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                >>-                                         #isDesiredChar = false
                <<[->>>+<<<]                                #tmp = char
            ]
            >>>[-<<<+>>>]                               #char = tmp
            <[                                          #if isDesiredChar:
                <+++++++++++++++                            #instruction = 15
                >-                                          #isDesiredChar = false
            ]
            <<                                          #go to char
            ============================================================================



            ============ Reading '$' ==================================================
            >>+                                         #isDesiredChar = true
            <<  ------------------------------------
            [                                           #if char != '$'
                ++++++++++++++++++++++++++++++++++++
                >>-                                         #isDesiredChar = false
                <<[->>>+<<<]                                #tmp = char
            ]
            >>>[-<<<+>>>]                               #char = tmp
            <[                                          #if isDesiredChar:
                <+                                          #increment instruction
                >-                                          #isDesiredChar = false
            ]
            <<                                          #go to char
            ============================================================================

            >>>>>[->+<]                                 #continueParsingLineCopy = continueParsingLine
        ]
        >[-<+>]                                         #continueParsingLine = continueParsingLineCopy
        <<<<<<                                          #go to char



        ============ Reading '\n' ==================================================
        >>+                                         #isDesiredChar = true
        <<  ----------
        [                                           #if char != '\n'
            ++++++++++
            >>-                                         #isDesiredChar = false
            <<[->>>+<<<]                                #tmp = char
        ]
        >>>[-<<<+>>>]                               #char = tmp
        <[                                          #if isDesiredChar:
            >>>+                                        #continueParsingLine = true
            <<<                                         #go to isDesiredChar

            ============ Debug only ====================================================
            <++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ .         #print instruction
            [-]                                         #instruction = 0
            ============================================================================

            >-                                          #isDesiredChar = false
        ]
        <<                                          #go to char
        ============================================================================

        >>[-]                                   #isDesiredChar = 0
        <<[-]                                   #char = 0
    ]
    >>>>                                    #go to readChar
]

============ Debug only ====================================================
<<<[                                        #if instruction:
    ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ .          #print instruction
    [-]                                         #instruction = 0
]
============================================================================