#!/bin/bash
#
# Identify the platform and run the matching Makefile
#

# Main
platform=`scripts/util/get_platform.sh`

case $platform in
    "linux")
        scripts/util/gen_deb.sh
        ;;

    "windows")
        scripts/util/gen_exe.sh
        ;;

    "macos")
        scripts/util/gen_dmg.sh
        ;;

    *)
        echo "Invalid platform! ("$platform")"
        exit 1
esac
