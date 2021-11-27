<<<<<<< HEAD
#include <stdio.h>

void bubbleSort(int array[], int array_size) {
    int i, j, k;

    for (i = 0; i < (array_size - 1); i++) {
        for (j = (array_size - 1); j > i; j--) {
            if (array[j] < array[j - 1]) {
                k = array[j];
                array[j] = array[j - 1];
                array[j - 1] = k;
            }
        }
    }
}

int main(void) {

    int i;
    int array[10] = {3, 6, 1, 7, 2, 0, 4, 5, 9, 8};

    printf("       array: ");
    for (i = 0; i < sizeof(array) / sizeof(array[0]); i++) {
        printf("%d ", array[i]);
    }
    printf("\n");

    bubbleSort(array, sizeof(array) / sizeof(array[0]));

    printf("sorted array: ");
    for (i = 0; i < sizeof(array) / sizeof(array[0]); i++) {
        printf("%d ", array[i]);
    }
    printf("\n");

    return 0;
}
=======

/* quicksort program */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>

void init_rand( int* array , int length ){
    int i;
    for( i = 0; i < length; i++ ){
        array[i] = rand() % 100 + 1;
    }
}

void swap_int( int* a , int* b ){
    int temp = *a;
    *a = *b;
    *b = temp;
}

void quick_sort( int* array , int left , int right ){
    int pivot;
    int i;
    int j;
    int tmp;

    if( left < right ){
        // set pivot to center of array
        pivot = array[ (left+right)/2 ];

        i = left - 1;
        j = right + 1;
        while(1){
            while( array[++i] < pivot );
            while( array[--j] > pivot );
            if( i >= j )    break;
            swap_int( &array[i] , &array[j] );
        }
        quick_sort( array , left , i-1 );
        quick_sort( array , j+1, right );
    }
}

int main( int args , char** argv ){
    
    int array_length = atoi( argv[1] );
    srand( (unsigned)time(NULL) );

    int* array = (int*)malloc( sizeof(int) * array_length );
    if( array == NULL ) return -1;

    init_rand( array , array_length );

    int i;

    printf("Brefore\n");
    for( i = 0; i < array_length; i++ ){
        printf( "%3d," , array[i] );
    }
    printf("\n");

    quick_sort( array , 0 , array_length - 1 );

    printf("After\n");
    for( i = 0; i < array_length; i++ )
        printf( "%3d," , array[i] );
    printf("\n");
    
    free(array);
    return 0;
}
>>>>>>> 85991138c769389aa20ca00727d8c845f36fb304
