/* file: fib.c */

int fib_c(int num)
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
