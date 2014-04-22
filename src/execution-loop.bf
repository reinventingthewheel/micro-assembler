============ Instructions will be like this in memory ============

    Register: Register has a flag to indicate whether the register value is negative

    /= Negative Flag =\ /= Register =\
    |                  |              |
    |       #28        |     #29      |


    Instructions: Instructions start position is fixed in #20; End is dynamic and will be marked by
                  an end mark

     /= Start Mark =\   /= Control =\ /= Instruction =\ /= Op Type =\ /= Operand =\   /== End Mark ==\
    | 0 | 0 | 0 | 0 |  |      1      |        2        |      0      |     65      | | 1 | 0 | 0 | 0 |
    |#30|#31|#32|#33|  |     #34     |       #35       |     #36     |    #37      | |#38|#39|#40|#41|



    User Memory: User memory start is not fixed; It will start after end Mark of instructions;
                 In user memory values can be negative so they have a flag to indicate that

     /== Start Mark ==\  /= Control =\ /= Negative Flag =\ /= Value =\
    |  0  |  0  |  0  | |      1      |        0          |    65    |
    | #42 | #43 | #44 | |     #45     |       #46         |   #47    |

==================================================================


============ Symbols ============
#0  isDesiredInstruction
#1  tmp
#2  isOperandMemory
#3  isOperandPointer
#4  instructionNumber
#5  operand
#6  advanceInstructions
#7  tmp2
#8  reachZero
#9  registerCopy
#28 registerIsNegative
#29 register
#30 instructionsStart
=================================

[<<<<]                                      #go to instructionsStart
>>>>                                        #go to first instructionBlock
-                                           #marks controlSlot to 0

