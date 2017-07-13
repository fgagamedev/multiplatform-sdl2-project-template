#!/bin/bash
#
# Generates .exe installer for Windows
#

# Include project metadata
. metadata.ini

OUTPUT_FILE=$PACKAGE_NAME.exe

function gen_exe()
{
	mkdir -p .tmp
	cp -u src/$EXECUTABLE_NAME.exe .tmp/
	cp -u lib/SDL/windows/release/*.dll .tmp/
	cp -u dist/windows/$PACKAGE_NAME.wxs .tmp/
	cp -u dist/windows/Manual.pdf .tmp/

	cd .tmp 
	candle.exe $PACKAGE_NAME.wxs
	light.exe -sice:ICE60 $PACKAGE_NAME.wixobj
	cd ..
}

echo "Generating "$OUTPUT_FILE "..."
gen_exe
echo "Done"
