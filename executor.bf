============ Instructions will be like this in memory ============

    Register: Register has a flag to indicate whether the register value is negative

    /= Negative Flag =\ /= Register =\
    |                  |              |
    |       #18        |     #19      |


    Instructions: Instructions start position is fixed in #20; End is dynamic and will be marked by
                  an end mark

     /= Start Mark =\   /= Control =\ /= Instruction =\ /= Op Type =\ /= Operand =\   /== End Mark ==\
    | 0 | 0 | 0 | 0 |  |      1      |        2        |      0      |     65      | | 1 | 0 | 0 | 0 |
    |#20|#21|#22|#23|  |     #24     |       #25       |     #26     |    #27      | |#28|#29|#30|#31|



    User Memory: User memory start is not fixed; It will start after end Mark of instructions;
                 In user memory values can be negative so they have a flag to indicate that

     /== Start Mark ==\  /= Control =\ /= Negative Flag =\ /= Value =\
    |  0  |  0  |  0  | |      1      |        0          |    65    |
    | #32 | #33 | #34 | |     #35     |       #36         |   #37    |

==================================================================


============ Symbols ============
#0  isDesiredInstruction
#1  tmp
#2  operandCopy
#3  isIndirectOperand
#4  skipExecution
#5  skipExecutionCopy
#6  registerCopy
#7  operandCopy2
#8  shouldSkip
#18 registerIsNegative
#19 register
#20 instructionsStart
=================================

+                                       #sets end of program
[<<<<]                                  #go to instructionsStart
>>>>                                    #go to first instructionBlock
-                                       #marks controlSlot to 0

