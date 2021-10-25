#
# Copyright (C) 2021 Bobby
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI support for tcpdump
LUCI_DESCRIPTION:=LuCI interface for tcpdump
LUCI_DEPENDS:=+tcpdump
LUCI_PKGARCH:=all

PKG_NAME:=luci-app-tcpdump
PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature