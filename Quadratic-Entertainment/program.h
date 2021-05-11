#ifndef PROGRAM_H
#define PROGRAM_H

/* Enumeration the types of results */
typedef enum
{ 
    SUCCESS = 0,
    ERROR_INPUT = 1,
    ERROR_OUTPUT = 2,
    ERROR_CALC = 3,
} Result;

/* User input function */
Result InputCoefficients(float [], const int);

/* User input function */
Result CheckErrors(const unsigned int [], const int, const bool);

/* Function for printing the equation according to formatting */
Result PrintEquation(float [], const int);

/* Function for printing the equation roots */
Result PrintRoots(float [], const bool);

/* Function for solving an equation from an array of coefficients */
Result SolveEquation(float [], const int, const float);

/* Function for solving linear equation */
Result SolveLinearEquation(const float, const float, float []);

/* Function for solving quadratic equation */
Result SolveQuadraticEquation(const float, const float, const float, float [], bool *);

/* The function of closing the program with error handling */
void CloseProgram(Result);

/* The function waits for any key to be pressed */
void PressAnyKey();

#endif /* PROGRAM_H */