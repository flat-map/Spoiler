
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
