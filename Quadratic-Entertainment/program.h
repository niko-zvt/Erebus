typedef enum
{ 
    SUCCESS = 0,
    ERROR_INPUT = 1,
    ERROR_OUTPUT = 2,
    ERROR_CALC = 3,
} Result;

void CloseProgram(Result);
Result InputCoefficients(float [], const int);
Result CheckErrors(const unsigned int [], const int, bool);
Result PrintEquation(float [], const int);
Result CalculateEquation(float [], const int);