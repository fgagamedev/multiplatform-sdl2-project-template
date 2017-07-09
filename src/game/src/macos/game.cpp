#include "game.h"
#include "engine.h"

#include <cstdio>

int run(int argc, char *argv[])
{
    if (argc > 1)
        printf("Hello Linux with first arg = [%s]\n", argv[1]);
    else
        printf("Hello Linux without args\n");

    Engine engine;
    printf("Engine start returned %d\n", engine.start());

    return 0;
}
