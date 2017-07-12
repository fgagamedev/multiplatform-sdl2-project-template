#!/bin/bash
#
# Identify the platform and run the matching Makefile
#

project=test
package_major=1
package_minor=0
package_release=1
package_version=$package_major.$package_minor-$package_release
package_name=$project\_$package_version

function gen_deb()
{
    # Build dir
    tmp_dir=/tmp/$package_name
    rm -rf $tmp_dir
    mkdir -p $tmp_dir

    # Data dir: resources, scripts and executable
    var_dir=$tmp_dir/var
    mkdir -p $var_dir
    chmod 755 $var_dir

    data_dir=$var_dir/games
    mkdir -p $data_dir
    chmod 755 $data_dir

    install_dir=$data_dir/$project
    mkdir -p $install_dir
    chmod 755 $install_dir

    cp -P src/$project\_release $install_dir/$project
    chmod 755 $install_dir/*

    mkdir -p $install_dir/lib
    chmod 755 $install_dir/lib

    cp -P lib/SDL/linux/release/* $install_dir/lib
    chmod 0644 $install_dir/lib/*

    # Launcher script dir
    usr_dir=$tmp_dir/usr
    mkdir -p $usr_dir
    chmod 755 $usr_dir

    exec_dir=$usr_dir/games
    mkdir -p $exec_dir
    chmod 755 $exec_dir

    echo "export LD_LIBRARY_PATH=/opt/$project/lib && cd /opt/$project && ./$project" > $exec_dir/$project
    chmod 755 $exec_dir/$project

    # Debian package info dir
    mkdir -p $tmp_dir/DEBIAN
    cp dist/linux/debian/control $tmp_dir/DEBIAN/

    # Documentation
    share_dir=$tmp_dir/usr/share
    mkdir -p $share_dir
    chmod 755 $share_dir

    doc_dir=$tmp_dir/usr/share/doc/$project
    mkdir -p $share_dir/doc
    chmod 755 $share_dir/doc
    mkdir -p $doc_dir
    chmod 755 $doc_dir

    cp changelog $doc_dir/changelog.Debian
    chmod 644 $doc_dir/changelog.Debian

    cp LICENSE $doc_dir/copyright
    chmod 644 $doc_dir/copyright

    gzip -9 $doc_dir/changelog.Debian

    # Build the package
    fakeroot dpkg-deb --build $tmp_dir
    mv /tmp/$package_name.deb .
    lintian $package_name.deb
}

function pack()
{
    platform=`uname -a`

    if [[ "$platform" =~ "Linux" ]];
    then
        echo "Generating $package_name.deb...";
        gen_deb;
        echo "Done";
    elif [[ "$platform" =~ "Darwin" ]];
	then
    	platform="macos";	
    else
        platform="windows";
    fi
}

# Main
pack
