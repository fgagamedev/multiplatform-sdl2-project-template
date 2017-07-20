#!/bin/bash
#
# Generates .deb package for Linux
#

# Include project metadata
. metadata.ini

PACKAGE_NAME=$EXECUTABLE_NAME
PACKAGE_VERSION=$VERSION_MAJOR.$VERSION_MINOR-$VERSION_RELEASE
OUTPUT_FILE=$PACKAGE_NAME\_$PACKAGE_VERSION.rpm

function gen_rpm()
{
    # RPM build dir setup
    rpmdev-setuptree

    # Preparing the spec file
    spec_file=$PACKAGE_NAME.spec
    cp dist/linux/redhat/$spec_file ~/rpmbuild/SPECS

    sed -i -- 's/%%PACKAGE_NAME%%/'$PACKAGE_NAME'/' ~/rpmbuild/SPECS/$spec_file
    sed -i -- 's/%%VERSION_MAJOR%%/'$VERSION_MAJOR'/' ~/rpmbuild/SPECS/$spec_file
    sed -i -- 's/%%VERSION_MINOR%%/'$VERSION_MINOR'/' ~/rpmbuild/SPECS/$spec_file
    sed -i -- 's/%%VERSION_RELEASE%%/'$VERSION_RELEASE'/' ~/rpmbuild/SPECS/$spec_file
    sed -i -- 's/%%GAME_DESCRIPTION%%/'"$GAME_DESCRIPTION"'/' ~/rpmbuild/SPECS/$spec_file

    # Launcher script dir
    printf "#!/bin/bash\nexport LD_LIBRARY_PATH=/var/games/$PACKAGE_NAME/lib && cd /var/games/$PACKAGE_NAME/ && ./$EXECUTABLE_NAME\n" > dist/linux/redhat/$EXECUTABLE_NAME

    # Preparing the source package
    tar --transform 's,^,'$PACKAGE_NAME-$VERSION_MAJOR.$VERSION_MINOR'/,' -cvzf ${PACKAGE_NAME}.tar.gz .
    cp ${PACKAGE_NAME}.tar.gz ~/rpmbuild/SOURCES/

    # Build and check the package
    cd ~/rpmbuild/SPECS && rpmbuild -ba $spec_file
    rpmlint $PACKAGE_NAME.rpm

    exit 0
    # Documentation
    share_dir=$tmp_dir/usr/share
    doc_dir=$tmp_dir/usr/share/doc/$PACKAGE_NAME
    mkdir -p $doc_dir

    cp changelog $doc_dir/changelog.Debian
    cp LICENSE $doc_dir/copyright
    gzip -9 $doc_dir/changelog.Debian

    man_dir=$share_dir/man
    section_dir=$man_dir/man6
    mkdir -p $section_dir

    cp dist/linux/debian/$PACKAGE_NAME.6 $section_dir/
    gzip -9 $section_dir/$PACKAGE_NAME.6

 }

echo "Generating "$OUTPUT_FILE "..."
gen_rpm
echo "Done"
