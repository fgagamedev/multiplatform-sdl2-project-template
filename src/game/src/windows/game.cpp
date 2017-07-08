#include "game.h"

#include "iostream"

using namespace std;

int run(int argc, char *argv[])
{
    if (argc > 1)
        printf("Hello Windows with first arg = [%s]\n", argv[1]);
    else
        printf("Hello Windows without args\n");

    return 0;
}
