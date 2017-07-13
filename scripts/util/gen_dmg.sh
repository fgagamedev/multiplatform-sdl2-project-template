#!/bin/bash
#
# Generates .dmg package for MacOS
#

# Include project metadata
. metadata.ini

OUTPUT_FILE=$PACKAGE_NAME.dmg

function gen_dmg()
{
	base_dir=.dmg/"$PACKAGE_NAME"
	mkdir -p $base_dir	
	cp -f src/$EXECUTABLE_NAME_release $base_dir/$EXECUTABLE_NAME
	
    lib_dir=$base_dir/Frameworks
	mkdir -p $lib_dir

    for extlib in `ls lib`;
    do
        cp -R lib/$extlib/macos/release/* $lib_dir/;
    done
	
	cd .dmg
	rm -f $OUTPUT_FILE
	create_dmg --volname "$GAME_TITLE Installer" --window-pos 200 120 --window-size 800 400 --app-drop-link 600 185 $OUTPUT_FILE .
	cp *.dmg ..
	cd ..
}

echo "Generating "$OUTPUT_FILE "..."
gen_dmg
echo "Done"
