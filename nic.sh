#!/usr/bin/env bash

# See if user is running as root
if [ "$EUID" == 0 ]; then
    echo "Do not run this script as root."
    exit
fi

# See if DragonBuild actually exists
if ! [ -f "/usr/local/bin/dragon" ]; then
    echo "DragonBuild was not found."
    exit
fi

# See if DragonMake is already in working directory
if [ -f "DragonMake" ]; then
    echo "This directory already has a DragonMake file."
    echo "Please make or go to a new empty directory."
    exit
fi

# Prompts and stuff
echo ""
echo "* | DragonBuild - New Instance Creator"
echo "* | made by quiprr"
echo "*"
echo "* | 1.) Basic tweak"
echo "* | 2.) Basic preferences"
echo ""
read -p "* | > " selection
if ( [ $selection != 1 ] && [ $selection != 2 ]  ) ; then
    echo "$selection is not a valid selection."
    echo "Please re-run the script."
    exit
else
    echo ""
    echo "* | What is the name of your project?"
    read -p "* | > " name
    echo ""
    echo "* | What is the bundle ID of your project? (e.g. com.apple.name)"
    read -p "* | > " bundleid
    echo ""
    echo "* | What is the name of the author?"
    read -p "* | > " author
fi
fi

if [ "$selection" == 1 ]; then 
    # Create DragonMake
    echo "* | Writing files..."
    echo "name: $name" >> DragonMake
    echo "icmd: sbreload" >> DragonMake
    echo "$name:" >> DragonMake
    echo "  type: tweak" >> DragonMake
    echo "  files:" >> DragonMake
    echo "    - Tweak.xm" >> DragonMake
    
    # Create Tweak.xm
    echo "" >> Tweak.xm

    # Create control
    echo "Package: $bundleid" >> control
    echo "Name: $name" >> control
    echo "Version: 0.0.1" >> control
    echo "Architecture: iphoneos-arm" >> control
    echo "Description: This is a description." >> control
    echo "Maintainer: $author" >> control
    echo "Author: $author" >> control
    echo "Section: Tweaks" >> control
    echo "Depends:" >> control
    echo Done!
    exit
fi 

if [ "$selection" == 2 ]; then 
    # Create DragonMake
    echo "* | Writing files..."
    echo "name: $name" >> DragonMake
    echo "icmd: sbreload" >> DragonMake
    echo "$name:" >> DragonMake
    echo "  type: prefs" >> DragonMake
    echo "  files:" >> DragonMake
    echo "    - XXXRootListController.m" >> DragonMake
    echo "    - XXXRootListController.h" >> DragonMake
    echo "    - Root.plist" >> DragonMake

    # Create RootListController.h/m
    echo "" >> XXXRootListController.m
    echo "" >> XXXRootListController.h

    # Create Root.plist
    mkdir Resources
    cd Resources
    echo "<?xml version="1.0" encoding="UTF-8"?>" >> Root.plist
    echo "<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">" >> Root.plist
    echo "<plist version="1.0">" >> Root.plist
    echo "<dict>" >> Root.plist
	echo "    <key>items</key>" >> Root.plist
	echo "        <array>" >> Root.plist
    echo "" >> Root.plist
    echo "        </array>" >> Root.plist
    echo "</dict>" >> Root.plist
    echo "</plist>" >> Root.plist

    # Create Info.plist
    echo "<?xml version="1.0" encoding="UTF-8"?>" >> Info.plist
    echo "<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">" >> Info.plist
    echo "<plist version="1.0">" >> Info.plist
    echo "<dict>" >> Info.plist
	echo "    <key>CFBundleDevelopmentRegion</key>" >> Info.plist
	echo "    <string>English</string>" >> Info.plist
	echo "    <key>CFBundleExecutable</key>" >> Info.plist
	echo "    <string>$name</string>" >> Info.plist
	echo "    <key>CFBundleIdentifier</key>" >> Info.plist
	echo "    <string>$bundleid</string>" >> Info.plist
	echo "    <key>CFBundleInfoDictionaryVersion</key>" >> Info.plist
	echo "    <string>6.0</string>" >> Info.plist
	echo "    <key>CFBundlePackageType</key>" >> Info.plist
	echo "    <string>BNDL</string>" >> Info.plist
	echo "    <key>CFBundleShortVersionString</key>" >> Info.plist
	echo "    <string>0.0.1</string>" >> Info.plist
	echo "    <key>CFBundleSignature</key>" >> Info.plist
	echo "    <string>????</string>" >> Info.plist
	echo "    <key>CFBundleVersion</key>" >> Info.plist
	echo "    <string>1.0</string>" >> Info.plist
	echo "    <key>NSPrincipalClass</key>" >> Info.plist
	echo "    <string>XXXRootListController</string>" >> Info.plist
    echo "</dict>" >> Info.plist
    echo "</plist>" >> Info.plist
    echo Done!
    exit
else
    exit
fi
fi

exit