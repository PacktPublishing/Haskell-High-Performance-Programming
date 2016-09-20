/* file: dyn_fun_export.c */

#include <stdio.h>
#include <dlfcn.h>

int main(int argc, char *argv[]) {
	void *dl = dlopen("./libfunexport.so", RTLD_LAZY);
	void (*hs_init)(int *argc, char **argv[]) = dlsym(dl, "hs_init");
	hs_init(&argc, &argv);
	int (*fun)(int a, int b) = dlsym(dl, "fun");
	printf("%d\n", fun(1, 2));
}

