	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s

	AREA myDATA, DATA
		
GPIO_AFRH_AFRH0_LCD EQU 0x0000000B
GPIO_AFRH_AFRH1_LCD EQU 0x000000B0
GPIO_AFRH_AFRH2_LCD EQU 0x00000B00
GPIO_AFRH_AFRH3_LCD EQU 0x0000B000
GPIO_AFRH_AFRH4_LCD EQU 0x000B0000
GPIO_AFRH_AFRH5_LCD EQU 0x00B00000
GPIO_AFRH_AFRH6_LCD EQU 0x0B000000
GPIO_AFRH_AFRH7_LCD EQU 0xB0000000

	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY

__main	PROC

     ;The LCD setup requires configuration of pins 8,9,10,11,12,13,14,15 of port D.

     ;Set the mode of pins 8,9,10,11,12,13,14,15 to 'alternate function' [10].
     LDR R0, =GPIOD_BASE    ;Load in R0, the base address of GPIO port D.
     LDR R1, [R0, #GPIO_MODER]  ;Load in R1, the base address of GPIOD offsetted by the constant (#GPIO_MODER) to get to the mode register of GPIOD.
     LDR R2, =(GPIO_MODER_MODER8 :OR: GPIO_MODER_MODER9 :OR: GPIO_MODER_MODER10 :OR: GPIO_MODER_MODER11 :OR: GPIO_MODER_MODER12 :OR: GPIO_MODER_MODER13 :OR: GPIO_MODER_MODER14 :OR: GPIO_MODER_MODER15)    ;Load in R2, 32 bits in which each 2 bits that correspond to pins 8,9,10,11,12,13,14,15 are set to [11]. This register will be used for clearing.
     BIC R1, R1, R2     ;Clear each 2 bits that correspond to pins 8,9,10,11,12,13,14,15 in R1, using R2.
     LDR R3, =(GPIO_MODER_MODER8_1 :OR: GPIO_MODER_MODER9_1 :OR: GPIO_MODER_MODER10_1 :OR: GPIO_MODER_MODER11_1 :OR: GPIO_MODER_MODER12_1 :OR: GPIO_MODER_MODER13_1 :OR: GPIO_MODER_MODER14_1 :OR: GPIO_MODER_MODER15_1)    ;Load in R3, 32 bits in which each 2 bits that correspond to pins 8,9,10,11,12,13,14,15 are set to [10]. This register will be used for setting.
     ORR R1, R1, R3     ;Set each 2 bits that correspond to pins 8,9,10,11,12,13,14,15 in R1, by ORing with R3.
     STR R1, [R0, #GPIO_MODER]  ;Store the modified value of R1, back into the mode register of GPIOD.


     ;Set the pins 8,9,10,11,12,13,14,15 as 'no pull-up/pull-down' [00].
     LDR R1, [R0, #GPIO_PUPDR]  ;Load in R1, the base address of GPIOD offsetted by the constant (#GPIO_PUPDR) to get to the PUPDR register of GPIOD.
     LDR R2, =(GPIO_PUPDR_PUPDR8 :OR: GPIO_PUPDR_PUPDR9 :OR: GPIO_PUPDR_PUPDR10 :OR: GPIO_PUPDR_PUPDR11 :OR: GPIO_PUPDR_PUPDR12 :OR: GPIO_PUPDR_PUPDR13 :OR: GPIO_PUPDR_PUPDR14 :OR: GPIO_PUPDR_PUPDR15)    ;Load in R2, 32 bits in which each 2 bits that correspond to pins 8,9,10,11,12,13,14,15 are set to [11]. This register will be used to clearing and setting at the same time.
     BIC R1, R1, R2     ;Clear and set the bits that correspond to pins 8,9,10,11,12,13,14,15 to [00].
     STR R1, [R0, #GPIO_PUPDR]  ;Store the modified value of R1 back into the PUPDR register of GPIOD.


    ;Set the speed of pins 8,9,10,11,12,13,14,15 to 'fast' [10].
     LDR R1, [R0, #GPIO_OSPEEDR]    ;Load in R1, the base address of GPIOD offsetted by the constant (#GPIO_OSPEEDR) to get to the OSPEED register of GPIOD.
     LDR R2, =(GPIO_OSPEEDER_OSPEEDR8 :OR: GPIO_OSPEEDER_OSPEEDR9 :OR: GPIO_OSPEEDER_OSPEEDR10 :OR: GPIO_OSPEEDER_OSPEEDR11 :OR: GPIO_OSPEEDER_OSPEEDR12 :OR: GPIO_OSPEEDER_OSPEEDR13 :OR: GPIO_OSPEEDER_OSPEEDR14 :OR: GPIO_OSPEEDER_OSPEEDR15)    ;Load in R2, 32 bits in which each 2 bits that correspond to the pins 8,9,10,11,12,13,14,15 are set to [11]. This register will be used for clearing.
     BIC R1, R1, R2     ;Clear the bits that correspond to pins 8,9,10,11,12,13,14,15 in R1, by using R2.
     LDR R3, =(GPIO_OSPEEDER_OSPEEDR8_1 :OR: GPIO_OSPEEDER_OSPEEDR9_1 :OR: GPIO_OSPEEDER_OSPEEDR10_1 :OR: GPIO_OSPEEDER_OSPEEDR11_1 :OR: GPIO_OSPEEDER_OSPEEDR12_1 :OR: GPIO_OSPEEDER_OSPEEDR13_1 :OR: GPIO_OSPEEDER_OSPEEDR14_1 :OR: GPIO_OSPEEDER_OSPEEDR15_1)    ;Load in R3, 32 bits in which each 2 bits that correspond to the pins 8,9,10,11,12,13,14,15 are set to [10]. This register will be used for setting.
     ORR R1, R1, R3     ;Set the bits corresponding to pins 8,9,10,11,12,13,14,15 to [10] by ORing with R3.
     STR R1, [R0, #GPIO_OSPEEDR]    ;Store the modified value of R1 back into the OSPEEDR register of GPIOD. 


     ;Set pins 8,9,10,11,12,13,14,15 to 'LCD' [1011] or 0xB.

     ;Pins 8,9,10,11,12,13,14,15 are found in the higher alternate function register.
     LDR R1, [R0, #GPIO_AFRH]   ;Load in R1, the base address of GPIOD offsetted by the constant (#GPIO_AFRH) to get to the higher alternate function register.
     LDR R2, =(GPIO_AFRH_AFRH0 :OR: GPIO_AFRH_AFRH1 :OR: GPIO_AFRH_AFRH2 :OR: GPIO_AFRH_AFRH3 :OR: GPIO_AFRH_AFRH4 :OR: GPIO_AFRH_AFRH5 :OR: GPIO_AFRH_AFRH6 :OR: GPIO_AFRH_AFRH7)  ;Load in R2, 32 bits in which each 4 bits that correspond to pins 8,9,10,11,12,13,14,15 are set to [1111]. This register will be used for clearing.
     BIC R1, R1, R2     ;Clear the bits that correspond to pins 8,9,10,11,12,13,14,15 using R2.
     LDR R3, =(GPIO_AFRH_AFRH0_LCD :OR: GPIO_AFRH_AFRH1_LCD :OR: GPIO_AFRH_AFRH2_LCD :OR: GPIO_AFRH_AFRH3_LCD :OR: GPIO_AFRH_AFRH4_LCD :OR: GPIO_AFRH_AFRH5_LCD :OR: GPIO_AFRH_AFRH6_LCD :OR: GPIO_AFRH_AFRH7_LCD)  ;Load in R3, 32 bits in which each 4 bits that correspond to pins 8,9,10,11,12,13,14,15 are set to [1011]. This register will be used for setting.
     ORR R1, R1, R3     ;Set the bits that correspond to pins 8,9,10,11,12,13,14,15 in R1 to [1011] by ORing with R3.
     STR R1, [R0, #GPIO_AFRH]   ;Store the modified value of R1 back into the higher alternate function register of GPIOD.

	ENDP
	END