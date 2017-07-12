#include "game.h"
#include "engine.h"

#include "iostream"

using namespace std;

int run(int argc, char *argv[])
{
    if (argc > 1)
        printf("Hello Windows with first arg = [%s]\n", argv[1]);
    else
        printf("Hello Windows without args\n");

    Engine engine;
    printf("Engine start returned %d\n", engine.start());

    return 0;
}