>                                       #go to instruction
[                                       #while instruction
    < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<<
    [-]>[-]>[-]>[-]                         #resets #0 to #3
    >>>>>>>>>>>>>>>>> >>>> [>>>>] >         #go to current instruction slot

    >[                                      #if operandType = indirect
        -                                       #set it to false
        << <<<< [<<<<] <<<<<<<<<<<<<<<<< +      #isIndirectOperand = true
        >>>>>>>>>>>>>>>>> >>>> [>>>>] >>        #go to operandType
    ]

    >                                       #go to current operand
    [
        - <<< <<<< [<<<<] <<<<<<<<<<<<<<<<<<<
        + > +
        >>>>>>>>>>>>>>>>>> >>>> [>>>>] >>>
    ]                                       #operandCopy = tmp = operand
    <<< <<<< [<<<<] <<<<<<<<<<<<<<<<<<<
    [
        -
        >>>>>>>>>>>>>>>>>>> >>>> [>>>>] >>> +
        <<< <<<< [<<<<] <<<<<<<<<<<<<<<<<<<
    ]                                       #operand = tmp


    >>                                      #go to isIndirectOperand
    [                                       #if isIndirectOperand
        -                                       #isIndirectOperand = false
        >>>>>>>>>>>>>>>>> >>>> [>>>>] >> +      #restores operandType

        ========== Retrieving indirect operand ===============
        >> [>>>>] >>> [-]                       #marks first memory entry
        <<< <<<< [<<<<]                         #go to current instruction
        <<<< [<<<<] <<<<<<<<<<<<<<<<<<          #go to operandCopy
        [                                       #while operandCopy
            -                                       #decrement operandCopy
            >>>>>>>>>>>>>>>>>> >>>> [>>>>]          #go to current instruction
            >>>> [>>>>] >>> [>>>] +                 #marks memory entry to false
            >>>[-]                                  #marks next memory entry to true
            <<< [<<<] <<<< [<<<<] <<<< [<<<<]       #go to instructions
            <<<<<<<<<<<<<<<<<<                      #go to operandCopy
        ]

        >>>>>>>>>>>>>>>>>> >>>> [>>>>]          #go to current instruction
        >>>> [>>>>] >>> [>>>] >>                #go to current memory entry value
        [                                       #while current memory value
            -                                       #decrement it
            << <<< [<<<] <<<< [<<<<] <<<< [<<<<]    #go to instructions
            <<<<<<<<<<<<<<<<<<<                     #go to tmp
            + > +                                   #increment tmp and operandCopy
            >>>>>>>>>>>>>>>>>> >>>> [>>>>]          #go to current instruction
            >>>> [>>>>] >>> [>>>] >>                #go to current memory value
        ]

        << <<< [<<<] <<<< [<<<<] <<<< [<<<<]    #go to instructions
        <<<<<<<<<<<<<<<<<<<                     #go to tmp
        [                                       #while tmp
            -                                       #decrement it
            >>>>>>>>>>>>>>>>>>> >>>> [>>>>]         #go to current instruction
            >>>> [>>>>] >>> [>>>] >> +              #increment current memory value
            << <<< [<<<] <<<< [<<<<] <<<< [<<<<]    #go to instructions
            <<<<<<<<<<<<<<<<<<<                     #go to tmp
        ]

        >>>>>>>>>>>>>>>>>>> >>>> [>>>>]         #go to current instruction
        >>>> [>>>>] >>> [>>>] +                 #sets current memory to false
        =====================================
        <<< [<<<] <<<< [<<<<] <<<< [<<<<]       #go to instructions
        <<<<<<<<<<<<<<<<<                       #go to isIndirectOperand
    ]

    <<<                                     #go to isDesiredInstruction

    ============ 'W' instruction  ======================================
    +                                       #isDesiredInstruction = true
    >>>>>>>>>>>>>>>>>>>> >>>> [>>>>] > ---------
    [                                           #if instruction != 'W'
        +++++++++
        < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<< -        #isDesiredChar = false

        >>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
        [
            -
            < <<<< [<<<<] <<<<<<<<<<<<<<<<<<< +
            >>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
        ]                                #tmp = instruction
    ]

    +++++++++
    < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<
    [
        >>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
        ---------
        < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<
        [
            - >>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
            + < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<
        ]
    ]#instruction = tmp


    <[                                      #if isDesiredInstruction
        -                                       #isDesiredInstruction = false

        >>>>>>>>>>>>>>>>>>> .                   #print register value to stdOut

        <<<<<<<<<<<<<<<<<<<                     #go to isDesiredInstruction
    ]
    ============================================================================


    ============ 'R' instruction  ======================================
    +                                       #isDesiredInstruction = true
    >>>>>>>>>>>>>>>>>>>> >>>> [>>>>] > --------
    [                                           #if instruction != 'R'
        ++++++++
        < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<< -        #isDesiredChar = false

        >>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
        [
            -
            < <<<< [<<<<] <<<<<<<<<<<<<<<<<<< +
            >>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
        ]                                #tmp = instruction
    ]

    ++++++++
    < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<
    [
        >>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
        --------
        < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<
        [
            - >>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
            + < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<
        ]
    ]#instruction = tmp


    <[                                      #if isDesiredInstruction
        -                                       #isDesiredInstruction = false

        >>>>>>>>>>>>>>>>>>> ,                   #read value from stdIn to register

        <<<<<<<<<<<<<<<<<<<                     #go to isDesiredInstruction
    ]
    ============================================================================



    ============ 'G' instruction  ======================================
    +                                       #isDesiredInstruction = true
    >>>>>>>>>>>>>>>>>>>> >>>> [>>>>] > --
    [                                           #if instruction != 'G'
        ++
        < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<< -        #isDesiredChar = false

        >>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
        [
            -
            < <<<< [<<<<] <<<<<<<<<<<<<<<<<<< +
            >>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
        ]                                #tmp = instruction
    ]

    ++
    < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<
    [
        >>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
        --
        < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<
        [
            - >>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
            + < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<
        ]
    ]#instruction = tmp


    <[                                      #if isDesiredInstruction
        -                                       #isDesiredInstruction = false


        >>>>>>>>>>>>>>>>>>>> >>>> [>>>>]        #go to current instruction

        ========== Writing Value in Memory ===============
        >>>> [>>>>] >>> [-]                     #marks first memory entry
        <<< <<<< [<<<<]                         #go to current instruction
        <<<< [<<<<] <<<<<<<<<<<<<<<<<<          #go to operandCopy
        [                                       #while operandCopy
            -                                       #decrement operandCopy
            >>>>>>>>>>>>>>>>>> >>>> [>>>>]          #go to current instruction
            >>>> [>>>>] >>> [>>>] +                 #marks memory entry to false
            >>>[-]                                  #marks next memory entry to true
            <<< [<<<] <<<< [<<<<] <<<< [<<<<]       #go to instructions
            <<<<<<<<<<<<<<<<<<                      #go to operandCopy
        ]

        >>>>>>>>>>>>>>>>>> >>>> [>>>>]          #go to current instruction
        >>>> [>>>>] >>> [>>>] >>[-]             #reset current memory entry value


        << <<< [<<<] <<<< [<<<<] <<<< [<<<<]    #go to instructions
        <                                       #go to register
        [                                       #while register
            -                                       #decrement it
            <<<<<<<<<<<<<<<<<< +                    #increment tmp

            >>>>>>>>>>>>>>>>>>> >>>> [>>>>]         #go to current instruction
            >>>> [>>>>] >>> [>>>] >>+               #increment current memory value

            << <<< [<<<] <<<< [<<<<] <<<< [<<<<]    #go to instructions
            <                                       #go to register
        ]

        <<<<<<<<<<<<<<<<<<                      #go to tmp
        [                                       #while tmp
            -                                       #decrement it
            >>>>>>>>>>>>>>>>>> +                    #increment register
            <<<<<<<<<<<<<<<<<<                      #go to tmp
        ]

        >>>>>>>>>>>>>>>>>>> >>>> [>>>>]         #go to current instruction
        >>>> [>>>>] >>> [>>>] +                 #sets current memory to false
        =====================================

        <<< [<<<] <<<< [<<<<] <<<< [<<<<]       #go to instructions
        <<<<<<<<<<<<<<<<<<<<                    #go to isDesiredInstruction
    ]
    ============================================================================




    ============ 'S' instruction  ======================================
    +                                       #isDesiredInstruction = true
    >>>>>>>>>>>>>>>>>>>> >>>> [>>>>] > ---
    [                                           #if instruction != 'S'
        +++
        < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<< -        #isDesiredChar = false

        >>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
        [
            -
            < <<<< [<<<<] <<<<<<<<<<<<<<<<<<< +
            >>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
        ]                                #tmp = instruction
    ]

    +++
    < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<
    [
        >>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
        ---
        < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<
        [
            - >>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
            + < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<
        ]
    ]#instruction = tmp


    <[                                      #if isDesiredInstruction
        -                                       #isDesiredInstruction = false

        >>>>>>>>>>>>>>>>>>>                     #go to register
        [-]                                     #resets register


        <<<<<<<<<<<<<<<<<                       #go to operandCopy
        [ - >>>>>>>>>>>>>>>>> + <<<<<<<<<<<<<<<<< ] #register = operandCopy


        <<                                      #go to isDesiredInstruction
    ]
    ============================================================================



    ============ '=' instruction  ======================================
    +                                       #isDesiredInstruction = true
    >>>>>>>>>>>>>>>>>>>> >>>> [>>>>] > -------
    [                                           #if instruction != 'S'
        +++++++
        < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<< -        #isDesiredChar = false

        >>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
        [
            -
            < <<<< [<<<<] <<<<<<<<<<<<<<<<<<< +
            >>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
        ]                                #tmp = instruction
    ]

    +++++++
    < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<
    [
        >>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
        -------
        < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<
        [
            - >>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
            + < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<
        ]
    ]#instruction = tmp

    ============ Symbols ============
    #0  isDesiredInstruction
    #1  tmp
    #2  operandCopy
    #3  isIndirectOperand
    #4  skipExecution
    #5  skipExecutionCopy
    #6  registerCopy
    #7  operandCopy2
    #8  shouldSkip
    #18 registerIsNegative
    #19 register
    #20 instructionsStart
    =================================

    <[                                      #if isDesiredInstruction
        -                                       #isDesiredInstruction = false

        >>>>>>>> +                              #shouldSkip = true

        >>>>>>>>>>>                             #go to register
        [                                       #while register
            <<<<<<<<<<< [-]                         #shouldSkip = false
            <<<<<<                                  #go to operandCopy
            [                                       #if operandCopy
                >>>>>> +                                #shouldSkip = true
                <<<<<< -                                #decrement operandCopy
                [ - >>>>> + <<<<< ]                     #operandCopy2 = operandCopy
            ]
            >>>>> [ - <<<<< + >>>>> ]               #operandCopy = operandCopy2

            < +                                     #increment registerCopy
            >>>>>>>>>>>>> -                         #decrement register
        ]

        <<<<<<<<<<<<< [ - >>>>>>>>>>>>> + <<<<<<<<<<<<< ] #register = registerCopy

        <<<<                                    #go to operadCopy
        [                                       #if operandCopy
            >>>>>> [-]                              #shouldSkip = false
            <<<<<< [-]                              #operandCopy = 0
        ]

        <<                                      #go to isDesiredInstruction
    ]
    ============================================================================




    ============ (plus) instruction  ======================================
    +                                       #isDesiredInstruction = true
    >>>>>>>>>>>>>>>>>>>> >>>> [>>>>] > ----
    [                                           #if instruction != (plus)
        ++++
        < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<< -        #isDesiredChar = false

        >>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
        [
            -
            < <<<< [<<<<] <<<<<<<<<<<<<<<<<<< +
            >>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
        ]                                #tmp = instruction
    ]

    ++++
    < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<
    [
        >>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
        ----
        < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<
        [
            - >>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
            + < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<
        ]
    ]#instruction = tmp


    <[                                      #if isDesiredInstruction
        -                                       #isDesiredInstruction = false

        >>                                      #go to operandCopy
        [ - >>>>>>>>>>>>>>>>> + <<<<<<<<<<<<<<<<< ] #register plus operandCopy

        <<                                      #go to isDesiredInstruction
    ]
    ============================================================================


    ============ (minus) instruction  ======================================
    +                                       #isDesiredInstruction = true
    >>>>>>>>>>>>>>>>>>>> >>>> [>>>>] > -----
    [                                           #if instruction != (minus)
        +++++
        < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<< -        #isDesiredChar = false

        >>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
        [
            -
            < <<<< [<<<<] <<<<<<<<<<<<<<<<<<< +
            >>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
        ]                                #tmp = instruction
    ]

    +++++
    < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<
    [
        >>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
        -----
        < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<
        [
            - >>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
            + < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<
        ]
    ]#instruction = tmp


    <[                                      #if isDesiredInstruction
        -                                       #isDesiredInstruction = false

        >>                                      #go to operandCopy
        [ - >>>>>>>>>>>>>>>>> - <<<<<<<<<<<<<<<<< ] #register minus operandCopy

        <<                                      #go to isDesiredInstruction
    ]
    ============================================================================

    ====== Skipping line if needed ===========================
    >>>>>>>>                                #go to shouldSkip
    [                                       #if shouldSkip
        [-]                                     #shouldSkip = false
        >>>>>>>>>>>> >>>> [>>>>] +              #marks current instructionBlock as executed
        >>>> -                                  #marks next instructionBlock to execution
        <<<< [<<<<] <<<<<<<<<<<<                #go to shouldSkip
    ]
    <<<<<<<<                                #go to isDesiredInstruction
    ==========================================================

    >>>>>>>>>>>>>>>>>>>> >>>> [>>>>] +      #marks current instructionBlock as executed
    >>>>-                                   #marks next instructionBlock to execution
    >                                       #go to instruction slot
]
