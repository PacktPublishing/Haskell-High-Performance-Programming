/* file: fun_export.c */

#include <stdio.h>
#include "FunExport_stub.h"

int main(int argc, char *argv[]) {
	hs_init(&argc, &argv);
	printf("%d\n", fun(1, 2));
}
