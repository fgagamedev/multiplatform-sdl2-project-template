#include <SDL.h>
#include <SDL_image.h>
#include <fstream>
#include <cstdlib>

using namespace std;

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
    	cerr << "Can't initialize SDL video: " << SDL_GetError() << endl;
    else
    {
        printf("Loading image...\n");

        auto path = resources_dir_path() + "images/logo.png";
        auto *img = IMG_Load(path.c_str());
        
        if (img == NULL)
        {
            cerr << "Can't load logo image:" << SDL_GetError() << endl;
        } else
        {
            SDL_Rect r;
            r.x = (screen->w - img->w)/2;
            r.y = (screen->h - img->h)/2;
            r.w = img->w;
            r.h = img->h;

            SDL_BlitSurface(img, NULL, screen, &r);
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

				SDL_Flip(screen);
                SDL_Delay(2);
                ++tries;
            }
        }
    }

    return 0;
}
