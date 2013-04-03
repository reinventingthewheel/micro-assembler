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
    [-]>[-]>[-]>[-]>[-]>[-]                      #resets #0 to #5

    >>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >      #go to currentInstruction
    [
        - < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<<<<<<<< + <<< +
        >>>>>>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
    ]                                            #tmp = instructionNumber = current instruction

    < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    [
        - >>>>>>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] >
        + < <<<< [<<<<] <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    ]                                            #currentOperand = tmp
    <                                            #go to isDesiredInstruction


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

    ########### Marking Next Instruction for execution ############
    >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> >>>> [>>>>] +    #instruction controlSlot=1
    >>>> -                                          #next instruction=0
    >                                               #go to instruction
    ###############################################################
]
