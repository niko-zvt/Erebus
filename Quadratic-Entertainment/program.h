// ====================================================================================
// Quadratic (Entertainment) Equation
// Shameless assembler in C. Just needs more speed.
// ====================================================================================

#ifndef PROGRAM_H
#define PROGRAM_H

/* Enumeration the types of results */
typedef enum
{ 
    SUCCESS = 0,
    ERROR_INPUT = 1,
    ERROR_OUTPUT = 2,
    ERROR_CALC = 3,
    ERROR_DIV_BY_ZERO = 4,
} Result;

/* User input function */
Result InputCoefficients(float [], const int);

/* User input function */
Result CheckErrors(const unsigned int [], const int, const bool);

/* Function for printing the equation according to formatting */
Result PrintEquation(float [], const int);

/* Function for printing the equation roots */
Result PrintRoots(const float [], const bool, const bool, const float);

/* Function for solving an equation from an array of coefficients */
Result SolveEquation(float [], const int, const float, const bool);

/* Function for solving linear equation */
Result SolveLinearEquation(const float, const float, const float, float []);

/* Function for solving quadratic equation */
Result SolveQuadraticEquation(const float, const float, const float, const float, float [], bool *);

/* Function for comparing a number with zero */
bool IsZero(const float, const float);

/* The function of closing the program with error handling */
void CloseProgram(Result);

/* The function waits for any key to be pressed */
void PressAnyKey();

/* The function outputs information about the program */
void PrintIntro();

#endif /* PROGRAM_H */
