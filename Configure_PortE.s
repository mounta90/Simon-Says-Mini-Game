	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s

	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY
	

__main	PROC

    ; The Green LED is GPIOE Pin 8

    ;Set the mode of GPIO Port E pin 8 to 'output' [01].
    LDR R0, =GPIOE_BASE ;Load in R0, the base address of GPIO Port E.
    LDR R1, [R0, #GPIO_MODER]   ;Load in R1, the base address of GPIOE offsetted by the constant (#GPIO_MODER) to get you to the bits of the Mode register of GPIOE.
    BIC R1, R1, #GPIO_MODER_MODER8   ;Clear the 2 bits that correspond to Pin 8 of GPIOE.
    ORR R1, R1, #GPIO_MODER_MODER8_0    ;Set the 2 bits that correspond to Pin 8 to 'output' mode [01].
    STR R1, [R0, #GPIO_MODER]   ;Store the modified value of R1 back into the GPIOE mode register.


    ;Set the output type of GPIOE to 'push-pull' [0].
    LDR R1, [R0, #GPIO_OTYPER]  ;Load in R1, the base address of GPIOE offsetted by the constant (#GPIO_OTYPER) to get to the address of the OTYPE register of GPIOE.
    BIC R1, R1, #GPIO_OTYPER_OT_8   ;Clear the bit that corresponds to pin 8 of OTYPE register of GPIOE.
    ORR R1, R1, #GPIO_OTYPER_OT_8   ;Set the bit that corresponds to pin 8 of the OTYPE register of GPIOE.
    STR R1, [R0, #GPIO_OTYPER]  ;Store the modified value of R1, back into the OTYPE register of GPIOE.


    ;Set GPIOE as 'no pull-up/pull-down' [00].
    LDR R1, [R0, #GPIO_PUPDR]   ;Load in R1, the base address of GPIOE offsetted by the constant (#GPIO_PUPDR) to get to the address of the PUPDR register of GPIOE.
    BIC R1, R1, #GPIO_PUPDR_PUPDR8   ;Clear the 2 bits that correspond to pin 8 in the PUPDR register of GPIOE. This will also set it to 'no pull-up/pull-down' at the same time.
    STR R1, [R0, #GPIO_PUPDR]   ;Store the modified value of R1, back into the GPIOE PUPDR register.

	ENDP
	END