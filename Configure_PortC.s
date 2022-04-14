	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s

	AREA myDATA, DATA
		
GPIO_AFRL_AFRL3_LCD EQU 0x0000B000
GPIO_AFRL_AFRL4_LCD EQU 0x000B0000
GPIO_AFRL_AFRL5_LCD EQU 0x00B00000
GPIO_AFRL_AFRL6_LCD EQU 0x0B000000
GPIO_AFRL_AFRL7_LCD EQU 0xB0000000
			 
GPIO_AFRH_AFRH0_LCD EQU 0x0000000B

	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY

__main	PROC

	 ;The LCD setup requires configuration of pins 3,4,5,6,7,8 of port C.

     ;Set the mode of pins 3,4,5,6,7,8 to 'alternate function' [10].
     LDR R0, =GPIOC_BASE    ;Load in R0, the base address of GPIO port C.
     LDR R1, [R0, #GPIO_MODER]  ;Load in R1, the base address of GPIOC offsetted by the constant (#GPIO_MODER) to get to the mode register of GPIOC.
     LDR R2, =(GPIO_MODER_MODER3 :OR: GPIO_MODER_MODER4 :OR: GPIO_MODER_MODER5 :OR: GPIO_MODER_MODER6 :OR: GPIO_MODER_MODER7 :OR: GPIO_MODER_MODER8)    ;Load in R2, 32 bits in which each 2 corresponding bits to pins 3,4,5,6,7,8 are set to [11]. This register will be used in clearing.
     BIC R1, R1, R2     ;Clear each 2 bits that correspond to pins 3,4,5,6,7,8 with the use of R2.
     LDR R3, =(GPIO_MODER_MODER3_1 :OR: GPIO_MODER_MODER4_1 :OR: GPIO_MODER_MODER5_1 :OR: GPIO_MODER_MODER6_1 :OR: GPIO_MODER_MODER7_1 :OR: GPIO_MODER_MODER8_1)    ;Load in R3, 32 bits in which each 2 bits that correspond to pins 3,4,5,6,7,8 are set to [10]. This register will be used in setting.
     ORR R1, R1, R3     ;Set each 2 bits that correspond to pins 3,4,5,6,7,8 to [10] in R1, by ORing with R3.
     STR R1, [R0, #GPIO_MODER]  ;Store the modified value of R1, back into the mode register of GPIOC.


     ;(LCD) Set the pins 3,4,5,6,7,8 as 'no pull-up/pull-down' [00].
     LDR R1, [R0, #GPIO_PUPDR]  ;Load in R1, the base address of GPIOC offsetted by the constant (#GPIO_PUPDR) to get to the PUPDR register.
     LDR R2, =(GPIO_PUPDR_PUPDR3 :OR: GPIO_PUPDR_PUPDR4 :OR: GPIO_PUPDR_PUPDR5 :OR: GPIO_PUPDR_PUPDR6 :OR: GPIO_PUPDR_PUPDR7 :OR: GPIO_PUPDR_PUPDR8)    ;Load in R2, 32 bits in which each 2 bits that correspond to pins 3,4,5,6,7,8 are set to [11]. This register will be used in clearing and setting to 'no pull-up/pull-down'.
     BIC R1, R1, R2     ;Clear and set the bits which correspond to pins 3,4,5,6,7,8 in R1, using R2.
     STR R1, [R0, #GPIO_PUPDR]  ;Store the modified value of R1 back into the PUPDR register of GPIOC.


     ;(LCD) Set the speed of pins 3,4,5,6,7,8 as 'fast' [10].
     LDR R1, [R0, #GPIO_OSPEEDR]    ;Load in R1, the base address of GPIOC offsetted by the constant (#GPIO_OSPEEDR) to get to the OSPEED register of GPIOC.
     LDR R2, =(GPIO_OSPEEDER_OSPEEDR3 :OR: GPIO_OSPEEDER_OSPEEDR4 :OR: GPIO_OSPEEDER_OSPEEDR5 :OR: GPIO_OSPEEDER_OSPEEDR6 :OR: GPIO_OSPEEDER_OSPEEDR7 :OR: GPIO_OSPEEDER_OSPEEDR8)  ;Load in R2, 32 bits in which each 2 bits corresponding to the pins 3,4,5,6,7,8 are set to [11]. This register will be used in clearing.
     BIC R1, R1, R2     ;Clear the bits that correspond to the pins 3,4,5,6,7,8 in R1 using R2.
     LDR R3, =(GPIO_OSPEEDER_OSPEEDR3_1 :OR: GPIO_OSPEEDER_OSPEEDR4_1 :OR: GPIO_OSPEEDER_OSPEEDR5_1 :OR: GPIO_OSPEEDER_OSPEEDR6_1 :OR: GPIO_OSPEEDER_OSPEEDR7_1 :OR: GPIO_OSPEEDER_OSPEEDR8_1)  ;Load in R3, 32 bits in which each 2 bits that correspond to pins 3,4,5,6,7,8 are set to [10]. This register will be used in setting.
     ORR R1, R1, R3     ;Set the bits that correspond to pins 3,4,5,6,7,8 to [10] in R1, by ORing with R3.
     STR R1, [R0, #GPIO_OSPEEDR]    ;Store the modified value of R1 back into the OSPEED register of GPIOC.
     

     ;Set pins 3,4,5,6,7,8 to 'LCD' [1011] or 0xB.

     ;Pins 3,4,5,6,7 are located in the lower Alternate Function register.
     LDR R1, [R0, #GPIO_AFRL]   ;Load in R1, the base address of GPIOC offsetted by the constant (#GPIO_AFRL) to get to the lower Alternate Function register.
     LDR R2, =(GPIO_AFRL_AFRL3 :OR: GPIO_AFRL_AFRL4 :OR: GPIO_AFRL_AFRL5 :OR: GPIO_AFRL_AFRL6 :OR: GPIO_AFRL_AFRL7)    ;Load in R2, 32 bits in which each 4 bits that correspond to pins 3,4,5,6,7 are set to [1111]. This register will be used for clearing.
     BIC R1, R1, R2     ;Clear in R1, each 4 bits that correspond to pins 3,4,5,6,7 by using R2.
     LDR R3, =(GPIO_AFRL_AFRL3_LCD :OR: GPIO_AFRL_AFRL4_LCD :OR: GPIO_AFRL_AFRL5_LCD :OR: GPIO_AFRL_AFRL6_LCD :OR: GPIO_AFRL_AFRL7_LCD)     ;Load in R3, 32 bits in which each 4 bits that correspond to pins 3,4,5,6,7 are set to [1011]. This register will be used for setting.
     ORR R1, R1, R3     ;Set in R1, each 4 bits that corresponds to pins 3,4,5,6,7 to [1011], by ORing with R3.
     STR R1, [R0, #GPIO_AFRL]   ;Store the modified value of R1 back into the lower Alternate Function register.


     ;Pin 8 is located in the higher Alternate Function register.
     LDR R1, [R0, #GPIO_AFRH]   ;Load in R1, the base address of GPIOC, offsetted by the constant (#GPIO_AFRH) to get to the higher Alternate Function register.
     BIC R1, R1, #GPIO_AFRH_AFRH0   ;Clear the 4 bits that correspond to pin 8.
     ORR R1, R1, #GPIO_AFRH_AFRH0_LCD   ;Set the 4 bits that correspond to pin 8 to [1011].
     STR R1, [R0, #GPIO_AFRH]   ;Store the modified value of R1 back into the higher Alternate Function register. 
     
	ENDP   
	END