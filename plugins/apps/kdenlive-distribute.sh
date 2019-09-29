#!/bin/bash -xe
# run from mxe root dir after "make kdenlive"
# > plugins/apps/kdenlive-distribute.sh
MXE_DIR=$PWD

VERSION=$(sed -n 's/.*VERSION\s*:=\s*//p' $MXE_DIR/plugins/apps/kdenlive.mk)
INSTALL_DIR=$MXE_DIR/../Kdenlive-$VERSION
echo Installing to $INSTALL_DIR
[ -d $INSTALL_DIR ] && echo "... already exists, delete?" && rm -rI $INSTALL_DIR
mkdir -p $INSTALL_DIR/{bin,lib,share,etc}

MXE_BINDIR=$MXE_DIR/usr/x86_64-w64-mingw32.shared.posix
cd $MXE_BINDIR

echo Copying binaries
cp bin/{kdenlive*.exe,melt.exe,ff*.exe,kioslave5.exe,dbus-daemon.exe,drmingw.exe,catchsegv.exe,*.dll,qtlogging.ini} $INSTALL_DIR/bin
rm $INSTALL_DIR/bin/icu*5*.dll
#cp lib/libdl.dll.a $INSTALL_DIR/bin
cp qt5/bin/*.dll $INSTALL_DIR/bin
cp -r qt5/{plugins/*,qml/*} $INSTALL_DIR/bin
echo Copying data
cp -r bin/data $INSTALL_DIR/bin
# MLT looks for lib & share next to exe on windows
cp -r share/{mlt,ffmpeg,dbus-1} $INSTALL_DIR/share
cp -r etc/{dbus-1,xdg} $INSTALL_DIR/etc
cp -r lib/{mlt,frei0r-1,ladspa} $INSTALL_DIR/lib
cp -r doc/ $INSTALL_DIR/

# Qt finds local data directly in /data, not in /data/kdenlive
mv $INSTALL_DIR/bin/data/kdenlive/* $INSTALL_DIR/bin/data/
rmdir $INSTALL_DIR/bin/data/kdenlive

# Copy KDE's color schemes from system
cp -r /usr/share/color-schemes $INSTALL_DIR/bin/data
# MXE's libwinpthread is broken
#cp /usr/x86_64-w64-mingw32/lib/libwinpthread-1.dll $INSTALL_DIR

#cp $MXE_DIR/tmp-kdenlive*/kdenlive-*/{AUTHORS,COPYING,README} $INSTALL_DIR
if [ -$1 == -z ]
then
    echo "Compressing"
    cd $INSTALL_DIR/..
    7z a $INSTALL_DIR-w64.7z $INSTALL_DIR
    cd $MXE_BINDIR/bin
    7z a $MXE_DIR/../Kdenlive-$VERSION-w64dbg.7z kdenlive.debug
fi

