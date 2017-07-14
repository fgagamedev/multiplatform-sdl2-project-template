#!/bin/bash
#
# Generates .dmg package for MacOS
#

# Include project metadata
. metadata.ini

PACKAGE_NAME=$EXECUTABLE_NAME
OUTPUT_FILE=$PACKAGE_NAME.dmg

function gen_dmg()
{
	base_dir=.dmg/"$PACKAGE_NAME".app/Contents
    macos_dir=$base_dir/MacOS
	mkdir -p $macos_dir
	cp -f src/$EXECUTABLE_NAME\_release $macos_dir/$EXECUTABLE_NAME
    cp -f dist/macos/Info.plist $base_dir

    lib_dir=$base_dir/Frameworks
	mkdir -p $lib_dir

    for extlib in `ls lib`;
    do
        cp -R lib/$extlib/macos/release/* $lib_dir/;
    done
	
    resources_dir=$base_dir/Resources
    mkdir -p $resources_dir

    # Build the .dmg
	#cd .dmg
	#rm -f $OUTPUT_FILE
	#create_dmg --volname "$GAME_TITLE Installer" --window-pos 200 120 --window-size 800 400 --app-drop-link 600 185 $OUTPUT_FILE .
	#cp *.dmg ..
	#cd ..
}

echo "Generating "$OUTPUT_FILE "..."
gen_dmg
echo "Done"
