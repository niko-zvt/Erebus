#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdarg.h>
#include <conio.h>
#include "program.h"

/// The main function
int main()
{
    // Initializing the main parameters
    const unsigned int len = 3;
    const float tolerance = 0.001;
    float abc[len];

    // User input
    Result result = InputCoefficients(abc, len);
    if(result != SUCCESS)
        CloseProgram(result);

    // Print equation
    result = PrintEquation(abc, len);
    if(result != SUCCESS)
        CloseProgram(result);

    // Solving the equation
    result = SolveEquation(abc, len, tolerance);
    if(result != SUCCESS)
        CloseProgram(result);

    // Press any key for exit
    PressAnyKey("Press any key to close it.");
    return result;
}

/// User input function
Result InputCoefficients(float array[], const int len)
{
    // ASCII table offset for defining the 'A' character
    const int charOffset = 65;

    // Results of scanf operations
    unsigned int results[len];
    for(int i = 0; i < len; i++)
    {
        printf("Enter coefficient %c: ", i + charOffset);
        results[i] = scanf("%f", &(array[i])); 
        printf("Coefficient %c = %.2f\n", i + charOffset, array[i]);
        printf("\n");

        // If the input stream contains several digits
        // or less than one, abort the input
        if(results[i] != 1)
           break;
    }

    // Returning input results after error checking
    return CheckErrors(results, len, true);
}

/// Error checking function
Result CheckErrors(const unsigned int results[], const int len, const bool inverse)
{
    // Flag for checking the existence of an error
    int isErrorExist = 0;

    // Inversion of the check, required for local error detection.
    // If the flag is set, the error is 1, otherwise 0
    if(inverse == true)
        isErrorExist = !results[0];
    else
        isErrorExist = results[0];
  
    // Traverse the array compute OR
    for (int i = 0; i < len; ++i)
    {
        if(inverse == true)
            isErrorExist = (isErrorExist | !results[i]);
        else
            isErrorExist = (isErrorExist | results[i]);
    }

    // Return result
    if(isErrorExist == inverse)
        return ERROR_INPUT;
    else
        return SUCCESS;
}

/// Function for printing the equation according to formatting
Result PrintEquation(float coeff[], const int len)
{
    // Printing an equation with the signs taken into account

    const float zero = 0.0f;
    
    for(int i = 0; i < len; ++i)
    {
        float number = zero;
        char sign = '+';
        
        if(coeff[i] < 0)
        {   
            sign = '-';
            number = -coeff[i];
        }
        else
        {
            sign = '+';
            number = coeff[i];
        }

        printf(" %c ", sign);
        printf("%.2f * x^%d", number, (len - 1) - i);
    }

    printf(" = %.2f\n", zero);
    printf("\n");

    return SUCCESS;
}

/// Function for printing the equation roots
Result PrintRoots(float roots[], const bool isComplex)
{
    // TODO: Implementation
    return SUCCESS;
}

/// Function for solving an equation from an array of coefficients
Result SolveEquation(float coeff[], const int len, const float linearTolerance)
{
    // Result
    Result result = ERROR_CALC;

    // If the degree of the equation is not 3, then return the error
    if(len != 3)
        return result;

    // Coefficients of the equation
    const float A = coeff[0];
    const float B = coeff[1];
    const float C = coeff[2];
    
    // Roots of the equation
    float roots[] = {0, 0};
    bool isComplex = false;

    // If the coefficient for the quadratic term is zero
    // (according to the specified tolerance)
    // then solve the linear equation
    if(A <= linearTolerance)
        result = SolveLinearEquation(B, C, roots);
    else
        result = SolveQuadraticEquation(A, B, C, roots, &isComplex);

    // Print roots of the equation
    PrintRoots(roots, isComplex);

    // Return result
    return result;
}

/// Function for solving linear equation
Result SolveLinearEquation(const float k, const float b, float roots[])
{
    // TODO: Implementation
    return SUCCESS;
}

/// Function for solving quadratic equation
Result SolveQuadraticEquation(const float a, const float b, const float c, float roots[], bool * isComplex)
{
    // TODO: Implementation
    return SUCCESS;
}

/// The function of closing the program with error handling
void CloseProgram(Result result)
{
    // Closing the program with error handling
    if(result == SUCCESS)
        ;

    if(result == ERROR_INPUT)
        printf("Input error!\n");

    if (result == ERROR_OUTPUT)
        printf("Output error!\n");

    if (result == ERROR_CALC)
        printf("Calculation error!\n");

    PressAnyKey("Press any key to close it.");
    exit(result);
}

/// The function waits for any key to be pressed
void PressAnyKey(const char * string)
{
    // Press any key
    printf("%s\n", string);  
    int kbhit(void);
    getch();
}
