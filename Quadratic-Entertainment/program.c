#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdarg.h>
#include "program.h"

int main()
{
    const unsigned int len = 3;
    float abc[len];

    Result result = InputCoefficients(abc, len);
    if(result != SUCCESS)
        CloseProgram(result);

    result = PrintEquation(abc, len);
    if(result != SUCCESS)
        CloseProgram(result);

    result = CalculateEquation(abc, len);
    if(result != SUCCESS)
        CloseProgram(result);

    return 0;
}

Result InputCoefficients(float array[], const int len)
{
    const int charOffset = 65;
    unsigned int results[len];

    for(int i = 0; i < len; i++)
    {
        printf("Enter coefficient %c: ", i + charOffset);
        results[i] = scanf("%f", &(array[i])); 
        printf("Coefficient %c = %.2f\n", i + charOffset, array[i]);
        printf("\n");

        if(results[i] != 1)
           break;
    }

    return CheckErrors(results, len, true);
}

Result CheckErrors(const unsigned int results[], const int len, bool inverse)
{
    int isErrorExist;

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

    if(isErrorExist == inverse)
        return ERROR_INPUT;
    else
        return SUCCESS;
}

Result PrintEquation(float coeff[], const int len)
{
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

    return SUCCESS;
}

Result CalculateEquation(float coeff[], const int len)
{
    // TODO: Implementation
    return SUCCESS;
}

void CloseProgram(Result result)
{
    if(result == SUCCESS)
        ;

    if(result == ERROR_INPUT)
        printf("Input error!\n");

    if (result == ERROR_OUTPUT)
        printf("Output error!\n");

    if (result == ERROR_CALC)
        printf("Calculation error!\n");

    exit(result);
}
