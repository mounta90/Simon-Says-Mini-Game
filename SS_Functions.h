#ifndef SS_FUNCTIONS_H
#define SS_FUNCTIONS_H



bool Check_If_Arrays_Match(int* arr1, int* arr2, int arrSize);

void fill_array_with_instructions(int* arr, int arrSize);

void get_instrs_to_show(int* instrs_to_show, int arrSize);

void get_instrs_to_play_and_LCD_show_instrs(int* instrs_to_show, int* instrs_to_play, int arrSize);

float get_random_probability(void);

int get_random_number_0to3(void);

void FlashGreenLED(void);

void FlashRedLED(void);



#endif
