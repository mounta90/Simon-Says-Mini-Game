#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <time.h>
#include "SS_Functions.h"
#include "stm32l476xx.h"

void show_level_0(void);
void play_level_0(int* instrs_to_play);

void show_level_1(void);
void play_level_1(int* instrs_to_play);

void show_level_2(void);
void play_level_2(int* instrs_to_play);

void show_level_3(void);
void play_level_3(int* instrs_to_play);

void show_level_4(void);
void play_level_4(int* instrs_to_play);

void show_level_5(void);
void play_level_5(int* instrs_to_play);

void show_level_6(void);
void play_level_6(int* instrs_to_play);

void show_level_7(void);
void play_level_7(int* instrs_to_play);

void show_level_8(void);
void play_level_8(int* instrs_to_play);

void show_level_9(void);
void play_level_9(int* instrs_to_play);

void show_level_10(void);
void play_level_10(int* instrs_to_play);

void won_the_game(void);

enum jButton{
    center = 0x0001,
    left = 0x0002,
    right = 0x0004,
    up = 0x0008,
    down = 0x0020 
};



int main(){

    //display Main Menu forever until center button is pressed.
    while((GPIOA->IDR & center) == 0 ){

        //display Main Menu

    }

    //if the center button is pressed, the while loop is exited, and game begins.
    show_level_0();

    return 0;
}




void show_level_0(){
    
    int instrs_to_show[3];
    int instrs_to_play[3];
    
    get_instrs_to_show(instrs_to_show, 3);
    get_instrs_to_play_and_LCD_show_instrs(instrs_to_show, instrs_to_play, 3);

    play_level_0(instrs_to_play);


}

void play_level_0(int* instrs_to_play){
     
    int played_instrs[10];

    GPIOE->ODR &= ~(GPIO_ODR_ODR_8);   //Reset GPIOE pin 8 (GREEN LED)
    GPIOB->ODR &= ~(GPIO_ODR_ODR_2);   //Reset GPIOB pin 2 (RED LED)

    
    while( (GPIOA->IDR & center) == 0 ){
        fill_array_with_instructions(played_instrs, 10);
    }
    
    int num_elementsToCheck = sizeof(instrs_to_play)/sizeof(instrs_to_play[0]);

    if(Check_If_Arrays_Match(played_instrs, instrs_to_play, num_elementsToCheck)){   //If arrays match, the player passed the level.
        FlashGreenLED();
        show_level_1();                                         //The player goes onto the next level.
    }                                                           
    else{
        FlashRedLED();                                                       //If the arrays don't match,
        show_level_0();                                         //that means the player made a mistake.
    }                                                           //He repeats the level, because its tutorial.

}







void show_level_1(){

    int instrs_to_show[6];
    int instrs_to_play[6];

    get_instrs_to_show(instrs_to_show, 6);
    get_instrs_to_play_and_LCD_show_instrs(instrs_to_show, instrs_to_play, 6);

    play_level_1(instrs_to_play);

}

void play_level_1(int* instrs_to_play){
     
    int played_instrs[15];

    while( (GPIOA->IDR & center) == 0 ){
        fill_array_with_instructions(played_instrs, 15);
    }

    int num_elementsToCheck = sizeof(instrs_to_play)/sizeof(instrs_to_play[0]);

    if(Check_If_Arrays_Match(played_instrs, instrs_to_play, num_elementsToCheck)){
        FlashGreenLED();
        show_level_2();
    }else{
        FlashRedLED();
        show_level_1();
    }

}









void show_level_2(){
    
    int instrs_to_show[6];
    int instrs_to_play[6];

    get_instrs_to_show(instrs_to_show, 6);
    get_instrs_to_play_and_LCD_show_instrs(instrs_to_show, instrs_to_play, 6);

    play_level_2(instrs_to_play);

}

void play_level_2(int* instrs_to_play){
 
    int played_instrs[15];

    while( (GPIOA->IDR & center) == 0 ){
        fill_array_with_instructions(played_instrs, 15);
    }

    int num_elementsToCheck = sizeof(instrs_to_play)/sizeof(instrs_to_play[0]);

    if(Check_If_Arrays_Match(played_instrs, instrs_to_play, num_elementsToCheck)){
        FlashGreenLED();
        show_level_3();
    }else{
        FlashRedLED();
        show_level_1();
    }

}





void show_level_3(){
    
    int instrs_to_show[9];
    int instrs_to_play[9];

    get_instrs_to_show(instrs_to_show, 9);
    get_instrs_to_play_and_LCD_show_instrs(instrs_to_show, instrs_to_play, 9);

    play_level_3(instrs_to_play);

}

void play_level_3(int* instrs_to_play){
 
    int played_instrs[18];

    while( (GPIOA->IDR & center) == 0 ){
        fill_array_with_instructions(played_instrs, 18);
    }

    int num_elementsToCheck = sizeof(instrs_to_play)/sizeof(instrs_to_play[0]);

    if(Check_If_Arrays_Match(played_instrs, instrs_to_play, num_elementsToCheck)){
        FlashGreenLED();
        show_level_4();
    }else{
        FlashRedLED();
        show_level_1();
    }


}





void show_level_4(){

    int instrs_to_show[9];
    int instrs_to_play[9];

    get_instrs_to_show(instrs_to_show, 9);
    get_instrs_to_play_and_LCD_show_instrs(instrs_to_show, instrs_to_play, 9);

    play_level_4(instrs_to_play);

}

