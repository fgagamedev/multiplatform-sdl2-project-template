#include "game.h"

#include <cstdio>

int run(int argc, char *argv[])
{
    if (argc > 1)
        printf("Hello MacOS with first arg = [%s]\n", argv[1]);
    else
        printf("Hello MacOS without args\n");

    return 0;
}
