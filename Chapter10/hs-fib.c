/* file: hs-fib.c */

#include <HsFFI.h>

int fib_c(HsInt num)
{
    if (num <= 2)
    {
        return 1;
    }
    else
    {
        return(fib_c(num - 1) + fib_c(num - 2));
    }
}

