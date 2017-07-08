#!/bin/bash
#
# Identify the platform and run the matching Makefile
#

mode=$1

function build()
{
    platform=`uname -a`

    #echo $platform

    if [[ "$platform" =~ "Linux" ]];
    then
        platform="linux";
    else
        platform="unknown";
    fi

    #echo $platform

    make -f Makefile.$platform MODE=$mode
}

# Main
case $mode in
    "release")
        echo "Building the release version..."
        build
        ;;

    "debug")
        echo "Building the debug version..."
        build
        ;;

    *)
        echo "Usage: build.sh [debug|release]"
        exit 1
esac
