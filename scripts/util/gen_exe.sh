#!/bin/bash
#
# Generates .exe installer for Windows
#

# Include project metadata
. metadata.ini

OUTPUT_FILE=$EXECUTABLE_NAME.exe
PACKAGE_VERSION=$VERSION_MAJOR.$VERSION_MINOR.$VERSION_RELEASE

function gen_exe()
{
	mkdir -p .tmp
	cp -u src/$EXECUTABLE_NAME\_release .tmp/$OUTPUT_FILE
	cp -u lib/SDL/windows/release/*.dll .tmp/
	cp -u lib/SDL_image/windows/release/*.dll .tmp/
	cp -u lib/SDL_image/windows/release/LICENSE* .tmp/
	cp -f dist/windows/template-test.wxs .tmp/$PACKAGE_NAME.wxs
	cp -u dist/windows/Manual.pdf .tmp/
	cp -ur resources .tmp/

	cd .tmp
    sed -i -- 's/%%OUTPUT_FILE%%/'"$OUTPUT_FILE"'/g' $PACKAGE_NAME.wxs
    sed -i -- 's/%%PACKAGE_NAME%%/'"$PACKAGE_NAME"'/g' $PACKAGE_NAME.wxs
    sed -i -- 's/%%PACKAGE_VERSION%%/'"$PACKAGE_VERSION"'/g' $PACKAGE_NAME.wxs
    sed -i -- 's/%%MAINTAINER_NAME%%/'"$MAINTAINER_NAME"'/g' $PACKAGE_NAME.wxs
    sed -i -- 's/%%GAME_DESCRIPTION%%/'"$GAME_DESCRIPTION"'/g' $PACKAGE_NAME.wxs

	candle.exe $PACKAGE_NAME.wxs
	light.exe -sice:ICE60 -ext WixUIExtension $PACKAGE_NAME.wixobj
	cp $PACKAGE_NAME.msi ..
	cd ..
}

echo "Generating "$OUTPUT_FILE "..."
gen_exe
echo "Done"