>                                           #go to instruction
[                                           #while instruction
    < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<<<<<<<<<<<< #go to #0
    [-]>[-]>[-]>[-]>[-]>[-]>[-]>[-]>[-]>[-]       #resets #0 to #9

    >>>>>>>>>>>>>>>>>>>> [                      #while register
        -                                           #decrement it
        <<<<<<<<<<<<<<<<<<<< +                      #increment registerCopy
        <<<<<<<< +                                  #increment tmp
        >>>>>>>>>>>>>>>>>>>>>>>>>>>>                #go to register
    ]

    <<<<<<<<<<<<<<<<<<<<<<<<<<<< [
        - >>>>>>>>>>>>>>>>>>>>>>>>>>>>
        + <<<<<<<<<<<<<<<<<<<<<<<<<<<<
    ]                                           #register = tmp

    >>>>> +                                     #advanceInstructions = 1



    ########### Fetching instructionNumber ########################
    >>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >       #go to currentInstruction
    [
        - < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<<<<<<<< + <<< +
        >>>>>>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
    ]                                            #tmp = instructionNumber = current instruction

    < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    [
        - >>>>>>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
        + < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    ]                                            #currentInstruction = tmp
    ###############################################################


    ########### Fetching operandType flags ########################
    >>>>>>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >>  #go to current operandType
    [                                             #if operandType
        -                                              #decrement it

        << <<<< [<<<<] <<<<<<<<<<<<<<<<<<<<<<<<<<<< +  #isOperandMemory = true
        < +                                            #increment tmp

        >>>>>>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >>  #go to current operandType
        [                                             #if operandType
            -                                              #decrement it
            << <<<< [<<<<] <<<<<<<<<<<<<<<<<<<<<<<<<<< +   #isOperandPointer = true
            << +                                           #increment tmp
            >>>>>>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >>   #go to current operandType
        ]
    ]

    << <<<< [<<<<] <<<<<<<<<<<<<<<<<<<<<<<<<<<<<      #go to tmp
    [
        - >>>>>>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >>
        + << <<<< [<<<<] <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    ]                                            #current operandType = tmp
    ###############################################################


    ########### Fetching operand ###################################
    >>>>>>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >>>    #go to current operand
    [
        - <<< <<<< [<<<<] <<<<<<<<<<<<<<<<<<<<<<<<< + <<<< +
        >>>>>>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >>>
    ]                                            #tmp = operand = current operand

    <<< <<<< [<<<<] <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    [
        - >>>>>>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >>>
        + <<< <<<< [<<<<] <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    ]                                            #currentOperand = tmp
    ###############################################################


    ########### Fetching memory operand ############################
    >                                       #go to isOperandMemory
    [                                       #if isOperandMemory
        -                                       #isOperandMemory = false
        >>>>>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >>>> [>>>>]   #go to instructions 'end mark'
        >>> [-]                                                #marks first memory address
        <<<                                                    #go to memory start
        <<<< [<<<<] <<<< [<<<<]                                #go to instructions start
        <<<<<<<<<<<<<<<<<<<<<<<<<                              #go to operand

        [                                       #while operand
            -                                                   #decrement it
            >>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >>>> [>>>>]   #go to instructions 'end mark'
            >>> [>>>]                                           #go to current memory
            +                                                   #mark it as processed
            >>> -                                               #mark next instruction as current
            <<< [<<<]                                           #go to memory start
            <<<< [<<<<] <<<< [<<<<]                             #go to instructions start
            <<<<<<<<<<<<<<<<<<<<<<<<<                           #go to operand
        ]


        >>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >>>> [>>>>]   #go to instructions 'end mark'
        >>> [>>>] >>                                        #go to current memory
        [                                                   #while current memory
            -                                                     #decrement it
            << <<< [<<<]                                          #go to memory start
            <<<< [<<<<] <<<< [<<<<]                               #go to instructions start
            <<<<<<<<<<<<<<<<<<<<<<<<< +                           #increment operand
            <<<< +                                                #increment tmp
            >>>>>>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >>>> [>>>>] #go to instructions 'end mark'
            >>> [>>>] >>                                          #go to current memory
        ]


        << <<< [<<<]                            #go to memory start
        <<<< [<<<<] <<<< [<<<<]                 #go to instructions start
        <<<<<<<<<<<<<<<<<<<<<<<<<<<<<           #go to tmp
        [                                       #while tmp
            -                                       #decrement it
            >>>>>>>>>>>>>>>>>>>>>>>>>>>>>           #go to instructions start
            >>>> [>>>>] >>>> [>>>>]                 #go to instructions 'end mark'

            >>> [>>>] >> +                          #increment current memory
            << <<< [<<<]                            #go to memory start
            <<<< [<<<<] <<<< [<<<<]                 #go to instructions start

            <<<<<<<<<<<<<<<<<<<<<<<<<<<<<           #go to tmp
        ]

        >>>>>>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >>>> [>>>>]  #go to memory start
        >>> [>>>] +                                            #marks currentMemory as processed
        <<< [<<<]                                              #go to memory start
        <<<< [<<<<] <<<< [<<<<]                                #go to instructions start
        <<<<<<<<<<<<<<<<<<<<<<<<<<<<                           #go to isOperandMemory
    ]
    ###############################################################


    ########### Fetching pointer operand ############################
    >                                       #go to isOperandPointer
    [                                       #if isOperandPointer
        -                                       #isOperandPointer = false
        >>>>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >>>> [>>>>]    #go to instructions 'end mark'
        >>> [-]                                                #marks first memory address
        <<<                                                    #go to memory start
        <<<< [<<<<] <<<< [<<<<]                                #go to instructions start
        <<<<<<<<<<<<<<<<<<<<<<<<<                              #go to operand

        [                                       #while operand
            -                                                   #decrement it
            >>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >>>> [>>>>]   #go to instructions 'end mark'
            >>> [>>>]                                           #go to current memory
            +                                                   #mark it as processed
            >>> -                                               #mark next instruction as current
            <<< [<<<]                                           #go to memory start
            <<<< [<<<<] <<<< [<<<<]                             #go to instructions start
            <<<<<<<<<<<<<<<<<<<<<<<<<                           #go to operand
        ]


        >>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >>>> [>>>>]   #go to instructions 'end mark'
        >>> [>>>] >>                                        #go to current memory
        [                                                   #while current memory
            -                                                     #decrement it
            << <<< [<<<]                                          #go to memory start
            <<<< [<<<<] <<<< [<<<<]                               #go to instructions start
            <<<<<<<<<<<<<<<<<<<<<<<<< +                           #increment operand
            <<<< +                                                #increment tmp
            >>>>>>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >>>> [>>>>] #go to instructions 'end mark'
            >>> [>>>] >>                                          #go to current memory
        ]


        << <<< [<<<]                            #go to memory start
        <<<< [<<<<] <<<< [<<<<]                 #go to instructions start
        <<<<<<<<<<<<<<<<<<<<<<<<<<<<<           #go to tmp
        [                                       #while tmp
            -                                       #decrement it
            >>>>>>>>>>>>>>>>>>>>>>>>>>>>>           #go to instructions start
            >>>> [>>>>] >>>> [>>>>]                 #go to instructions 'end mark'

            >>> [>>>] >> +                          #increment current memory
            << <<< [<<<]                            #go to memory start
            <<<< [<<<<] <<<< [<<<<]                 #go to instructions start

            <<<<<<<<<<<<<<<<<<<<<<<<<<<<<           #go to tmp
        ]

        >>>>>>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >>>> [>>>>]  #go to memory start
        >>> [>>>] +                                            #marks currentMemory as processed
        <<< [<<<]                                              #go to memory start
        <<<< [<<<<] <<<< [<<<<]                                #go to instructions start
        <<<<<<<<<<<<<<<<<<<<<<<<<<<                            #go to isOperandPointer
    ]
    ###############################################################


    <<<                                    #go to isDesiredInstruction


    ##################### 'D' instruction  #####################
    +                                       #isDesiredInstruction = true
    >>>> ---
    [                                       #if instructionNumber != 3
        <<<< -                                  #isDesiredInstruction = false
        >>>> [- <<< + >>> ]                     #tmp = instructionNumber
    ]

    +++
    <<<
    [- >>> + <<< ]                          #instructionNumber = tmp


    <[                                      #if isDesiredInstruction
        -                                       #isDesiredInstruction = false
        >>>>>>>>>>>>>>>>>>>>>>>>>>>>>           #go to register
        [ - <<<<<<<<<<<<<<<<<<<<<<<<<<<<
          + >>>>>>>>>>>>>>>>>>>>>>>>>>>> ]      #tmp = register

        > >>>> [>>>>] >>>> [>>>>]                              #go to instructions 'end mark'
        >>> [-]                                                #marks first memory address
        <<<                                                    #go to memory start
        <<<< [<<<<] <<<< [<<<<]                                #go to instructions start
        <<<<<<<<<<<<<<<<<<<<<<<<<                              #go to operand


        [                                       #while operand
            -                                                   #decrement it

            >>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >>>> [>>>>]   #go to instructions 'end mark'
            >>> [>>>]                                           #go to current memory
            +                                                   #mark it as processed
            >>> [-]                                             #mark next instruction as current
            <<< [<<<]                                           #go to memory start
            <<<< [<<<<] <<<< [<<<<]                             #go to instructions start
            <<<<<<<<<<<<<<<<<<<<<<<<<                           #go to operand
        ]

        >>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >>>> [>>>>]      #go to memory start
        >>> [>>>] >> [-]                                       #currentMemory = 0
        << <<< [<<<]                                           #go to memory start
        <<<< [<<<<] <<<< [<<<<]                                #go to instructions start
        <<<<<<<<<<<<<<<<<<<<<<<<<<<<<                          #go to tmp


        [                                       #while tmp
            -                                       #decrement it
            >>>>>>>>>>>>>>>>>>>>>>>>>>>>            #go to register
            +                                       #increment it

            > >>>> [>>>>] >>>> [>>>>]               #go to instructions 'end mark'

            >>> [>>>] >> +                          #increment current memory
            << <<< [<<<]                            #go to memory start
            <<<< [<<<<] <<<< [<<<<]                 #go to instructions start

            <<<<<<<<<<<<<<<<<<<<<<<<<<<<<           #go to tmp
        ]

        >>>>>>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >>>> [>>>>]  #go to memory start
        >>> [>>>] +                                            #marks currentMemory as processed
        <<< [<<<]                                              #go to memory start
        <<<< [<<<<] <<<< [<<<<]                                #go to instructions start
        <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<                         #go to isDesiredInstruction
    ]
    ###############################################################


    ##################### 'L' instruction  #####################
    +                                       #isDesiredInstruction = true
    >>>> --
    [                                       #if instructionNumber != 2
        <<<< -                                  #isDesiredInstruction = false
        >>>> [- <<< + >>> ]                     #tmp = instructionNumber
    ]

    ++
    <<<
    [- >>> + <<< ]                          #instructionNumber = tmp


    <[                                      #if isDesiredInstruction
        -                                       #isDesiredInstruction = false

        >>>>>>>>>>>>>>>>>>>>>>>>>>>>> [-]       #register=0
        <<<<<<<<<<<<<<<<<<<<<<<<                #go to operand
        [- >>>>>>>>>>>>>>>>>>>>>>>> + <<<<<<<<<<<<<<<<<<<<<<<< ] #register = operand
        <<<<<                                   #go to isDesiredInstruction
    ]
    ###############################################################



    ##################### (plus) instruction  #####################
    +                                       #isDesiredInstruction = true
    >>>> ----
    [                                       #if instructionNumber != 4
        <<<< -                                  #isDesiredInstruction = false
        >>>> [- <<< + >>> ]                     #tmp = instructionNumber
    ]

    ++++
    <<<
    [- >>> + <<< ]                          #instructionNumber = tmp


    <[                                      #if isDesiredInstruction
        -                                       #isDesiredInstruction = false
        >>>>>                                   #go to operand
        [                                       #while operand
            -                                       #decrement it
            >>> +                                   #reachZero = true
            >>>>>>>>>>>>>>>>>>>>>                   #go to register
            [                                       #if register
                <<<<<<<<<<<<<<<<<<<<< [-]               #reachZero = false
                >>>>>>>>>>>>>>>>>>>>> [
                    - <<<<<<<<<<<<<<<<<<<<<<<<<<<<
                    + >>>>>>>>>>>>>>>>>>>>>>>>>>>>
                ]                                       #tmp = register
            ]

            <<<<<<<<<<<<<<<<<<<<<<<<<<<< [
                - >>>>>>>>>>>>>>>>>>>>>>>>>>>>
                + <<<<<<<<<<<<<<<<<<<<<<<<<<<<
            ]                                       #register = tmp

            >>>>>>>>>>>>>>>>>>>>>>>>>>>> +          #increment register

            <<<<<<<<<<<<<<<<<<<<<                   #go to reachZero
            [                                       #if reachZero
                >>>>>>>>>>>>>>>>>>>> [-]                #registerIsNegative = false
                <<<<<<<<<<<<<<<<<<<< [-]                #reachZero = false
            ]

            <<<                                     #go to operand
        ]

        <<<<<                                   #go to isDesiredInstruction
    ]
    ###############################################################


    ##################### (minus) instruction  #####################
    +                                       #isDesiredInstruction = true
    >>>> -----
    [                                       #if instructionNumber != 5
        <<<< -                                  #isDesiredInstruction = false
        >>>> [- <<< + >>> ]                     #tmp = instructionNumber
    ]

    +++++
    <<<
    [- >>> + <<< ]                          #instructionNumber = tmp


    <[                                      #if isDesiredInstruction
        -                                       #isDesiredInstruction = false
        >>>>>                                   #go to operand
        [                                       #while operand
            -                                       #decrement it
            >>> +                                   #reachZero = true
            >>>>>>>>>>>>>>>>>>>>>                   #go to register
            [                                       #if register
                <<<<<<<<<<<<<<<<<<<<< [-]               #reachZero = false
                >>>>>>>>>>>>>>>>>>>>> [
                    - <<<<<<<<<<<<<<<<<<<<<<<<<<<<
                    + >>>>>>>>>>>>>>>>>>>>>>>>>>>>
                ]                                       #tmp = register
            ]

            <<<<<<<<<<<<<<<<<<<<<<<<<<<< [
                - >>>>>>>>>>>>>>>>>>>>>>>>>>>>
                + <<<<<<<<<<<<<<<<<<<<<<<<<<<<
            ]                                       #register = tmp

            >>>>>>>>>>>>>>>>>>>>>>>>>>>> -          #decrement register

            <<<<<<<<<<<<<<<<<<<<<                   #go to reachZero
            [                                       #if reachZero
                >>>>>>>>>>>>>>>>>>>> +                  #registerIsNegative = true
                <<<<<<<<<<<<<<<<<<<< [-]                #reachZero = false
            ]

            <<<                                     #go to operand
        ]

        <<<<<                                   #go to isDesiredInstruction
    ]
    ###############################################################


    ##################### 'W' instruction  #####################
    +                                       #isDesiredInstruction = true
    >>>> -----------
    [                                       #if instructionNumber != 11
        <<<< -                                  #isDesiredInstruction = false
        >>>> [- <<< + >>> ]                     #tmp = instructionNumber
    ]

    +++++++++++
    <<<
    [- >>> + <<< ]                          #instructionNumber = tmp


    <[                                      #if isDesiredInstruction
        -                                       #isDesiredInstruction = false

        >>>>>>>>>>>>>>>>>>>>>>>>>>>>>.         #print register value to stdOut

        <<<<<<<<<<<<<<<<<<<<<<<<<<<<<           #go to isDesiredInstruction
    ]
    ###############################################################



    ##################### 'R' instruction  #####################
    +                                       #isDesiredInstruction = true
    >>>> ----------
    [                                       #if instructionNumber != 10
        <<<< -                                  #isDesiredInstruction = false
        >>>> [- <<< + >>> ]                     #tmp = instructionNumber
    ]

    ++++++++++
    <<<
    [- >>> + <<< ]                          #instructionNumber = tmp


    <[                                      #if isDesiredInstruction
        -                                       #isDesiredInstruction = false

        >>>>>>>>>>>>>>>>>>>>>>>>>>>>>,          #register=getch()

        <<<<<<<<<<<<<<<<<<<<<<<<<<<<<           #go to isDesiredInstruction
    ]
    ###############################################################



    ##################### (equals) instruction  #####################
    +                                       #isDesiredInstruction = true
    >>>> -------
    [                                       #if instructionNumber != 7
        <<<< -                                  #isDesiredInstruction = false
        >>>> [- <<< + >>> ]                     #tmp = instructionNumber
    ]

    +++++++
    <<<
    [- >>> + <<< ]                          #instructionNumber = tmp

    <[                                      #if isDesiredInstruction
        -                                       #isDesiredInstruction = false
        >>>>>>>>>                               #go to registerCopy
        [                                       #while registerCopy
            -                                       #decrement registerCopy
            <<<< -                                  #decrement operand
            >>>>                                    #go to registerCopy
        ]

        #incrementing this will cause one instruction to be skipped
        #we will revert this increment in case the values are different
        <<< +                             #increment advanceInstructions

        <                                  #go to operand
        [                                  #if operand
            #if we enter this It means the values are different
            > -                                 #decrement advanceInstructions
            <                                   #go to operand
            [-]                                 #operand = 0
        ]
        <<<<<                               #go to isDesiredInstruction
    ]
    ###############################################################


    ##################### (gt) instruction  #####################
    +                                       #isDesiredInstruction = true
    >>>> ---------
    [                                       #if instructionNumber != 9
        <<<< -                                  #isDesiredInstruction = false
        >>>> [- <<< + >>> ]                     #tmp = instructionNumber
    ]

    +++++++++
    <<<
    [- >>> + <<< ]                          #instructionNumber = tmp

    <[                                      #if isDesiredInstruction
        -                                       #isDesiredInstruction = false
        >>>>>>>>>                               #go to registerCopy
        [                                       #while registerCopy
            -                                       #decrement registerCopy
            < +                                     #reachZero = true
            <<<                                     #go to operand
            [                                       #if operand
                >>> -                                   #reachZero = false
                <<< -                                   #decrement operand
                [ <<<< - >>>> + ]                           #tmp = operand
            ]
            <<<< [ - >>>> + <<<< ]                  #operand = tmp

            >>>>>>>                                 #go to reachZero
            [                                       #if reachZero
                #if operand reach zero it means that the register
                #is greater than operand
                #so we should skip one instruction
                << +                                    #increment advanceInstructions
                >>>                                     #go to registerCopy
                [-]                                     #registerCopy = 0
                < [-]                                   #reachZero = false
            ]

            >                                       #go to registerCopy
        ]

        <<<<<<<<<                               #go to isDesiredInstruction
    ]
    ###############################################################



    ##################### (lt) instruction  #####################
    +                                       #isDesiredInstruction = true
    >>>> --------
    [                                       #if instructionNumber != 8
        <<<< -                                  #isDesiredInstruction = false
        >>>> [- <<< + >>> ]                     #tmp = instructionNumber
    ]

    ++++++++
    <<<
    [- >>> + <<< ]                          #instructionNumber = tmp

    <[                                      #if isDesiredInstruction
        -                                       #isDesiredInstruction = false
        >>>>>                                   #go to operand
        [                                       #while operand
            -                                       #decrement operand
            >>> +                                   #reachZero = true
            >                                       #go to registerCopy
            [                                       #if registerCopy
                < -                                     #reachZero = false
                > -                                     #decrement registerCopy
                [ <<<<<<<< -
                  >>>>>>>> + ]                          #tmp = registerCopy
            ]

            <<<<<<<<                                #go to tmp
            [ >>>>>>>> -
              <<<<<<<< +]                           #registerCopy = tmp

            >>>>>>>                                 #go to reachZero
            [                                       #if reachZero
                #if register reach zero it means that the register
                #is less than operand
                #so we should skip one instruction
                << +                                    #increment advanceInstructions
                < [-]                                   #operand = 0
                >>> [-]                                 #reachZero = false
            ]
            <<<                                     #go to operand
        ]

        <<<<<                               #go to isDesiredInstruction
    ]
    ###############################################################



    ##################### 'J' instruction  #####################
    +                                       #isDesiredInstruction = true
    >>>> ------
    [                                       #if instructionNumber != 6
        <<<< -                                  #isDesiredInstruction = false
        >>>> [- <<< + >>> ]                     #tmp = instructionNumber
    ]

    ++++++
    <<<
    [- >>> + <<< ]                          #instructionNumber = tmp


    <[                                      #if isDesiredInstruction
        -                                       #isDesiredInstruction = false

        >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] +  #instruction controlSlot=1
        [<<<<] >>>> -                                 #mark first instruction

        <<<< <<<<<<<<<<<<<<<<<<<<<<<<<          #go to operand

        # we decrement the operand once since the first operation
        # is already marked
        -                                       #decrement operand
        [                                       #while operand
            -                                       #decrement operand
            >>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] + #disable current instruction
            >>>> -                                  #mark next instruction
            <<<< [<<<<] <<<<<<<<<<<<<<<<<<<<<<<<<   #go to operand
        ]

        >[-]                                #advanceInstructions = 0
        <<<<<<                              #go to isDesiredInstruction
    ]
    ###############################################################


    ########### Marking Next Instruction for execution ############
    >>>>>>                                  #go to advanceInstructions
    [                                           #while advanceInstructions
        -                                           #decrement advanceInstructions
        >>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] +      #instruction controlSlot=1
        >>>> -                                      #next instruction=0
        <<<< [<<<<] <<<<<<<<<<<<<<<<<<<<<<<<        #go to advanceInstructions
    ]

    >>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >   #go to current instruction number
    ###############################################################
]
