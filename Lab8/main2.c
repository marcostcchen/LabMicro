#include <stdio.h>
#include <string.h>				

extern int int2str(int inteiro, char* pontstr);
					
int main()
{
	int NUSP = 9833065;
	char str[16];

	int2str(NUSP, str);
	puts(str);
	return (0);
}
