	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s

	AREA myDATA, DATA
		
GPIO_AFRL_AFRL6_LCD	EQU 0x0B000000
GPIO_AFRL_AFRL7_LCD	EQU 0xB0000000
			
GPIO_AFRH_AFRH0_LCD	EQU 0x0000000B
GPIO_AFRH_AFRH1_LCD	EQU 0x000000B0
GPIO_AFRH_AFRH2_LCD	EQU 0x00000B00
GPIO_AFRH_AFRH7_LCD	EQU 0xB0000000

	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY

__main	PROC

	 ;The joystick setup requires configuration of pins 0,1,2,3,5 of port A.
     ;The LCD setup requires configuration of pins 6,7,8,9,10,15 of port A.
     

     ;(LCD) Set mode of GPIOA pins 6,7,8,9,10,15 to 'alternate function' [10].
	 ;(joystick) Set mode of GPIOA pins 0,1,2,3,5 to 'input' [00].
     LDR R0, =GPIOA_BASE    ;Load in R0, the base address of GPIO port A.
     LDR R1, [R0, #GPIO_MODER]  ;Load in R1, the base address of GPIOA offsetted by the constant (#GPIO_MODER) to get to the mode register of GPIOA.
	 LDR R2, =(GPIO_MODER_MODER0 :OR: GPIO_MODER_MODER1 :OR: GPIO_MODER_MODER2 :OR: GPIO_MODER_MODER3 :OR: GPIO_MODER_MODER5 :OR: GPIO_MODER_MODER6 :OR: GPIO_MODER_MODER7 :OR: GPIO_MODER_MODER8 :OR: GPIO_MODER_MODER9 :OR: GPIO_MODER_MODER10 :OR: GPIO_MODER_MODER15)	;Load in R2, 32 bits in which the corresponding 2 bits to pins 0,1,2,3,5,6,7,8,9,10,15 are set to [11]. We will use this for clearing.
	 BIC R1, R1, R2	;We will clear the R1 bits of pins 0,1,2,3,5,6,7,8,9,10,15 using R2. This will also set pins 0,1,2,3,5 to 'input' mode at the same time.
	 LDR R3, =(GPIO_MODER_MODER6_1 :OR: GPIO_MODER_MODER7_1 :OR: GPIO_MODER_MODER8_1 :OR: GPIO_MODER_MODER9_1 :OR: GPIO_MODER_MODER10_1 :OR: GPIO_MODER_MODER15_1)	;Load in R3, 32 bits in which the corresponding 2 bits to pins 6,7,8,9,10,15 are set to [10].
	 ORR R1, R1, R3	;Set the 2 bits corresponding to pins 6,7,8,9,10,15 of R1 to [10] by ORing with R3.
	 STR R1, [R0, #GPIO_MODER]	;Store the modified value of R1 back into the Mode register of GPIOA.
      


	;(joystick) Set the pins 0,1,2,3,5 to 'pull-down' [10].
	;(LCD) Set the pins 6,7,8,9,10,15 to 'no pull-up/pull-down' [00].
    LDR R1, [R0, #GPIO_PUPDR]   ;Load in R1 the base address of GPIOA offsetted by the constant (#GPIO_PUPDR) to get to the bits of the PUPDR register of GPIOA.
    LDR R2, =(GPIO_PUPDR_PUPDR0 :OR: GPIO_PUPDR_PUPDR1 :OR: GPIO_PUPDR_PUPDR2 :OR: GPIO_PUPDR_PUPDR3 :OR: GPIO_PUPDR_PUPDR5 :OR: GPIO_PUPDR_PUPDR6 :OR: GPIO_PUPDR_PUPDR7 :OR: GPIO_PUPDR_PUPDR8 :OR: GPIO_PUPDR_PUPDR9 :OR: GPIO_PUPDR_PUPDR10 :OR: GPIO_PUPDR_PUPDR15)    ;Load in R2 the the bit values [11] in the place of pins 0,1,2,3,5,6,7,8,9,10,15. This will at the same time set pins 6,7,8,9,10,15 to 'no pull-up/pull-down'. This register will be used in clearing.
    BIC R1, R1, R2  ;Use R2 to mask R1, which will clear the bits that correspond to pins 0,1,2,3,5,6,7,8,9,10,15.
    LDR R3, =(GPIO_PUPDR_PUPDR0_1 :OR: GPIO_PUPDR_PUPDR1_1 :OR: GPIO_PUPDR_PUPDR2_1 :OR: GPIO_PUPDR_PUPDR3_1 :OR: GPIO_PUPDR_PUPDR5_1)  ;Load in R3 the bits [10] in the places corresponding to the pins 0,1,2,3,5.
    ORR R1, R1, R3  ;Use R3 to set the bits of R1, that correspond to the pins 0/1/2/3/5, to 'pull-down' [10].
    STR R1, [R0, #GPIO_PUPDR]   ;Store the modified value of R1 back into the PUPDR register of GPIOA.


	;Set the speed of pins 6,7,8,9,10,15 to 'fast' [10].
	LDR R1, [R0, #GPIO_OSPEEDR]		;Load in R1, the base address of GPIOA offsetted by the constant (#GPIO_OSPEEDR) to get to the OSPEED register.
	LDR R2, =(GPIO_OSPEEDER_OSPEEDR6 :OR: GPIO_OSPEEDER_OSPEEDR7 :OR: GPIO_OSPEEDER_OSPEEDR8 :OR: GPIO_OSPEEDER_OSPEEDR9 :OR: GPIO_OSPEEDER_OSPEEDR10 :OR: GPIO_OSPEEDER_OSPEEDR15)	;Load in R2, 32 bits in which each 2 bits that correspond to pins 6,7,8,9,10,15 are set to [11]. This will be used in clearing.
	BIC R1, R1, R2	;Clear the bits that correspond to pins 6,7,8,9,10,15 by using R2.
	LDR R3, =(GPIO_OSPEEDER_OSPEEDR6_1 :OR: GPIO_OSPEEDER_OSPEEDR7_1 :OR: GPIO_OSPEEDER_OSPEEDR8_1 :OR: GPIO_OSPEEDER_OSPEEDR9_1 :OR: GPIO_OSPEEDER_OSPEEDR10_1 :OR: GPIO_OSPEEDER_OSPEEDR15_1)		;Load in R3, 32 bits in which the corresponding bits of pins 6,7,8,9,10,15 are set to [10]. This register will be used in setting.
	ORR R1, R1, R3	;Set the bits that correspond to pins 6,7,8,9,10,15 in R1 to [10] by ORing with R3.
	STR R1, [R0, #GPIO_OSPEEDR]		;Store the modified value of R1 back into the OSPEED register.



	;(LCD) Set function of pins 6,7,8,9,10,15 to 'LCD' [1011] or 0xB in the Alternate Function register.
	LDR R1, [R0, #GPIO_AFRL]	;Load in R1, the base address of GPIOA offsetted by the constant (#GPIO_AFRL) to get to the lower 32 bits of the 64 bit Alternate Function register. This has pins 0-7.
	LDR R2, =(GPIO_AFRL_AFRL6 :OR: GPIO_AFRL_AFRL7)	;Load in R2, 32 bits in which the corresponding 4 bits to pins 6,7 are set to [1111]. This will be used in clearing.
	BIC R1, R1, R2	;Clear the 4 bits that correspond to pins 6,7 using R2.
	LDR R3, =(GPIO_AFRL_AFRL6_LCD :OR: GPIO_AFRL_AFRL7_LCD)	;Load in R3, the 32 bits in which the corresponding 4 bits to pins 6,7 are set to [1011]. This will be used in setting.
	ORR R1, R1, R3	;Set the 4 bits that correspond to pins 6,7 to [1011] by ORing with R3.
	STR R1, [R0, #GPIO_AFRL]	;Store the modified value of R1 back into the lower Alternate Function register of GPIOA. This takes care of pins 6 and 7.


	LDR R1, [R0, #GPIO_AFRH]	;Load in R1, the base address of GPIOA offsetted by the constant (#GPIO_AFRH) to get to the higher 32 bits of the 64 bit Alternate Function register. This has pins 8-15.
	LDR R2, =(GPIO_AFRH_AFRH0 :OR: GPIO_AFRH_AFRH1 :OR: GPIO_AFRH_AFRH2 :OR: GPIO_AFRH_AFRH7)	;Load in R2, 32 bits in which the corresponding bits to pins 8,9,10,15 are set to [1111]. This register will be used to clear.
	BIC R1, R1, R2	;Clear the bits that correspond to pins 8,9,10,15 of R1, using R2.
	LDR R3, =(GPIO_AFRH_AFRH0_LCD :OR: GPIO_AFRH_AFRH1_LCD :OR: GPIO_AFRH_AFRH2_LCD :OR: GPIO_AFRH_AFRH7_LCD)	;Load in R3, 32 bits in which the corresponding 4 bits to pins 8,9,10,15 are set to [1011]. This register will be used in setting.
	ORR R1, R1, R3	;Set the bits that correspond to pins 8,9,10,15 to [1011] by ORing with R3.
	STR R1, [R0, #GPIO_AFRH]	;Store the modified value of R1 back into the higher 32 bits of the Alternate Function register. This takes care of pins 8,9,10,15.

	ENDP
	END