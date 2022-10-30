/*
Mpho Ramaisa
202002748
CS3520 Assignment 1
October 2022

A program that determines and prints the first 10 reversible prime squares.
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h>

//int RevPrimeSqrs [10];

int num, reverse; 

/*
A function that works out the reverse of a number

set reverse = 0
while num != 0
remainder = last digit of number = num%10
reverse = shift digit to the right and put remainder in position of last digit = reverse*10 + remainder
divide number by 10 then repeat while loop until
*/
int FindReverse(int num){
	int reverse = 0, remainder;
	while(num !=0){
	remainder = num%10;
	reverse = reverse*10 +remainder;
	num/=10;
	}
	
	return reverse;
}

int sqrRoot, revsqrRoot;

//A function that checks if num is a square number
int SqrNum(int num){  
	
	int sqrRoot, revsqrRoot;
	
	if((sqrt(num) == (int) sqrt(num)) && (sqrt(FindReverse(num)) == (int) sqrt(FindReverse(num)))){
		
		sqrRoot = (int) sqrt(num);
		
		revsqrRoot = (int) sqrt(FindReverse(num));
		return 1;               //returns 1 if the number is a square number
		
	}
	else{
		return 0;               //returns 0 if the number is NOT a square number
	}
}

//Afunction that checks whether the square root of a number is a prime
int  NumSqrOfPrime(int num){
	
	sqrRoot = (int) sqrt(num);
	revsqrRoot = (int) sqrt(FindReverse(num));
	
	if (SqrNum(num) == 1){
		
		for(int i = 2; i <sqrRoot; i++){
			if(sqrRoot%i != 0){
				return 1;        	       //returns 1 if the square root of a number is prime
			}
			
			else{
				return 0;                  //returns 0 if the square root of a number is NOT prime
			}
		}
		
	}
}

//A function that checks whether the square root of the reverse of a number is a prime
int  RevSqrOfPrime(int num){
	
	sqrRoot = (int) sqrt(num);
	revsqrRoot = (int) sqrt(FindReverse(num));
	
	if (SqrNum(num) == 1){
		
		for(int i = 2; i <revsqrRoot; i++){
			if(revsqrRoot%i != 0){
				return 1;                    //returns 1 if the square root of the reverse is prime
			}
			
			else{
				return 0;                    //returns 0 if the square root of the reverse is NOT prime
			}
		}
		
	}
}



int main()
{
	printf("T H E   F I R S T   T E N   R E V E R S I B L E   P R I M E   S Q U A R E S\n\n");
	for(int k = 0; k <1025000; k++){
		if(k != FindReverse(k)){
		
			if(NumSqrOfPrime(k) == 1 && RevSqrOfPrime(k) == 1){
			
				printf("%d\n", k);
			}
		}
	}
				
	
	printf("\nB Y E !\n");

	return 0;
}