# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := rttr
$(PKG)_WEBSITE  := https://github.com/rttrorg/rttr
$(PKG)_DESCR    := Run Time Type Reflection library written in C++
$(PKG)_VERSION  := 0.9.6
$(PKG)_CHECKSUM := 058554f8644450185fd881a6598f9dee7ef85785cbc2bb5a5526a43225aa313f
$(PKG)_GH_CONF  := rttrorg/rttr/releases/latest
$(PKG)_URL_2    := https://github.com/rttrorg/rttr/archive/v$($(PKG)_VERSION).tar.gz
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
		-DBUILD_EXAMPLES=OFF -DBUILD_DOCUMENTATION=OFF \
		-DBUILD_UNIT_TESTS=OFF -DBUILD_PACKAGE=OFF -DBUILD_STATIC=ON
    $(MAKE) -C '$(BUILD_DIR)' -j $(JOBS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
