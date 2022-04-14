#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <time.h>
#include "stm32l476xx.h"

enum jButton{
    center = 0x0001,
    left = 0x0002,
    right = 0x0004,
    up = 0x0008,
    down = 0x0020 
};

bool Check_If_Arrays_Match(int* arr1, int* arr2, int arrSize){

    for(int i = 0; i < arrSize; i++){
        if (arr1[i] != arr2[i]){
            return 0;
        }
    }
    return 1;
}

void fill_array_with_instructions(int* arr, int arrSize){


    for(int i = 0; i < arrSize; i++){

        while(arr[i] == 0){

            if ( ((GPIOA->IDR & left) | (GPIOA->IDR & right) | (GPIOA->IDR & up) | (GPIOA->IDR & down)) != 0 ){
                arr[i] = GPIOA->IDR;
                FlashGreenLED();
            }

        }

    }

}

void get_instrs_to_show(int* instrs_to_show, int arrSize){

    int arr_of_instrs[] = {left, right, up, down};

    for(int i = 0; i < arrSize; i++){

        int rand_num = get_random_number_0to3();
        instrs_to_show[i] = arr_of_instrs[rand_num];

    }

}

void get_instrs_to_play_and_LCD_show_instrs(int* instrs_to_show, int* instrs_to_play, int arrSize){

    int index = 0;

    for(int i = 0; i < arrSize; i++){

        if(get_random_probability() >= 0.25){
            FlashGreenLED();
            //display instrs_to_show[i] on LCD.
            instrs_to_play[index] = instrs_to_show[i];
            index++;
        }
        else{
            //display instrs_to_show[i] on LCD.
        }

    }

}

float get_random_probability(){
    
    srand(time(NULL));

    float randNumber = ((float)rand() / RAND_MAX);  //random number between 0 and 1

    return randNumber;

}

int get_random_number_0to3(){
    
    srand(time(NULL));

    int randNumber = ((float)rand() / RAND_MAX) * 4;  //random number between 0 and 3

    return randNumber;

}

void FlashGreenLED(){
    GPIOE->ODR |= GPIO_ODR_ODR_8;
    GPIOE->ODR &= ~(GPIO_ODR_ODR_8);
}

void FlashRedLED(){
    GPIOB->ODR |= GPIO_ODR_ODR_2;
    GPIOB->ODR &= ~(GPIO_ODR_ODR_2);
}