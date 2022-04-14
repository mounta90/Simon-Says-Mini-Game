	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s

	AREA myDATA, DATA
		
GPIO_AFRL_AFRL0_LCD EQU 0x0000000B
GPIO_AFRL_AFRL1_LCD EQU 0x000000B0
GPIO_AFRL_AFRL4_LCD EQU 0x000B0000
GPIO_AFRL_AFRL5_LCD EQU 0x00B00000
		
GPIO_AFRH_AFRH1_LCD EQU 0x000000B0
GPIO_AFRH_AFRH4_LCD EQU 0x000B0000
GPIO_AFRH_AFRH5_LCD EQU 0x00B00000
GPIO_AFRH_AFRH6_LCD EQU 0x0B000000
GPIO_AFRH_AFRH7_LCD EQU 0xB0000000

	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY

__main	PROC

    ;For the Red LED, pin 2 needs to be configured.
    ;For the LCD, pins 0,1,4,5,9,12,13,14,15 need to be configured.


    ;(Red LED) Set the mode of pin 2 to 'output' [01].
    ;(LCD) Set the mode of pins 0,1,4,5,9,12,13,14,15 to 'alternate function' [10].
    LDR R0, =GPIOB_BASE ;Load the base address of GPIOB into R0.
    LDR R1, [R0, #GPIO_MODER]   ;Load in R1, the base address of GPIOB offsetted by the constant (#GPIO_MODER) to get you the MODER register bits of GPIOB.
    LDR R2, =(GPIO_MODER_MODER0 :OR: GPIO_MODER_MODER1 :OR: GPIO_MODER_MODER2 :OR: GPIO_MODER_MODER4 :OR: GPIO_MODER_MODER5 :OR: GPIO_MODER_MODER9 :OR: GPIO_MODER_MODER12 :OR: GPIO_MODER_MODER13 :OR: GPIO_MODER_MODER14 :OR: GPIO_MODER_MODER15) ;Load in R2, 32 bits in which the 2 bits that correspond to pins 0,1,2,4,5,9,12,13,14,15 are set to [11]. This will be used for clearing.
    BIC R1, R1, R2  ;Clear the bits that correspond to pins 0,1,2,4,5,9,12,13,14,15 by using R2.
    LDR R3, =(GPIO_MODER_MODER0_1 :OR: GPIO_MODER_MODER1_1 :OR: GPIO_MODER_MODER2_0 :OR: GPIO_MODER_MODER4_1 :OR: GPIO_MODER_MODER5_1 :OR: GPIO_MODER_MODER9_1 :OR: GPIO_MODER_MODER12_1 :OR: GPIO_MODER_MODER13_1 :OR: GPIO_MODER_MODER14_1 :OR: GPIO_MODER_MODER15_1) ;Load in R3, 32 bits in which the corresponding bits to the pins 0,1,2,4,5,9,12,13,14,15 are given the required values for their wanted modes.
    ORR R1, R1, R3  ;Set the bits that correspond to the pins 0,1,2,4,5,9,12,13,14,15 to their wanted bits by ORing with R3.
    STR R1, [R0, #GPIO_MODER]   ;Store the modified value of R1, back to the GPIOB Mode register.


    ;(Red LED) Set the output type of pin 2 to 'push-pull' [0].
    LDR R1, [R0, #GPIO_OTYPER]  ;Load in R1, the base address of GPIOB offsetted by the constant (#GPIO_OTYPER) to get you the OTYPER register bits of GPIOB.
    BIC R1, R1, #GPIO_OTYPER_OT_2    ;Clears bit #2 of R1, then places the result back into R1... This will also set the output type to push-pull at the same time, which is what we need.
    STR R1, [R0, #GPIO_OTYPER]  ;Stores modified version of R1 back into the OTYPER register of GPIOB.


    ;(Red LED) Set pin 2 as 'no pull-up/pull-down' [00].
    ;(LCD) Set pins 0,1,4,5,9,12,13,14,15 as 'no pull-up/pull-down' [00].
    LDR R1, [R0, #GPIO_PUPDR]   ;Load in R1, the base address of GPIOB offsetted by the constant (#GPIO_PUPDR) to get the bit values of the PUPDR register.
    LDR R2, =(GPIO_PUPDR_PUPDR0 :OR: GPIO_PUPDR_PUPDR1 :OR: GPIO_PUPDR_PUPDR2 :OR: GPIO_PUPDR_PUPDR4 :OR: GPIO_PUPDR_PUPDR5 :OR: GPIO_PUPDR_PUPDR9 :OR: GPIO_PUPDR_PUPDR12 :OR: GPIO_PUPDR_PUPDR13 :OR: GPIO_PUPDR_PUPDR14 :OR: GPIO_PUPDR_PUPDR15)     ;Load in R2, 32 bits in which each 2 bits that correspond to pins 0,1,2,4,5,9,12,13,14,15 are set to [00]. This register will be used to clear and set to 'no pull-up/pull-down' at the same time.
    BIC R1, R1, R2      ;Clear and set the bits that correspond to pins 0,1,2,4,5,9,12,13,14,15 to [00] by using R2.
    STR R1, [R0, #GPIO_PUPDR]   ;Store the modified value of R1 back to the PUPDR register of GPIOB.

    ;(LCD) Set the speed of pins 0,1,4,5,9,12,13,14,15 to 'fast' [10].
    LDR R1, [R0, #GPIO_OSPEEDR]     ;Load in R1, the base address of GPIOB offsetted by the constant (#GPIO_OSPEEDR) to get to the OSPEED register.
    LDR R2, =(GPIO_OSPEEDER_OSPEEDR0 :OR: GPIO_OSPEEDER_OSPEEDR1 :OR: GPIO_OSPEEDER_OSPEEDR4 :OR: GPIO_OSPEEDER_OSPEEDR5 :OR: GPIO_OSPEEDER_OSPEEDR9 :OR: GPIO_OSPEEDER_OSPEEDR12 :OR: GPIO_OSPEEDER_OSPEEDR13 :OR: GPIO_OSPEEDER_OSPEEDR14 :OR: GPIO_OSPEEDER_OSPEEDR15)   ;Load in R2, 32 bits in which each 2 bits that corresponds to pins 0,1,4,5,9,12,13,14,15 to [11]. This register will be used for clearing.
    LDR R3, =(GPIO_OSPEEDER_OSPEEDR0_1 :OR: GPIO_OSPEEDER_OSPEEDR1_1 :OR: GPIO_OSPEEDER_OSPEEDR4_1 :OR: GPIO_OSPEEDER_OSPEEDR5_1 :OR: GPIO_OSPEEDER_OSPEEDR9_1 :OR: GPIO_OSPEEDER_OSPEEDR12_1 :OR: GPIO_OSPEEDER_OSPEEDR13_1 :OR: GPIO_OSPEEDER_OSPEEDR14_1 :OR: GPIO_OSPEEDER_OSPEEDR15_1) ;Load in R3, 32 bits in which each 2 bits that correspond to pins 0,1,4,5,9,12,13,14,15 are set to [10]. This register will be used for setting.
    ORR R1, R1, R3  ;Set the bits that correspond to pins 0,1,4,5,9,12,13,14,15 by ORing with R3.
    STR R1, [R0, #GPIO_OSPEEDR]
    

    ;(LCD) Set function of pins 0,1,4,5,9,12,13,14,15 to 'LCD' [1011] or 0xB in the Alternate Function register.

    ;The pins 0,1,4,5 are located in the lower Alternate Function register.
    LDR R1, [R0, #GPIO_AFRL]
    LDR R2, =(GPIO_AFRL_AFRL0 :OR: GPIO_AFRL_AFRL1 :OR: GPIO_AFRL_AFRL4 :OR: GPIO_AFRL_AFRL5)   ;Load in R2, 32 bits in which the corresponding 4 bits to pins 0,1,4,5 are set to [1111]. This register will be used for clearing.
    BIC R1, R1, R2  ;Clear the corresponding bits of pins 0,1,4,5 in R1, by using R2.
    LDR R3, =(GPIO_AFRL_AFRL0_LCD :OR: GPIO_AFRL_AFRL1_LCD :OR: GPIO_AFRL_AFRL4_LCD :OR: GPIO_AFRL_AFRL5_LCD)   ;Load in R3, 32 bits in which the corresponding bits to pins 0,1,4,5 are set to [1011]. This register will be used in setting.
    ORR R1, R1, R3  ;Set the bits that correspond to pins 0,1,4,5 to [1011] in R1, by ORing with R3.
    STR R1, [R0, #GPIO_AFRL]    ;Store the modified value of R1 back into the lower Alternate function of GPIOB.


    ;The pins 9,12,13,14,15 are located in the higher Alternate Function register.
    LDR R1, [R0, #GPIO_AFRH]    ;Load in R1, the base address of GPIOB offsetted by the constant (#GPIO_AFRH) to get to the higher Alternate function register.
    LDR R2, =(GPIO_AFRH_AFRH1 :OR: GPIO_AFRH_AFRH4 :OR: GPIO_AFRH_AFRH5 :OR: GPIO_AFRH_AFRH6 :OR: GPIO_AFRH_AFRH7)  ;Load in R2, 32 bits in which the 4 corresponding bits to pins 9,12,13,14,15 are set to [1111]. This register will be used in clearing.
    BIC R1, R1, R2  ;Clear the bits that correspond to pins 9,12,13,14,15 by using R2.
    LDR R3, =(GPIO_AFRH_AFRH1_LCD :OR: GPIO_AFRH_AFRH4_LCD :OR: GPIO_AFRH_AFRH5_LCD :OR: GPIO_AFRH_AFRH6_LCD :OR: GPIO_AFRH_AFRH7_LCD)  ;Load in R3, 32 bits in which the 4 bits that correspond to pins 9,12,13,14,15 are set to [1011]. This register will be used in setting.
    ORR R1, R1, R3  ;Set the bits that correspond to pins 9,12,13,14,15 to [1011], by using R3.
    STR R1, [R0, #GPIO_AFRH]    ;Store the modified value of R1 back into the higher alternate function register of GPIOB. 

	ENDP
	END