void play_level_4(int* instrs_to_play){
 
    int played_instrs[18];

    while( (GPIOA->IDR & center) == 0 ){
        fill_array_with_instructions(played_instrs, 18);
    }

    int num_elementsToCheck = sizeof(instrs_to_play)/sizeof(instrs_to_play[0]);

    if(Check_If_Arrays_Match(played_instrs, instrs_to_play, num_elementsToCheck)){
            FlashGreenLED();
            show_level_5();
    }else{
            FlashRedLED();
            show_level_1();
    }

}





void show_level_5(){

    int instrs_to_show[12];
    int instrs_to_play[12];

    get_instrs_to_show(instrs_to_show, 12);
    get_instrs_to_play_and_LCD_show_instrs(instrs_to_show, instrs_to_play, 12);

    play_level_5(instrs_to_play);

}

void play_level_5(int* instrs_to_play){

    int played_instrs[24];

    while( (GPIOA->IDR & center) == 0 ){
        fill_array_with_instructions(played_instrs, 24);
    }

    int num_elementsToCheck = sizeof(instrs_to_play)/sizeof(instrs_to_play[0]);

    if(Check_If_Arrays_Match(played_instrs, instrs_to_play, num_elementsToCheck)){
        FlashGreenLED();
        show_level_6();
    }else{
        FlashRedLED();
        show_level_1();
    }

}





void show_level_6(){
    
    int instrs_to_show[12];
    int instrs_to_play[12];

    get_instrs_to_show(instrs_to_show, 12);
    get_instrs_to_play_and_LCD_show_instrs(instrs_to_show, instrs_to_play, 12);

    play_level_6(instrs_to_play);

}

void play_level_6(int* instrs_to_play){

    int played_instrs[24];

    while( (GPIOA->IDR & center) == 0 ){
        fill_array_with_instructions(played_instrs, 24);
    }

    int num_elementsToCheck = sizeof(instrs_to_play)/sizeof(instrs_to_play[0]);

    if(Check_If_Arrays_Match(played_instrs, instrs_to_play, num_elementsToCheck)){
        FlashGreenLED();
        show_level_7();
    }else{
        FlashRedLED();
        show_level_1();
    }

}





void show_level_7(){

    int instrs_to_show[15];
    int instrs_to_play[15];

    get_instrs_to_show(instrs_to_show, 15);
    get_instrs_to_play_and_LCD_show_instrs(instrs_to_show, instrs_to_play, 15);

    play_level_7(instrs_to_play);

}

void play_level_7(int* instrs_to_play){

    int played_instrs[30];

    while( (GPIOA->IDR & center) == 0 ){
        fill_array_with_instructions(played_instrs, 30);
    }

    int num_elementsToCheck = sizeof(instrs_to_play)/sizeof(instrs_to_play[0]);

    if(Check_If_Arrays_Match(played_instrs, instrs_to_play, num_elementsToCheck)){
        FlashGreenLED();
        show_level_8();
    }else{
        FlashRedLED();
        show_level_1();
    }

}






void show_level_8(){

    int instrs_to_show[15];
    int instrs_to_play[15];

    get_instrs_to_show(instrs_to_show, 15);
    get_instrs_to_play_and_LCD_show_instrs(instrs_to_show, instrs_to_play, 15);

    play_level_8(instrs_to_play);

}

void play_level_8(int* instrs_to_play){

    int played_instrs[30];

    while( (GPIOA->IDR & center) == 0 ){
        fill_array_with_instructions(played_instrs, 30);
    }

    int num_elementsToCheck = sizeof(instrs_to_play)/sizeof(instrs_to_play[0]);

    if(Check_If_Arrays_Match(played_instrs, instrs_to_play, num_elementsToCheck)){
        FlashGreenLED();
        show_level_9();
    }else{
        FlashRedLED();
        show_level_1();
    }

}





void show_level_9(){

    int instrs_to_show[20];
    int instrs_to_play[20];

    get_instrs_to_show(instrs_to_show, 20);
    get_instrs_to_play_and_LCD_show_instrs(instrs_to_show, instrs_to_play, 20);

    play_level_9(instrs_to_play);

}

void play_level_9(int* instrs_to_play){

    int played_instrs[30];

    while( (GPIOA->IDR & center) == 0 ){
        fill_array_with_instructions(played_instrs, 30);
    }

    int num_elementsToCheck = sizeof(instrs_to_play)/sizeof(instrs_to_play[0]);

    if(Check_If_Arrays_Match(played_instrs, instrs_to_play, num_elementsToCheck)){
        FlashGreenLED();
        show_level_10();
    }else{
        FlashRedLED();
        show_level_1();
    }


}





void show_level_10(){

    int instrs_to_show[25];
    int instrs_to_play[25];

    get_instrs_to_show(instrs_to_show, 25);
    get_instrs_to_play_and_LCD_show_instrs(instrs_to_show, instrs_to_play, 25);

    play_level_10(instrs_to_play);

}

void play_level_10(int* instrs_to_play){

    int played_instrs[35];

    while( (GPIOA->IDR & center) == 0 ){
        fill_array_with_instructions(played_instrs, 35);
    }

    int num_elementsToCheck = sizeof(instrs_to_play)/sizeof(instrs_to_play[0]);

    if(Check_If_Arrays_Match(played_instrs, instrs_to_play, num_elementsToCheck)){
        FlashGreenLED();
        won_the_game();
    }else{
        FlashRedLED();
        show_level_1();
    }
}



void won_the_game(){
    
	//display end LCD
	
}


