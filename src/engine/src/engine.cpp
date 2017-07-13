#include <SDL.h>

#include "engine.h"

class pImplEngine {
public:
    pImplEngine(bool started = false) : m_started(started) {}

    bool m_started;
};

Engine::Engine()
    : pImp(new pImplEngine())
{
}

Engine::~Engine()
{
    SDL_Quit();
}

int
Engine::start()
{
    int rc = SDL_Init(SDL_INIT_VIDEO);
    pImp->m_started = (rc == 0);

    SDL_Surface *screen = SDL_SetVideoMode(640, 480, 32, SDL_DOUBLEBUF);
    
    if (screen == NULL)
    	fprintf(stderr, "Can't initialize SDL video: %s\n", SDL_GetError());
    else
    {
    	printf("Screen pointer = %p\n", screen);	
    	SDL_Delay(2000);
    }

    return 0;
}
