# This file is part of MXE. See LICENSE.md for licensing information.
PKG             := kirigami2
$(PKG)_VERSION  := 5.62.0
$(PKG)_CHECKSUM  := b3cc36bddb5e52617075961b2cbaecbb94492523bcc6801a3ad29a35c43bd912
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_HOME     := https://download.kde.org/stable/frameworks
$(PKG)_URL      := $($(PKG)_HOME)/$(basename $($(PKG)_VERSION))/$($(PKG)_FILE)
$(PKG)_DEPS     := qtbase qtsvg qtdeclarative qtquickcontrols2 extra-cmake-modules \
	breeze-icons kpackage

define $(PKG)_UPDATE
    $(WGET) -q -O- https://download.kde.org/stable/frameworks/ | \
    $(SED) -n 's,.*\([0-9]\+\.[0-9]\+\)/.*,\1.0,p' | \
	tail -1
endef

define $(PKG)_BUILD
    mkdir "$(1)/build"
    cd "$(1)/build" && cmake .. \
        -DCMAKE_TOOLCHAIN_FILE="$(CMAKE_TOOLCHAIN_FILE)" \
        -DCMAKE_CROSSCOMPILING=ON \
        -DKF5_HOST_TOOLING=/usr/lib/x86_64-linux-gnu/cmake \
        -DKCONFIGCOMPILER_PATH=/usr/lib/x86_64-linux-gnu/cmake/KF5Config/KF5ConfigCompilerTargets.cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
        -DBUILD_TESTING=OFF
    $(MAKE) -C "$(1)/build" -j $(JOBS) install
endef
