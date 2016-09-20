/* file: callbacks-procedure.c */

void procedure(void (*callback)(double), double n) {
	callback(n * 3);
}
