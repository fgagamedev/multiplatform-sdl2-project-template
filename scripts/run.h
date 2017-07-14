#!/bin/bash
#
# Identify the platform and run the matching Makefile
#

mode=$1
. metadata.ini

game=test

function run_linux()
{
    rm -rf bin/linux
    mkdir -p bin/linux
    ln -f src/$EXECUTABLE_NAME\_$mode bin/linux

    dirs=`ls -d lib/*/`

    for dir in $dirs;
    do
        cp -P $dir"linux/"$mode/* bin/linux/
    done;

    LD_LIBRARY_PATH=bin/linux bin/linux/$EXECUTABLE_NAME\_$mode
}

function run_macos()
{
	mkdir -p bin/macos
	ln -f src/$game bin/macos
	
	mkdir -p bin/macos/Frameworks
	cp -r lib/SDL/macos/release/SDL.framework bin/macos/Frameworks/
	bin/macos/$game
}

function run()
{
    platform=`uname -a`

    if [[ "$platform" =~ "Linux" ]];
    then
        run_linux
    elif [[ "$platform" =~ "Darwin" ]];
	then
    	run_macos
    else
        platform="windows";
    fi
}

# Main
case $mode in
    "release")
        echo "Running the release version..."
        run
        ;;

    "debug")
        echo "Running the debug version..."
        run
        ;;

    *)
        echo "Usage: run.sh [debug|release]"
        exit 1
esac
