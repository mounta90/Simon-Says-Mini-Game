	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s

	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY
	

__main	PROC

    ;There are 5 ports that need to be enabled:
    ;   Port A (Joystick & LCD)
    ;   Port B (Red LED & LCD)
    ;   Port C (LCD)
    ;   Port D (LCD)
    ;   Port E (Green LED)

    LDR R0, =RCC_BASE   ;Load in R0, the base address of the RCC register.
    LDR R1, [R0, #RCC_AHB2ENR]  ;Load in R1, the base address of the RCC register offsetted by the constant (#RCC_AHB2ENR) to get to the AHB2ENR register for port enabling.
    LDR R2, =(RCC_AHB2ENR_GPIOAEN :OR: RCC_AHB2ENR_GPIOBEN :OR: RCC_AHB2ENR_GPIOCEN :OR: RCC_AHB2ENR_GPIODEN :OR: RCC_AHB2ENR_GPIOEEN)  ;Load in R2, 32 bits in which the bits that correspond to ports A,B,C,D,and E are [1]. We will use this register in the next lines.
    BIC R1, R1, R2  ;Clear R1, with R2.
    ORR R1, R1, R2  ;Set the bits that correspond to ports A,B,C,D,E by ORing with R2.
    STR R1, [R0, #RCC_AHB2ENR]  ;Store the modified value of R1 back into the AHB2ENR register. This should enable the clocks of the 5 ports that we need.

	ENDP
	END