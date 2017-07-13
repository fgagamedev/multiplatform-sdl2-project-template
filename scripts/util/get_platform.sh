#!/bin/bash
#
# Retorns the current platform
#

platform=`uname -a`

if [[ "$platform" =~ "Linux" ]];
then
    echo "linux";
elif [[ "$platform" =~ "Darwin" ]];
then
    echo "macos";
else
    echo "windows";
fi
