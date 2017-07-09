#ifndef ENGINE_H
#define ENGINE_H

#include <iostream>
#include <memory>

using namespace std;

class pImplEngine;

class Engine {
public:
    Engine();
    ~Engine();

    int start();

private:
    unique_ptr<pImplEngine> pImp;
};

#endif
