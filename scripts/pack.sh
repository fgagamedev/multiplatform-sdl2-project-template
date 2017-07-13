#!/bin/bash
#
# Identify the platform and run the matching Makefile
#

project=test
package_major=1
package_minor=0
package_release=2
package_version=$package_major.$package_minor-$package_release
package_name=$project\_$package_version

function gen_deb()
{
    echo "Generating $package_name.deb..."

    # Build dir
    tmp_dir=/tmp/$package_name
    rm -rf $tmp_dir
    mkdir -p $tmp_dir

    # Data dir: resources, scripts and executable
    var_dir=$tmp_dir/var
    data_dir=$var_dir/games
    install_dir=$data_dir/$project
    mkdir -p $install_dir

    cp src/$project\_release $install_dir/$project

    lib_dir=$install_dir/lib
    mkdir -p $lib_dir

    for extlib in `ls lib`;
    do
        cp -P lib/$extlib/linux/release/* $lib_dir;
    done

    resources_dir=$install_dir/resources
    mkdir -p $resources_dir

    cp -r resources/* $resources_dir/

    # Launcher script dir
    usr_dir=$tmp_dir/usr
    exec_dir=$usr_dir/games
    mkdir -p $exec_dir

    printf "#!/bin/bash\nexport LD_LIBRARY_PATH=/var/games/$project/lib && cd /var/games/$project/ && ./$project" > $exec_dir/$project

    # Debian package info dir
    mkdir -p $tmp_dir/DEBIAN
    cp dist/linux/debian/control $tmp_dir/DEBIAN/

    # Documentation
    share_dir=$tmp_dir/usr/share
    doc_dir=$tmp_dir/usr/share/doc/$project
    mkdir -p $doc_dir

    cp changelog $doc_dir/changelog.Debian
    cp LICENSE $doc_dir/copyright
    gzip -9 $doc_dir/changelog.Debian

    man_dir=$share_dir/man
    section_dir=$man_dir/man6
    mkdir -p $section_dir

    cp dist/linux/debian/$project.6 $section_dir/
    gzip -9 $section_dir/$project.6

    # Set the permissions
    scripts/util/set_permissions.sh $tmp_dir
    chmod 755 $exec_dir/$project
    chmod 755 $install_dir/$project

    # Build and check the package
    fakeroot dpkg-deb --build $tmp_dir
    mv /tmp/$package_name.deb .
    lintian $package_name.deb

    echo "Done"
}

function gen_win()
{
	mkdir -p .tmp
	cp -u src/$project.exe .tmp/
	cp -u lib/SDL/windows/release/*.dll .tmp/
	cp -u dist/windows/$project.wxs .tmp/
	cp -u dist/windows/Manual.pdf .tmp/

	cd .tmp 
	candle.exe $project.wxs
	light.exe -sice:ICE60 $project.wixobj
	cd ..
}

function gen_dmg()
{
	base_dir=.dmg/Test
	mkdir -p $base_dir	
	cp -f src/$project $base_dir
	
	mkdir -p $base_dir/Frameworks
	cp -R lib/SDL/macos/release/* $base_dir/Frameworks
	
	cd .dmg
	rm -f $project.dmg
	create_dmg --volname "Test Installer" --window-pos 200 120 --window-size 800 400 --app-drop-link 600 185 $project.dmg .
	cp *.dmg ..
	cd ..
}

function pack()
{
    platform=`uname -a`

    if [[ "$platform" =~ "Linux" ]];
    then
        gen_deb;
    elif [[ "$platform" =~ "Darwin" ]];
	then
    	gen_dmg;	
    else
        gen_win;
    fi
}

# Main
pack
