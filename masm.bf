========= Instructions ==========
(None)      : 1
G           : 2
S           : 3
(plus)      : 4
(minus)     : 5
J           : 6
C           : 7
R           : 8
W           : 9
=================================

========= Operand Types =========
Direct      : 0
Indirect    : 1
=================================


============ Symbols ============
#0  char
#1  instruction
#2  isDesiredChar
#3  tmp
#4  readChar
#5  continueParsingLine
#6  continueParsingLineCopy
#7  operandType
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
                <+++                                        #instruction = 3
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
                <++++                                       #instruction = 4
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
                <+++++                                      #instruction = 5
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
                <++++++                                     #instruction = 6
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
                <+++++++                                    #instruction = 7
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
                <++++++++                                   #instruction = 8
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
                <+++++++++                                  #instruction = 9
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
                >>>>>+                                      #operandType = 1
                <<<<<-                                      #isDesiredChar = false
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
            <++++++++++++++++++++++++++++++++++++++++++++++++ .         #print instruction
            [-]                                         #instruction = 0

            >>>>>>++++++++++++++++++++++++++++++++++++++++++++++++.     #print operandType
            [-]                                         #operandType = 0
            <<<<<<                                      #go to instruction

            ++++++++++++++++++++++++++++++++.[-]        #print '\s'
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
<<<                                         #go to instruction:
++++++++++++++++++++++++++++++++++++++++++++++++ .          #print instruction
[-]                                         #instruction = 0

>>>>>>++++++++++++++++++++++++++++++++++++++++++++++++.     #print operandType
[-]                                         #operandType = 0

============================================================================