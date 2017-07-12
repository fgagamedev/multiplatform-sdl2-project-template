#!/bin/bash
#
# Identify the platform and run the matching Makefile
#

mode=$1
game=test

function run_linux()
{
    mkdir -p bin/linux
    ln -f src/$game\_$mode bin/linux
    ln -f lib/SDL/linux/$mode/lib* bin/linux/
    bin/linux/$game\_$mode
}

function run()
{
    platform=`uname -a`

    if [[ "$platform" =~ "Linux" ]];
    then
        run_linux
    elif [[ "$platform" =~ "Darwin" ]];
	then
    	platform="macos";	
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
