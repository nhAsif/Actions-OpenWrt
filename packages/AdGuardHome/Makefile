# SPDX-License-Identifier: GPL-3.0-only
#
# Copyright (C) 2024
#
# This is free software, licensed under the GPL-3.0-only.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=adguardhome
PKG_VERSION:=0.107.55
PKG_RELEASE:=1

# 根据架构设置下载文件的后缀
ifeq ($(ARCH),mipsel)
	ADGUARD_ARCH:=linux_mipsle_softfloat
endif
ifeq ($(ARCH),mips)
	ADGUARD_ARCH:=linux_mips_softfloat
endif
ifeq ($(ARCH),mips64)
	ADGUARD_ARCH:=linux_mips64_softfloat
endif
ifeq ($(ARCH),mips64el)
	ADGUARD_ARCH:=linux_mips64le_softfloat
endif
ifeq ($(ARCH),arm)
	ADGUARD_ARCH:=linux_armv5
endif
ifeq ($(ARCH),armv6)
	ADGUARD_ARCH:=linux_armv6
endif
ifeq ($(ARCH),armv7)
	ADGUARD_ARCH:=linux_armv7
endif
ifeq ($(ARCH),arm64)
	ADGUARD_ARCH:=linux_arm64
endif
ifeq ($(ARCH),aarch64)
	ADGUARD_ARCH:=linux_arm64
endif
ifeq ($(ARCH),i386)
	ADGUARD_ARCH:=linux_386
endif
ifeq ($(ARCH),x86_64)
	ADGUARD_ARCH:=linux_amd64
endif
ifeq ($(ARCH),ppc64le)
	ADGUARD_ARCH:=linux_ppc64le
endif
ifeq ($(ARCH),riscv64)
	ADGUARD_ARCH:=linux_riscv64
endif

PKG_LICENSE:=GPL-3.0-only
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=YourName <yourname@example.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/AdguardTeam/AdGuardHome/releases/download/v$(PKG_VERSION)
PKG_SOURCE:=AdGuardHome_$(ADGUARD_ARCH).tar.gz
PKG_HASH:=skip

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=AdGuard Home - Network-wide ads & trackers blocking DNS server
	DEPENDS:=@(i386||x86_64||arm||aarch64||mipsel||mips||mips64||mips64el||ppc64le||riscv64)
	URL:=https://github.com/AdguardTeam/AdGuardHome
endef

define Package/$(PKG_NAME)/description
  AdGuard Home is a network-wide ads and trackers blocking DNS server.
endef

define Build/Prepare
	[ ! -f $(PKG_BUILD_DIR)/$(PKG_SOURCE) ] && wget $(PKG_SOURCE_URL)/$(PKG_SOURCE) -O $(PKG_BUILD_DIR)/$(PKG_SOURCE)
	tar -xzvf $(PKG_BUILD_DIR)/$(PKG_SOURCE) -C $(PKG_BUILD_DIR)
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin/AdGuardHome
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/AdGuardHome/AdGuardHome $(1)/usr/bin/AdGuardHome/AdGuardHome
endef

$(eval $(call BuildPackage,$(PKG_NAME)))