#include <SDL.h>
#include <SDL_image.h>

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

    auto *screen = SDL_SetVideoMode(800, 600, 32, SDL_DOUBLEBUF);
    
    if (screen == NULL)
    	fprintf(stderr, "Can't initialize SDL video: %s\n", SDL_GetError());
    else
    {
        printf("Loading image...\n");

        auto *img = IMG_Load("resources/images/logo.jpg");

        if (img == NULL)
            printf("Can't load logo image: %s\n", SDL_GetError());
        else
        {
            SDL_Rect r;
            r.x = (screen->w - img->w)/2;
            r.y = (screen->h - img->h)/2;
            r.w = img->w;
            r.h = img->h;

            SDL_BlitSurface(img, NULL, screen, &r);
            SDL_Flip(screen);

            SDL_FreeSurface(img);

            SDL_Delay(2000);

            SDL_Event event;
            int tries = 0;

            while (tries < 1000)
            {
                while (SDL_PollEvent(&event))
                {
                    switch (event.type) {
                    case SDL_QUIT:
                        return 0;

                    case SDL_KEYDOWN:
                        return 0;
                    }
                }

                SDL_Delay(2);
                ++tries;
            }
        }
    }

    return 0;
}
